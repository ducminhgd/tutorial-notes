# Git

## Cheatsheet

| Purpose              | Command or action                                                                                                                                                                                                                              | More details              |
|----------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------|
| Tagging              | `git tag <tag-name> [-m <message>]`                                                                                                                                                                                                            |                           |
| Adding remote        | `git remote add <remote-name> <repository-url>`                                                                                                                                                                                                |                           |
| Cloning new branch   | `git checkout <source-branch> -B <new-branch>`                                                                                                                                                                                                 | `-B` switch to new branch |
| Graph log            | `git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all` |                           |
| Create alias command | Edit `.git/config` file, Add `<alias-command>=<full-command>` in `[alias]` section                                                                                                                                                             |                           |

## Change message of an old commit

1. Rebase to that commit `git rebase -i HEAD~5`
2. Change `pick` to `reword` of the commit that you want to change its message.
3. At that commit, run `git commit --amend -m "message you want to change"`.
4. Continue rebasing `git rebase --continue`
5. Push force `git push -f`.


## Git configuration by directories

Assump that we have directories structured like this tree

```
personal/
├── project 1/
├── project 2/
└── gitconfig
company/
├── company project 1/
├── company project 2/
└── gitconfig
```

in the gitconfig global, add those lines

```toml
[includeIf "gitdir:~/personal/"]
  path = ~/personal/.gitconfig
[includeIf "gitdir:~/company/"]
  path = ~/company/.gitconfig
```