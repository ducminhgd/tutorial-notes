# Microsoft SQL (T-SQL)

## Transform result set into XML

### Each record as an element with columns are attributes

Query 

```sql
SELECT * FROM [dbo].[mytable] FOR XML AUTO;
```

Result

```xml
<mytable col1="value1" col2="value2" col2="value2"/>
```

### Columns are tags

Query

```sql
SELECT * FROM [dbo].[mytable] FOR XML PATH('')
```

Result

```xml
<col1>value1</col1>
<col2>value2</col2>
<col3>value3</col3>
```

Query

```sql
SELECT * FROM [dbo].[mytable] FOR XML PATH('detail')
```

Result

```xml
<detail>
    <col1>value1</col1>
    <col2>value2</col2>
    <col3>value3</col3>
</detail>
```
### Custom root and custom detail tag

Query

```sql
SELECT * FROM [dbo].[mytable] FOR XML PATH('detail'), ROOT('root')
```

Result

```xml
<root>
    <detail>
        <col1>value1</col1>
        <col2>value2</col2>
        <col3>value3</col3>
    </detail>
</root>
```

### One record one line

Sometime, a record is parsed into a very long XML string which has to be break into multiple lines. We need to use a trick to make it one line.

Query

```sql
SELECT(SELECT * FROM [dbo].[mytable] FOR XML PATH('detail'), ROOT('root')) AS [column_name];
```

`AS [column_name]` make result has as specific name, not a random name