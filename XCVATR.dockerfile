# Use a base image with a suitable Linux distribution (e.g., Ubuntu)
FROM ubuntu:latest

# Set the working directory
WORKDIR /app

# Install necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    tar \
    make \
    autoconf \
    automake \
    gcc \
    g++ \
    zlib1g-dev \
    git

# Download and install Samtools
RUN wget https://sourceforge.net/projects/samtools/files/latest/download?source=files -O samtools.tar.bz2 \
    && tar -xvjf samtools.tar.bz2 \
    && samtools_dir=$(find . -name 'samtools-*' | xargs -Ifiles basename files) \
    && cd ${samtools_dir} \
    && ./configure --without-curses --disable-lzma \
    && make \
    && make install

# Clone the XCVATR repository
RUN git clone https://github.com/harmancilab/XCVATR.git

# Set the working directory to the XCVATR directory
WORKDIR /app/XCVATR

# Build XCVATR
RUN make clean && make