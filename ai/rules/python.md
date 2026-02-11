# Python Development Rules

## .gitignore

**Python-specific patterns to ignore in version control:**

```gitignore
# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*$py.class
*.so

# Distribution / packaging
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
pip-wheel-metadata/
share/python-wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST

# Virtual environments
venv/
env/
ENV/
env.bak/
venv.bak/
.venv/
.virtualenv/

# PyInstaller
*.manifest
*.spec

# Unit test / coverage reports
htmlcov/
.tox/
.nox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
*.py,cover
.hypothesis/
.pytest_cache/

# Translations
*.mo
*.pot

# Django
*.log
local_settings.py
db.sqlite3
db.sqlite3-journal
/media
/staticfiles

# Flask
instance/
.webassets-cache

# Scrapy
.scrapy

# Sphinx documentation
docs/_build/

# PyBuilder
target/

# Jupyter Notebook
.ipynb_checkpoints
*.ipynb

# IPython
profile_default/
ipython_config.py

# pyenv
.python-version

# pipenv
Pipfile.lock

# poetry
poetry.lock  # (commit for applications, ignore for libraries)

# Celery
celerybeat-schedule
celerybeat.pid

# SageMath parsed files
*.sage.py

# Environments
.env
.env.local
.env.*.local

# Spyder project settings
.spyderproject
.spyproject

# Rope project settings
.ropeproject

# mkdocs documentation
/site

# mypy
.mypy_cache/
.dmypy.json
dmypy.json

# Pyre type checker
.pyre/

# pytype static type analyzer
.pytype/

# Ruff
.ruff_cache/

# LSP
pyrightconfig.json
```

## .dockerignore

**Python-specific patterns to exclude from Docker builds:**

```dockerignore
# Version control
.git/
.gitignore
.gitattributes

# Virtual environments (rebuild in container)
venv/
env/
ENV/
.venv/
.virtualenv/

# Python cache
__pycache__/
*.py[cod]
*$py.class
*.so

# Testing
.pytest_cache/
.tox/
.nox/
.coverage
.coverage.*
htmlcov/
coverage.xml
*.cover
.hypothesis/

# Type checking
.mypy_cache/
.pytype/
.pyre/

# Linting
.ruff_cache/

# Distribution
*.egg-info/
.eggs/
dist/
build/
*.egg

# IDE
.vscode/
.idea/
*.swp
*.swo
.spyderproject
.spyproject
.ropeproject

# Documentation
docs/
*.md
README.md
CHANGELOG.md
LICENSE

# CI/CD
.github/
.gitlab-ci.yml
.travis.yml
azure-pipelines.yml

# Development files
.env.example
.editorconfig
.pre-commit-config.yaml
setup.cfg  # (unless needed for build)
pyproject.toml  # (unless needed for build)

# Testing files
tests/
test/
*_test.py
test_*.py

# Jupyter notebooks
*.ipynb
.ipynb_checkpoints

# Logs
*.log

# OS files
.DS_Store
Thumbs.db

# Development scripts
scripts/dev/
Makefile
```

## Code Style and Formatting

- Follow PEP 8 style guide for Python code
- Use 4 spaces for indentation (never tabs)
- Maximum line length of 88 characters (Black formatter default) or 79 (PEP 8)
- Use snake_case for functions and variables
- Use PascalCase for class names
- Use UPPER_CASE for constants
- Add blank lines: 2 before top-level functions/classes, 1 between methods

## Type Hints

- Always use type hints for function parameters and return values
- Use `from typing import` for complex types (List, Dict, Optional, Union, etc.)
- For Python 3.10+, prefer built-in generics (`list[str]` instead of `List[str]`)
- Use `Optional[Type]` or `Type | None` for nullable values
- Add type hints to class attributes using annotations

```python
def process_data(items: list[str], threshold: int = 10) -> dict[str, int]:
    """Process items and return counts."""
    pass
```

## Documentation

- Use docstrings for all modules, classes, and functions
- Follow Google, NumPy, or reStructuredText docstring format (choose one consistently)
- Include description, parameters, return values, and raised exceptions
- Add examples for complex functions

```python
def calculate_average(numbers: list[float]) -> float:
    """Calculate the average of a list of numbers.

    Args:
        numbers: List of numbers to average

    Returns:
        The arithmetic mean of the numbers

    Raises:
        ValueError: If the list is empty
    """
    if not numbers:
        raise ValueError("Cannot calculate average of empty list")
    return sum(numbers) / len(numbers)
```

## Import Organization

