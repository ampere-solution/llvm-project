#!/usr/bin/env python3
"""
A test update script.  This script is a utility to update LLVM 'llvm-mc' based test cases with new FileCheck patterns.
"""

from __future__ import print_function

import argparse
import os  # Used to advertise this file's name ("autogenerated_note").

from UpdateTestChecks import common

import subprocess
import re

mc_LIKE_TOOLS = [
    "llvm-mc",
    "not llvm-mc",
]
ERROR_RE = re.compile(r":\d+: (warning|error): .*")
ERROR_CHECK_RE = re.compile(r"# COM: .*")
OUTPUT_SKIPPED_RE = re.compile(r"(.text)")
COMMENT = {"asm": "//", "dasm": "#"}


def invoke_tool(exe, cmd_args, testline, verbose=False):
    if isinstance(cmd_args, list):
        args = [applySubstitutions(a, substitutions) for a in cmd_args]
    else:
        args = cmd_args

    cmd = 'echo "' + testline + '" | ' + exe + " " + args
    if verbose:
        print("Command: ", cmd)
    out = subprocess.check_output(cmd, shell=True)
    # Fix line endings to unix CR style.
    return out.decode().replace("\r\n", "\n")


# create tests line-by-line, here we just filter out the check lines and comments
# and treat all others as tests
def isTestLine(input_line, mc_mode):
    line = input_line.strip()
    # Skip empty and comment lines
    if not line or line.startswith(COMMENT[mc_mode]):
        return False
    # skip any CHECK lines.
    elif common.CHECK_RE.match(input_line):
        return False
    return True


def hasErr(err):
    return err and ERROR_RE.search(err) is not None


def getErrString(err):
    if not err:
        return ""

    # take the first match
    for line in err.splitlines():
        s = ERROR_RE.search(line)
        if s:
            return s.group(0)
    return ""


def getOutputString(out):
    if not out:
        return ""
    output = ""

    for line in out.splitlines():
        if OUTPUT_SKIPPED_RE.search(line):
            continue
        if line.strip("\t ") == "":
            continue
        output += line.lstrip("\t ")
    return output


def should_add_line_to_output(input_line, prefix_set, mc_mode):
    # special check line
    if mc_mode == "dasm" and ERROR_CHECK_RE.search(input_line):
        return False
    else:
        return common.should_add_line_to_output(
            input_line, prefix_set, comment_marker=COMMENT[mc_mode]
        )


def getStdCheckLine(prefix, output, mc_mode):
    o = ""
    for line in output.splitlines():
        o += COMMENT[mc_mode] + " " + prefix + ": " + line + "\n"
    return o


