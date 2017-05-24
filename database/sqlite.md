# SQLite 3 Cheatsheet

| Command             | Description                                                                                    |
| ------------------- | ---------------------------------------------------------------------------------------------- |
| `sqlite3 <dbname>`  | Create database with name is _dbname_ if _dbname_ does not exist. Otherwise, open the database |
| `.tables [<table>]` | List all tables, if _table_ is specified just list the tables matching LIKE pattern _table_    |
| `.schema <table>`   | Show table schema                                                                              |
| `.dump`             | Show database structure and data                                                               |
| `.quit` or `.exit`  | Quit                                                                                           |
| `.help`             | Show all special commands                                                                      |