- Group imports in this order: standard library, third-party, local
- Separate each group with a blank line
- Use absolute imports over relative imports when possible
- Avoid wildcard imports (`from module import *`)

```python
import os
import sys
from typing import Optional

import requests
from pydantic import BaseModel

from app.models import User
from app.utils import helpers
```

## Error Handling

- Use specific exception types, not bare `except:`
- Create custom exceptions for domain-specific errors
- Use context managers (`with` statement) for resource management
- Clean up resources in `finally` blocks or use context managers
- Log exceptions with appropriate detail

```python
class DataProcessingError(Exception):
    """Raised when data processing fails."""
    pass

try:
    with open('file.txt') as f:
        data = f.read()
except FileNotFoundError:
    logger.error("File not found: file.txt")
    raise
except Exception as e:
    logger.exception("Unexpected error processing file")
    raise DataProcessingError(f"Failed to process: {e}") from e
```

## Testing

- Write tests using pytest framework
- Place tests in `tests/` directory mirroring source structure
- Name test files as `test_*.py` or `*_test.py`
- Name test functions as `test_<description>`
- Use fixtures for setup/teardown and shared test data
- Aim for high test coverage (>80%)
- Use parametrize for testing multiple inputs

```python
import pytest

@pytest.fixture
def sample_data():
    return [1, 2, 3, 4, 5]

@pytest.mark.parametrize("input,expected", [
    ([1, 2, 3], 2.0),
    ([5, 10, 15], 10.0),
])
def test_calculate_average(input, expected):
    assert calculate_average(input) == expected
```

## Project Structure

- Use virtual environments (venv, virtualenv, or poetry)
- Define dependencies in `requirements.txt` or `pyproject.toml`
- Use `.env` files for environment variables (never commit secrets)
- Structure projects with clear separation:
  ```
  project/
  ├── src/
  │   └── package/
  │       ├── __init__.py
  │       ├── module.py
  │       └── subpackage/
  ├── tests/
  ├── docs/
  ├── pyproject.toml
  ├── README.md
  └── .gitignore
  ```

## Best Practices

- Use list/dict/set comprehensions for simple transformations
- Prefer `pathlib.Path` over `os.path` for file operations
- Use `with` statements for file and resource handling
- Use dataclasses or Pydantic models for structured data
- Avoid mutable default arguments
- Use `is` for None comparisons, `==` for value comparisons
- Leverage built-in functions: `enumerate()`, `zip()`, `map()`, `filter()`

```python
# Good
from pathlib import Path

def read_config(config_path: Path) -> dict:
    with config_path.open() as f:
        return json.load(f)

# Bad - mutable default argument
def add_item(item, items=[]):  # Don't do this!
    items.append(item)
    return items
```

## Async Programming

- Use `async`/`await` for I/O-bound operations
- Use `asyncio` for concurrent operations
- Avoid blocking calls in async functions
- Use `asyncio.gather()` for parallel async operations
- Properly handle async context managers and iterators

```python
async def fetch_data(url: str) -> dict:
    async with aiohttp.ClientSession() as session:
        async with session.get(url) as response:
            return await response.json()

async def main():
    results = await asyncio.gather(
        fetch_data(url1),
        fetch_data(url2),
        fetch_data(url3),
    )
```

## Security

- Never hardcode credentials or secrets
- Use environment variables or secret management tools
- Validate and sanitize all user inputs
- Use parameterized queries for database operations (prevent SQL injection)
- Keep dependencies updated for security patches
- Use `secrets` module for cryptographic randomness

## Performance

- Profile before optimizing (`cProfile`, `line_profiler`)
- Use generators for large datasets to save memory
- Cache expensive computations with `functools.lru_cache`
- Use `__slots__` for classes with many instances
- Consider NumPy/Pandas for numerical computations

```python
from functools import lru_cache

@lru_cache(maxsize=128)
def expensive_computation(n: int) -> int:
    # Cached for repeated calls
    return fibonacci(n)
```

## Code Quality Tools

- Use `black` for code formatting
- Use `flake8` or `ruff` for linting
- Use `mypy` for static type checking
- Use `isort` for import sorting
- Configure pre-commit hooks for automated checks
- Use `pylint` for additional code quality checks

## Dependencies Management

- Pin dependency versions in production (`package==1.2.3`)
- Use version ranges in libraries (`package>=1.2.0,<2.0.0`)
- Regularly update dependencies for security
- Use `poetry` or `pip-tools` for dependency management
- Separate dev dependencies from production dependencies
