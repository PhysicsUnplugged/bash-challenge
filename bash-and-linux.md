# Interview Problems

## Bash and Linux

### Bash Script

Write a bash script to:

- define an alias named `ll` for the command `ls -al`
- write a function to curl `https://api.iextrading.com/1.0/tops?symbols=AAPL` and output the current AAPL stockprice
- source an additional bash script, `~/.bashrc_extras`, if that file exists

### Bash Commands

Write grep, awk, etc commands to extract information from this data

- Unique hosts in env1
- Number of instances with us-consumer defined
- All disabled instances in a `host:port app` format, i.e. `reno-env01-apphost03.rno.apple.com:1000 ASPEN-us-consumer`

Write a command or series of commands to scp a file `test.txt` to the /tmp folder of each host with port 8593

**Note** Showing your work or thought process is encouraged.

#### Data

```
ENVIRONMENT                HOSTNAME                          PORT  APPLICATION                   PACKAGE/IMAGE  DISABLED
========================================================================================================================
env1                     reno-env01-apphost03.rno.apple.com  8560  ASPEN-us-consumer                              no
env1                     reno-env01-apphost03.rno.apple.com  8563  ASPEN-amr-consumer                             no
env1                     reno-env01-apphost03.rno.apple.com  8585  ASPEN-japan-telesales                          no
env1                     reno-env01-apphost03.rno.apple.com  8590  ASPEN-emea-central-edu                         no
env1                     reno-env01-apphost03.rno.apple.com  8592  ASPEN-emea-internet                            no
env1                     reno-env01-apphost04.rno.apple.com  8562  ASPEN-us-edu                                   no
env1                     reno-env01-apphost04.rno.apple.com  8563  ASPEN-amr-internet                             no
env1                     reno-env01-apphost04.rno.apple.com  8582  ASPEN-japan-internet                           no
env1                     reno-env01-apphost04.rno.apple.com  8592  ASPEN-emea-edu                                 no
env1                     reno-env01-apphost04.rno.apple.com  8593  ASPEN-emea-north-consumer                      no
env1                     reno-env01-apphost05.rno.apple.com  8564  ASPEN-amr-smb                                  no
env1                     reno-env01-apphost05.rno.apple.com  8575  ASPEN-apac-telesales                           no
env1                     reno-env01-apphost05.rno.apple.com  8591  ASPEN-emea-consumer                            no
env1                     reno-env01-apphost05.rno.apple.com  8595  ASPEN-emea-telesales                           no
env1                     reno-env01-apphost05.rno.apple.com  8596  ASPEN-emea-north-edu                           no
env1                     reno-env01-apphost06.rno.apple.com  8563  ASPEN-amr-consumer                             no
env1                     reno-env01-apphost06.rno.apple.com  8565  ASPEN-amr-telesales                            no
env1                     reno-env01-apphost06.rno.apple.com  8572  ASPEN-apac-internet                            no
env1                     reno-env01-apphost06.rno.apple.com  8592  ASPEN-emea-central-consumer                    no
env1                     reno-env01-apphost06.rno.apple.com  8597  ASPEN-emea-central-telesales                   no
env1                     reno-env01-apphost06.rno.apple.com  8598  ASPEN-emea-north-telesales                     no
env2                     reno-env02-apphost07.rno.apple.com  8563  ASPEN-amr-internet                             no
env2                     reno-env02-apphost07.rno.apple.com  8571  ASPEN-apac-consumer                            no
env2                     reno-env02-apphost07.rno.apple.com  8592  ASPEN-emea-central-consumer                    no
env2                     reno-env02-apphost07.rno.apple.com  8598  ASPEN-emea-north-telesales                     no
env2                     reno-env02-apphost08.rno.apple.com  8564  ASPEN-amr-smb                                  yes
env2                     reno-env02-apphost08.rno.apple.com  8575  ASPEN-apac-telesales                           no
env2                     reno-env02-apphost08.rno.apple.com  8590  ASPEN-emea-central-edu                         no
env2                     reno-env02-apphost08.rno.apple.com  8591  ASPEN-emea-consumer                            no
env2                     reno-env02-apphost08.rno.apple.com  8595  ASPEN-emea-telesales                           no
env2                     reno-env02-apphost08.rno.apple.com  8596  ASPEN-emea-north-edu                           no
env2                     reno-env02-apphost09.rno.apple.com  8562  ASPEN-us-edu                                   no
env2                     reno-env02-apphost09.rno.apple.com  8565  ASPEN-amr-telesales                            no
env2                     reno-env02-apphost09.rno.apple.com  8572  ASPEN-apac-internet                            no
env2                     reno-env02-apphost09.rno.apple.com  8582  ASPEN-japan-internet                           no
env2                     reno-env02-apphost09.rno.apple.com  8592  ASPEN-emea-edu                                 no
env2                     reno-env02-apphost09.rno.apple.com  8593  ASPEN-emea-north-consumer                      yes
env2                     reno-env02-apphost09.rno.apple.com  8597  ASPEN-emea-central-telesales                   no
env2                     reno-env02-apphost10.rno.apple.com  8560  ASPEN-us-consumer                              no
env2                     reno-env02-apphost10.rno.apple.com  8571  ASPEN-apac-consumer                            no
env2                     reno-env02-apphost10.rno.apple.com  8585  ASPEN-japan-telesales                          no
env2                     reno-env02-apphost10.rno.apple.com  8592  ASPEN-emea-internet                            no

42 total records
```

## What I am looking for

I want to see that the candidate is able to:

- create a simple bash script with functions
- parse tabular data for useful information
- Use your parsed data to execute commands in bulk