def getErrCheckLine(prefix, output, mc_mode):
    return COMMENT[mc_mode] + " " + prefix + ": " + ":[[@LINE-1]]" + output + "\n"


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--llvm-mc-binary",
        default=None,
        help='The "mc" binary to use to generate the test case',
    )
    parser.add_argument(
        "--tool",
        default=None,
        help="Treat the given tool name as an mc-like tool for which check lines should be generated",
    )
    parser.add_argument(
        "--default-march",
        default=None,
        help="Set a default -march for when neither triple nor arch are found in a RUN line",
    )
    parser.add_argument("tests", nargs="+")
    initial_args = common.parse_commandline_args(parser)

    script_name = os.path.basename(__file__)

    for ti in common.itertests(
        initial_args.tests, parser, script_name="utils/" + script_name
    ):
        if ti.path.endswith(".s"):
            mc_mode = "asm"
        elif ti.path.endswith(".txt"):
            mc_mode = "dasm"
        else:
            common.warn("Expected .s and .txt, Skipping file : ", ti.path)
            continue

        triple_in_ir = None
        for l in ti.input_lines:
            m = common.TRIPLE_IR_RE.match(l)
            if m:
                triple_in_ir = m.groups()[0]
                break

        run_list = []
        for l in ti.run_lines:
            if "|" not in l:
                common.warn("Skipping unparsable RUN line: " + l)
                continue

            commands = [cmd.strip() for cmd in l.split("|")]
            assert len(commands) >= 2
            mc_cmd = " | ".join(commands[:-1])
            filecheck_cmd = commands[-1]
            mc_tool = mc_cmd.split(" ")[0]

            # special handling for negating exit status
            if mc_tool == "not":
                mc_tool = mc_tool + " " + mc_cmd.split(" ")[1]

            triple_in_cmd = None
            m = common.TRIPLE_ARG_RE.search(mc_cmd)
            if m:
                triple_in_cmd = m.groups()[0]

            march_in_cmd = ti.args.default_march
            m = common.MARCH_ARG_RE.search(mc_cmd)
            if m:
                march_in_cmd = m.groups()[0]

            common.verify_filecheck_prefixes(filecheck_cmd)

            mc_like_tools = mc_LIKE_TOOLS[:]
            if ti.args.tool:
                mc_like_tools.append(ti.args.tool)
            if mc_tool not in mc_like_tools:
                common.warn("Skipping non-mc RUN line: " + l)
                continue

            if not filecheck_cmd.startswith("FileCheck "):
                common.warn("Skipping non-FileChecked RUN line: " + l)
                continue

            mc_cmd_args = mc_cmd[len(mc_tool) :].strip()
            mc_cmd_args = mc_cmd_args.replace("< %s", "").replace("%s", "").strip()
            check_prefixes = common.get_check_prefixes(filecheck_cmd)

            run_list.append(
                (
                    check_prefixes,
                    mc_tool,
                    mc_cmd_args,
                    triple_in_cmd,
                    march_in_cmd,
                )
            )

        # find all test line from input
        testlines = [l for l in ti.input_lines if isTestLine(l, mc_mode)]
        run_list_size = len(run_list)
        testnum = len(testlines)

        raw_output = []
        raw_prefixes = []
        for (
            prefixes,
            mc_tool,
            mc_args,
            triple_in_cmd,
            march_in_cmd,
        ) in run_list:
            common.debug("Extracted mc cmd:", mc_tool, mc_args)
            common.debug("Extracted FileCheck prefixes:", str(prefixes))
            common.debug("Extracted triple :", str(triple_in_cmd))
            common.debug("Extracted march:", str(march_in_cmd))

            triple = triple_in_cmd or triple_in_ir
            if not triple:
                triple = common.get_triple_from_march(march_in_cmd)

            raw_output.append([])
            for line in testlines:
                # get output for each testline
                out = invoke_tool(
                    ti.args.llvm_mc_binary or mc_tool,
                    mc_args,
                    line,
                    verbose=ti.args.verbose,
                )
                raw_output[-1].append(out)

            common.debug("Collect raw tool lines:", str(len(raw_output[-1])))

            raw_prefixes.append(prefixes)

        output_lines = []
        generated_prefixes = []
        used_prefixes = set()
        prefix_set = set([prefix for p in run_list for prefix in p[0]])
        common.debug("Rewriting FileCheck prefixes:", str(prefix_set))

        for test_id in range(testnum):
            input_line = testlines[test_id]

            # a {prefix : output, [runid] } dict
            # insert output to a prefix-key dict, and do a max sorting
            # to select the most-used prefix which share the same output string
            p_dict = {}
            for run_id in range(run_list_size):
                out = raw_output[run_id][test_id]

                if hasErr(out):
                    o = getErrString(out)
                else:
                    o = getOutputString(out)

                prefixes = raw_prefixes[run_id]

                for p in prefixes:
                    if p not in p_dict:
                        p_dict[p] = o, [run_id]
                    else:
                        if p_dict[p] == (None, []):
                            continue

                        prev_o, run_ids = p_dict[p]
                        if o == prev_o:
                            run_ids.append(run_id)
                            p_dict[p] = o, run_ids
                        else:
                            # conflict, discard
                            p_dict[p] = None, []

            p_dict_sorted = dict(
                sorted(p_dict.items(), key=lambda item: -len(item[1][1]))
            )

            # prefix is selected and generated with most shared output lines
            # each run_id can only be used once
            gen_prefix = ""
            used_runid = set()
            for prefix, tup in p_dict_sorted.items():
                o, run_ids = tup

                if len(run_ids) == 0:
                    continue

                skip = False
                for i in run_ids:
                    if i in used_runid:
                        skip = True
                    else:
                        used_runid.add(i)
                if not skip:
                    used_prefixes.add(prefix)

                    if hasErr(o):
                        gen_prefix += getErrCheckLine(prefix, o, mc_mode)
                    else:
                        gen_prefix += getStdCheckLine(prefix, o, mc_mode)

            generated_prefixes.append(gen_prefix.rstrip("\n"))

        # write output
        prefix_id = 0
        for input_info in ti.iterlines(output_lines):
            input_line = input_info.line
            if isTestLine(input_line, mc_mode):
                output_lines.append(input_line)
                output_lines.append(generated_prefixes[prefix_id])
                prefix_id += 1

            elif should_add_line_to_output(input_line, prefix_set, mc_mode):
                output_lines.append(input_line)

            elif input_line in ti.run_lines or input_line == "":
                output_lines.append(input_line)

        if ti.args.gen_unused_prefix_body:
            output_lines.extend(
                ti.get_checks_for_unused_prefixes(run_list, used_prefixes)
            )

        common.debug("Writing %d lines to %s..." % (len(output_lines), ti.path))
        with open(ti.path, "wb") as f:
            f.writelines(["{}\n".format(l).encode("utf-8") for l in output_lines])


if __name__ == "__main__":
    main()