# Git Functions for Ubuntu

Require: `figlet`, run `sudo apt-get install figlet`

Edit your `~/.profile` file

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
```