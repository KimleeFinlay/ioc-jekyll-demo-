# Define build arguments
ARG USER_UID=1001
ARG USER_GID=1001
ARG USERNAME=myuser

# Set environment variables
ENV USER_UID=$USER_UID
ENV USER_GID=$USER_GID
ENV USERNAME=$USERNAME

# Install dependencies and create the non-root user
RUN apt-get update && apt-get install -y \
    git \
    make \
    build-essential \
    ruby \
    ruby-dev \
    && groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get install -y sudo \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME