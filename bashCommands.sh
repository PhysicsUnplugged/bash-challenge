#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset

# There is no unity to these individual solutions as I am not focusing on reuse.
#
# This is an exercise for an interview. With that in mind I am focusing on demonstration of breadth rather than
# generating something bulletproof. Obviously I violate the DRY principle.
#
# I could abstract the stanzas into a function and use that function. Using a function would engage the DRY principle.
# Per design patterns, abstracting to a function would also promote maintainability.
#
# The trend is that each stanza has an improved solution.
#
# I note that the given dataset for this exercise was small. Assumptions as to the characteristics of the file had to be
# made to get a minimal viable product. Some of those assumptions are:
#
#   1. File format is consistent.
#      a. Spaces are the separators between fields in the table. You throw in pipes or tabs as field separators and it
#         may not work.
#      b. Environment names are unique and not in reuse elsewhere. A violation might be a server name in "env1" that
#         is also named "env1-application-region-1". awk is much better suited to getting this right assuming the
#         separator is consistent.
#      c. Solutions that use the unix "cut" command assume a certain number of spaces exist between the environment
#         name and the host name.
#   2. Solutions for large files might be different.
#      a. see https://unix.stackexchange.com/questions/311514/how-well-does-grep-sed-awk-perform-on-very-large-files

# Exercise: Find the unique hosts in "env1".
HOST_LIST="data.txt"
ENVIRONMENT="env1"

UNIQUE_HOSTS=$(cat "${HOST_LIST}" | grep "${ENVIRONMENT}" | cut -d" " -f22 | uniq)
# xargs is a dirty trim that strips off space.
NUM_UNIQUE_HOSTS=$(cat "${HOST_LIST}" | grep "${ENVIRONMENT}" | cut -d" " -f22 | uniq | wc -l | xargs)
echo ""
echo "According to ${HOST_LIST}, there are ${NUM_UNIQUE_HOSTS} hosts in ${ENVIRONMENT}. The hosts are:"
echo "${UNIQUE_HOSTS}"


# Exercise: Find number of instances with "us-consumer" defined.
#
# This uses grep to find "us-consumer". If those characters are reused in an inappropriate place then disaster will
# strike. The code of this next stanza is nearly identical to the previous stanza solution.
# Thus I could abstract this into a function and use that function. Doing so would promote maintainability.
HOST_LIST="data.txt"
APPLICATION_CONSUMER="us-consumer"

US_CONSUMERS=$(grep "${APPLICATION_CONSUMER}" "${HOST_LIST}" | cut -d" " -f22| uniq)
NUM_US_CONSUMER=US_CONSUMER=$(grep "${APPLICATION_CONSUMER}" "${HOST_LIST}" | cut -d" " -f22| uniq | wc -l | xargs)
echo ""
echo "According to ${HOST_LIST}, the \"${APPLICATION_CONSUMER}\" servers are:"
echo "${US_CONSUMERS}"


# Exercise: Find all disabled instances in a "host:port app" format,
#   i.e. reno-env01-apphost03.rno.apple.com:1000 ASPEN-us-consumer
#
# Can solve this in at least two ways:
#
# 1. Grep the file and use awk to format the file:
#
DISABLED_SERVER_LIST1=$(grep -E '^env*.*yes$' "${HOST_LIST}" | awk '{print $2":"$3" "$4}')
echo ""
echo "According to ${HOST_LIST}, the servers marked as disabled are:"
echo "${DISABLED_SERVER_LIST1}"
#
# 2. The second way is just to use awk directly:
#
DISABLED_SERVER_LIST2=$(awk '{if ($5=="yes") print $2":"$3" "$4}' "${HOST_LIST}")
echo ""
echo "According to ${HOST_LIST}, the servers marked as disabled are:"
echo "${DISABLED_SERVER_LIST2}"


# Exercise: Write a command or series of commands to scp a file test.txt to the /tmp folder of each host with port 8593
TARGET_SERVER_LIST=$(awk '{if ($3=="8593") print $2}' "${HOST_LIST}")
echo ""
echo "The server list for scp is:"
echo "${TARGET_SERVER_LIST}"

# TARGET_SERVER_LIST is not an array. So make an array:
TARGET_SERVERS=($(echo "${TARGET_SERVER_LIST}" | tr " " "\n"))

TARGET_USER="ec2-user"  # TARGET_USER could be ec2-user, anonymous, centos, ubuntu, root, etc :)
FILE_TO_COPY="text.txt"
TARGET_DIR="/tmp"
PORT=22
for TARGET_SERVER in "${TARGET_SERVERS[@]}"
do
    if ping -c 1 -W 1 "${TARGET_SERVER}"; then
        printf "%s: %s\n" "$0" "Target server ${TARGET_SERVER} is reachable."
        if nc -z ${TARGET_SERVER} ${PORT} 2>/dev/null; then
            printf "%s: %s\n" "$0" "${TARGET_SERVER} is listening on port ${PORT}."
            scp -v -r -o User="${TARGET_USER}" "${TARGET_DIR}" "${TARGET_SERVER}:${TARGET_DIR}/"
        else
            printf "%s: %s\n" "$0" "Error: Target server ${TARGET_SERVER} is not listening on port ${PORT}."
        fi
    else
        printf "%s: %s\n" "$0" "Error: Target server ${TARGET_SERVER} not reachable."
    fi
done