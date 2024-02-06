FROM ubuntu:22.04
RUN apt update && \
    apt install -y curl sudo && \
    adduser benjamin && \
    echo "benjamin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER benjamin
WORKDIR /home/benjamin
RUN mkdir actions-runner
WORKDIR /home/benjamin/actions-runner
COPY actions-runner-linux-x64-2.311.0.tar.gz .
RUN tar xzf ./actions-runner-linux-x64-2.311.0.tar.gz 
RUN sudo ./bin/installdependencies.sh 
RUN ./config.sh --unattended --url https://github.com/MelkiBenjamin/github-action-test --token BCKZTMFQUTDW2EU4AJHPSZLFUPBDO
CMD ["./run.sh"]