#!/bin/bash
set -euo pipefail

# set uid and gid with same permissions as mount point
USER_ID=${TERRAFORM_UID:-$(stat -c %u "$(pwd)")}
GROUP_ID=${TERRAFORM_GID:-$(stat -c %g "$(pwd)")}
USER_NAME=${TERRAFORM_USER:-terraform}
GROUP_NAME=${TERRAFORM_GROUP:-terraform}

# add our custom group and user
addgroup -S -g "${GROUP_ID}" "${GROUP_NAME}"
adduser -S -s /bin/bash -u "${USER_ID}" -G "${GROUP_NAME}" "${USER_NAME}"

# change to new home directory
export HOME=/home/${USER_NAME}

# run commands with new UID and GID
exec gosu "${USER_NAME}" terraform "$@"
