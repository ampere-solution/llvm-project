# Dockerfile 
FROM ubuntu:22.04 

# Install dependencies 
RUN apt-get update && apt-get install -y \ 
build-essential \ 
cmake \ 
ninja-build \ 
git \ 
python3  && rm -rf /var/lib/apt/lists/* 

# Clone LLVM project 
RUN git clone https://github.com/ampere-solution/llvm-project.git /llvm-project

# Set up build directory 
WORKDIR /llvm-project
RUN mkdir build && cd build && \ 
cmake -G Ninja \ 
  -DLLVM_ENABLE_PROJECTS="clang" \
  -DLLVM_ENABLE_RUNTIMES="libunwind;libcxx;libcxxabi" \
  -DLLVM_TARGETS_TO_BUILD="AArch64;X86" \
  -DCMAKE_BUILD_TYPE=Release \
  -DLLVM_ENABLE_ASSERTIONS=ON \
  ../llvm
# Build LLVM 
RUN cd build && ninja 
#RUN cd build && make -j$(nproc) 

# Set LLVM binaries in PATH 
ENV PATH="/llvm-project/build/bin:${PATH}" 

# Entry point to check installation 
ENTRYPOINT ["/bin/bash"]
