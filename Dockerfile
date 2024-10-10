# Use the official Ubuntu base image
FROM ubuntu:22.04

# Set environment variables to ensure the container runs in non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install necessary packages including Ansible
RUN apt-get update && \
    apt-get install -y \
    bash \
    coreutils \
    bash-completion \
    curl \ 
    nano \
    man \
    iputils-ping \
    software-properties-common \
    lsb-release && \
    # Add Ansible PPA and install Ansible
    add-apt-repository ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y ansible && \
    # Clean up to reduce image size
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a directory for Ansible configuration and playbooks
WORKDIR /ansible

RUN ln -sf /bin/bash /bin/sh
RUN useradd -ms /bin/bash  start
# Copy the Ansible playbook and any inventory files into the container
COPY ./* /ansible/

RUN ansible-playbook playbook.yml || exit 1
RUN rm -rf /ansible
EXPOSE 8080
USER start
WORKDIR /home/start
# Run the Ansible playbook
CMD ["sleep", "infinity"]
