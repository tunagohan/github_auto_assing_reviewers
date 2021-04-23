# github_auto_assing_reviewers

A simple tool that automatically adds reviewers.

## Set Enviroments

Recommended is direnv.

```
export GITHUB_TOKEN=xxxxxxxxxxxxxxxxxxxxxxxxxxxxx
export REVIEWER_MEMBERS=[jonh:michael:apple:sushi]
export GITHUB_REPOSITORY=<name>/<repo name>
```

### GITHUB_TOKEN

Generate Token : https://github.com/settings/tokens

### REVIEWER_MEMBERS

Please write here the members you want to add as reviews from members participating in the repository.

The delimiter will be `:`

### GITHUB_REPOSITORY

example
tunagohan/github_auto_assing_reviewers

## Run

```
$ ./github_auto_assing_reviwer.sh

> > PullRequest Number: 1234

> > send ready? (y/N): y

...
...
    }
  },
  "author_association": "CONTRIBUTOR",
  "auto_merge": null,
  "active_lock_reason": null
}

bye :)
```
