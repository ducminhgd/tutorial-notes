# Compact JSON

Compact JSON string is a JSON string without spaces between brackets, keys, separators and value.

Example: `{"key1":"string_1","key2":integer2,"key3":float3}`

# Python

```python
def json_compact_dumps(params, sort_keys=True):
    return json.dumps(params, separators=(',', ':'), sort_keys=sort_keys)
```

# PHP

```php
<?php

function json_compact_dumps($params, $sort_keys=true) {
    if ($sort_keys) {
        ksort($params);
    }
    return json_encode($params);
}
```

# Java

# C#