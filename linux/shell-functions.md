# Shell Functions for Linux

Require: `figlet`, run `sudo apt-get install figlet` or `brew install figlet`

Edit your `~/.profile` file (or `~/.zshrc`)

```shell
git-co() {
    figlet "Checkout all" 
    if [ -z "$1" ]; then
        dir=$(pwd)
    else
        dir="$1"
    fi
    for i in $(find "$dir" -maxdepth 3 -name .git -type d | rev | cut -c 6- | rev); do
        echo "════════════════════════════════════════════════════════════════════════════════════════════════════════"
        echo "Directory: $i | Branch: $2"
        git -C "$i" checkout "$2"
        echo "────────────────────────────────────────────────────────────────────────────────────────────────────────\n"
    done
}
git-reset() {
    figlet "Reset all"
    if [ -z "$1" ]; then
        dir=$(pwd)
    else
        dir="$1"
    fi
    for i in $(find "$dir" -maxdepth 3 -name .git -type d | rev | cut -c 6- | rev); do
        echo "════════════════════════════════════════════════════════════════════════════════════════════════════════"
        echo "Directory: $i | Branch: $(git -C "$i" rev-parse --abbrev-ref HEAD) | Mode: $2"
        git -C "$i" reset "$2"
        echo "────────────────────────────────────────────────────────────────────────────────────────────────────────\n"
    done
}
git-pull() {
    figlet "Pull all"
    if [ -z "$1" ]; then
        dir=$(pwd)
    else
        dir="$1"
    fi
    for i in $(find "$dir" -maxdepth 3 -name .git -type d | rev | cut -c 6- | rev); do
        echo "════════════════════════════════════════════════════════════════════════════════════════════════════════"
        echo "Directory: $i | Branch: $(git -C "$i" rev-parse --abbrev-ref HEAD)"
        git -C "$i" pull
        echo "────────────────────────────────────────────────────────────────────────────────────────────────────────\n"
    done
}
git-sync() {
    figlet "Sync all"
    if [ -z "$1" ]; then
        dir=$(pwd)
    else
        dir="$1"
    fi
    for i in $(find "$dir" -maxdepth 3 -name .git -type d | rev | cut -c 6- | rev); do
        echo "════════════════════════════════════════════════════════════════════════════════════════════════════════"
        echo "Directory: $i | Branch: $(git -C "$i" rev-parse --abbrev-ref HEAD)"
        remote=origin; for brname in `git -C "$i" branch -r | grep $remote | grep -v master | grep -v HEAD | awk '{gsub(/^[^\/]+\//,"",$1); print $1}'`; do
            git -C $i branch --track $brname $remote/$brname || true;
            git -C $i checkout $brname && git -C $i pull;
        done
        echo "────────────────────────────────────────────────────────────────────────────────────────────────────────\n"
    done
}
```

```shell
trivyscan() {
    docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy:latest image --no-progress --exit-code 1 --no-progress --severity CRITICAL $1
}
```

```shell
git-set-personal() {
    echo "Set git user to giaduongducminh@gmail.com"
    git config --local user.name "Giã Dương Đức Minh"
    git config --local user.email "giaduongducminh@gmail.com"
    git config --local commit.gpgsign true
    git config --global user.signingkey <your key here>
}
```

```shell
git-prune-branches() {
    git branch --no-color | grep -vE "^([+]|\s($(git_main_branch)|$(git_develop_branch))\s*$)" | xargs git branch -D 2>/dev/null
}
```

```shell
git-prune-release() {
    git tag | xargs git tag -d
}
```

```shell
trivyimage() {
    docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy:latest image --no-progress --exit-code 1 --no-progress --severity CRITICAL $1
}
```

```shell
trivyfs() {
    docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy:latest fs --no-progress --exit-code 1 --no-progress --severity CRITICAL $1
}
```
