# Use Alpine as the base image
FROM alpine:3.14

# Install bash and other dependencies using apk
RUN apk add --no-cache \
    bash \
    curl \
    sudo \
    tar

# Set the GitHub Actions runner version as an environment variable
ENV RUNNER_VERSION=2.283.1

# Download and extract the GitHub Actions runner
RUN curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && rm actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# Add a new user and grant sudo privileges
RUN adduser -D runneruser && echo "runneruser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the new user
USER runneruser

# Set the working directory
WORKDIR /home/runneruser/actions-runner

# Set the entry point to bash
CMD ["/bin/bash"]
