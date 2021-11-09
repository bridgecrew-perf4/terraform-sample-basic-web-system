FROM amazon/aws-cli:2.2.43

ENV ROOT_PATH /root
ARG AWS_SECRET_KEY
ARG AWS_SECRET_ACCESS_KEY

RUN yum update -y && \
    # aws configure set default.aws_access_key_id AKIA5SM2T2P2E3MP7WVU && \
    aws configure set default.aws_access_key_id ${AWS_SECRET_ACCESS_KEY} && \
    # aws configure set default.aws_secret_access_key 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 && \
    aws configure set default.aws_secret_access_key ${AWS_SECRET_KEY}} && \
    aws configure set default.region ap-northeast-1 && \
    aws configure set default.output json && \
    aws configure set profile.switch-role-to-system-admin.role_arn arn:aws:iam::932869034996:role/system-admin && \
    aws configure set profile.switch-role-to-system-admin.source_profile default

ENTRYPOINT ["/bin/sh", "-c", "while :; do sleep 10; done"]
