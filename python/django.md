# Create custom template filter

## Problem

Considered you have this dictionary

```
MESSAGE = {
    '0': 'Success',
    '1': 'Unknown error',
    '2': 'Failed',
}
```

Expected display as `Success` if `code='0'`

## Solution

1. Create a package name `templatetags` in your app and a file for customer filters (for example, `custom_filters.py`). Then the directory tree should be:

```
my_project/
 |-- my_app/
      |-- templates/ # templates are stored here
      |-- templatetags/
      |    |-- __init__.py
      |    |-- custom_filters.py
      |-- urls.py
      |-- views.py
```

2. In `custom_filters.py` file:

```
# coding=utf-8
from django import template
# For XSS prevent
from django.template.defaultfilters import linebreaksbr, urlize

MESSAGE = {
    '0': 'Success',
    '1': 'Unknown error',
    '2': 'Failed',
}

register = template.Library()


@register.filter(name='get_message')
def get_message(response_code):
    if response_code not in MESSAGE:
        return u'Error: not defined'
    return linebreaksbr(urlize(MESSAGE[response_code], autoescape=True), autoescape=True)
```

3. In template file, for e.g.: `templates/list.html`, add this line `{% load get_message %}` below extends tag. Then use like this

```
{{ object.response_code|get_message }}
```

# Run a file as script in Django

1. Add these line at the end of file

```
if __name__ == '__main__':
    import os

    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "bank_giro.settings")
    
    # YOUR CODE RUN HERE
```

2. In terminal, run this command:

```
export PYTHONPATH=$PYTHONPATH:path/to/project/source/code # this will be lost after you logout
```

3. Run python file

```
python path/to/python/file

# Or using virtual environment
path/to/virtual-environment/bin/python path/to/python/file
```

# Security

## Config for sessions and cookies

Add these configurations into `settings.py` file:

```python
SESSION_COOKIE_DOMAIN = None  # Just remove the SESSION_COOKIE_DOMAIN setting or set it to None. Django will automatically use the current domain.
SESSION_COOKIE_HTTPONLY = True
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SECURE = True
CSRF_COOKIE_HTTPONLY = True
SESSION_COOKIE_AGE = 5 * 60
```

# Connect to Microsoft SQL Server

Please take a look at [Create connection from Ubuntu to MS SQL Server](../ubuntu/create_connection_to_mssql.md)

## Python packages requirements

```shell
# requirements.txt
Django==1.11.6
django-pyodbc-azure==1.11.0.0
pyodbc==4.0.21
pytz==2017.3
```

## Django settings

```python
DATABASES = {
    'default': {
        'NAME': 'database_name',
        'ENGINE': 'sql_server.pyodbc', # Must be
        'HOST': 'MSSQLDev', # Which is configured in /etc/freetds/freetds.conf file
        'USER': 'python',
        'PASSWORD': 'python',
        # 'PORT': '1433',
    },
}
```