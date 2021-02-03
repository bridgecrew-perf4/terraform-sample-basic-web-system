FROM ubuntu:latest

ENV ROOT_PATH /root
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY

WORKDIR /var/tmp
RUN apt-get update && \
    apt-get install -y wget \
                       curl \
                       unzip \
                       python3.8 \
                       python3.8-distutils && \
    wget "https://releases.hashicorp.com/terraform/0.14.5/terraform_0.14.5_linux_amd64.zip" && \
    unzip terraform_0.14.5_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    wget "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"  && \
    unzip awscli-exe-linux-x86_64.zip && \
    ./aws/install  && \
    wget "https://bootstrap.pypa.io/get-pip.py" && \
    python3.8 get-pip.py && \
    rm -f terraform_0.14.5_linux_amd64.zip \
          awscli-exe-linux-x86_64.zip \
          get-pip.py

WORKDIR ${ROOT_PATH}
COPY tool/.aws/config ${ROOT_PATH}/.aws/
COPY tool/.aws/credentials ${ROOT_PATH}/.aws/
RUN sed -i "s/REPLACE_ACCESS_KEY/${AWS_ACCESS_KEY_ID}/g" ${ROOT_PATH}/.aws/credentials && \
    sed -i "s/REPLACE_SECURITY_KEY/${AWS_SECRET_ACCESS_KEY}/g" ${ROOT_PATH}/.aws/credentials && \
    echo "export SECRET_KEY_BASE=${SECRET_KEY_BASE}" >> ${ROOT_PATH}/.bash_profile

WORKDIR /app
COPY . ${WORKDIR}
