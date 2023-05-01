# run image that runs as root (default ubuntu:jammy username)
FROM ubuntu:jammy AS run-image

ARG cnb_uid=1000
ARG cnb_gid=1000
ARG stack_id="io.buildpacks.stacks.jericop.jammy"
ARG target_id="jericop.jammy"

# run image that runs as cnb username
FROM run-image AS run-cnb

RUN groupadd cnb --gid ${cnb_gid} \
  && useradd --uid ${cnb_uid} --gid ${cnb_gid} -m -s /bin/bash cnb

ENV CNB_USER_ID=${cnb_uid}
ENV CNB_GROUP_ID=${cnb_gid}

USER ${cnb_uid}:${cnb_gid}

# cnb run image with the stack id label
FROM run-cnb as run-cnb-stack
LABEL io.buildpacks.stack.id=${stack_id}

# cnb run image with the new [target] id label and stack label for backward compatibility
FROM run-cnb as run-cnb-target
LABEL io.buildpacks.stack.id=${stack_id}
LABEL io.buildpacks.id=${target_id}

# build image that runs as root (default ubuntu:jammy username)
FROM run-image AS build-image

# install some general purpose utilities for shell-based buildpacks to use
RUN <<EOF
apt-get update
apt-get install -y \
  curl \
  jq \
  unzip
apt-get clean all

YJ_URL=https://github.com/sclevine/yj/releases/download/v5.1.0/yj-linux-amd64

if [ $(arch) = "aarch64" ]; then
  YJ_URL=https://github.com/sclevine/yj/releases/download/v5.1.0/yj-linux-arm64
fi

# Install yj (no checksums available)
curl -sSL "$YJ_URL" > /usr/local/bin/yj && chmod +x /usr/local/bin/yj

EOF

# build image that runs as cnb username
FROM build-image AS build-cnb

RUN groupadd cnb --gid ${cnb_gid} \
  && useradd --uid ${cnb_uid} --gid ${cnb_gid} -m -s /bin/bash cnb

ENV CNB_USER_ID=${cnb_uid}
ENV CNB_GROUP_ID=${cnb_gid}
ENV CNB_STACK_ID=${stack_id}

USER ${cnb_uid}:${cnb_gid}

# cnb build image with the stack id label
FROM build-cnb as build-cnb-stack
LABEL io.buildpacks.stack.id=${stack_id}

# cnb build image with the new [target] id label and stack label for backward compatibility
FROM build-cnb as build-cnb-target
LABEL io.buildpacks.stack.id=${stack_id}
LABEL io.buildpacks.id=${target_id}
