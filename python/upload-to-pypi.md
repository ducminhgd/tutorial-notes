# Upload package to PyPi

_Note_: tested and success with Python 3.5, but failed with Python 2.7 and 3.4, still have no idea why they failed. :(

## Step 1: create accounts

Create your account on [PyPi Live](https://pypi.python.org/pypi?%3Aaction=register_form) and [PyPi test](https://testpypi.python.org/pypi?%3Aaction=register_form)

## Steap 2: Create `.pypirc` configuration file

Location: `~/.pypirc`

```
[distutils]
index-servers =
  pypi
  pypitest

[pypi]
repository: https://upload.pypi.org/legacy/
username: your_username
password: your_password

[pypitest]
repository: https://test.pypi.org/legacy/
username: your_username
password: your_password
```

Run command `chmod 600 ~/.pypirc`

## Step 3: prepare package

Structure

```
root-dir/   # arbitrary working directory name
    setup.py
    setup.cfg
    LICENSE.txt
    README.md
    mypackage/
        __init__.py
        foo.py
        bar.py
        baz.py
    mypackage01/
        __init__.py
        foo01.py
```

### setup.py

```
from setuptools import setup, find_packages

setup(
    name='My Package',
    version='0.0.1',
    description='Utility package',
    author='Gia Duong Duc Minh',
    author_email='giaduongducminh@gmail.com',
    url='Project URL such as Github',
    packages=find_packages(),
)
```

### setup.cfg

This tells PyPI where your README file is.

```
[metadata]
description-file = README.md
```

### MANIFEST.in

```
include LICENSE.txt
include README.md
```


## Run command

`python setup.py sdist upload -r pypi` if you want to build and upload to `[pypi]` configuration