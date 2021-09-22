FROM alpine:3

LABEL maintainer="Mark Caudill <mark@mrkc.me>"

ENV TF_VERSION=1.0.7
ENV TF_ZIP=terraform_${TF_VERSION}_linux_amd64.zip
ENV TF_DOWNLOAD_URL=https://releases.hashicorp.com/terraform/${TF_VERSION}/${TF_ZIP}

RUN wget -q ${TF_DOWNLOAD_URL} && \
	unzip ${TF_ZIP} -d /usr/local/bin && \
	rm ${TF_ZIP} && \
	terraform -version

ENTRYPOINT ["terraform"]
