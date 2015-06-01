### todoer

Search your codebase for `TODO` comments and get a summary of the amount and their age.

### Usage

`./todoer --repo <reponame> --strict`

### Sample output

```
using repo: some-repo
            0.7 yrs    56 ############################################################
            1.8 yrs    13 ##############
            1.7 yrs    11 ############
            1.2 yrs    11 ############
            0.5 yrs    11 ############
            2.1 yrs     8 #########
            1.3 yrs     8 #########
            2.5 yrs     5 ######
            ...
```

### Dependencies

You will need both [ack](http://beyondgrep.com/) and [git](http://git-scm.com/).

### License

AGPL.
