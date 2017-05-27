# Command cheatsheet

| Purpose                                        | Command                                                   | Descirption |
| ---------------------------------------------- | --------------------------------------------------------- | ----------- |
| Create virtual environment                     | `virtualenv <path-env>`                                   |             |
| Create virtual environment with choosen python | `virtualenv -p <path-to-python> <path-env>`               |             |
| Install package in virtual environment         | `pip install -E <path-env> <package[==<version>] or URL>` |             |
| Export packages list                           | `pip freeze > package_list.txt`                           |             |
| Install packages with file                     | `pip install -r <package-list-file-path>`                 |             |