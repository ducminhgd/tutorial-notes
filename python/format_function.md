# Python Format string

[Python Doc](https://docs.python.org/2/library/string.html#formatexamples)

`{index[element_index]:<fill_char><fill_condition><width><format>}`

```python
>>> number = 1
>>> length = 10
>>> '{number:0>{length}}'.format(number=number, length=length)
'0000000001'
>>> '{number:0<{length}}'.format(number=number, length=length)
'1000000000'
>>> '{number:0^{length}}'.format(number=number, length=length)
'0000100000'
```

**<fill_condition>**

- `<`: append from right
- `>`: append from left
- `^`: append from both, append right, then left

**<format>**

```python
>>> "int: {0:d};  hex: {0:x};  oct: {0:o};  bin: {0:b}".format(42)
'int: 42;  hex: 2a;  oct: 52;  bin: 101010'
```

**Thousand separtor:**

```python
>>> '{:,}'.format(1234567890)
'1,234,567,890'
```

