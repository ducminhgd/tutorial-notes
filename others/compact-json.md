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

Required packages:
- `com.fasterxml.jackson.core`
- `com.fasterxml.jackson.databind`

```java
import java.io.IOException;
import java.util.HashMap;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;

public class Main {

    public static void main(String[] args) {
        HashMap tm = new HashMap();
        tm.put("integer", 1);
        tm.put("float", 1.3);
        tm.put("double", new Double(1.222));
        tm.put("string", "Hello Hash Map");

        String jsonString = Main.jsonCompact(tm, true);
        System.out.println(jsonString);
    }

    public static String jsonCompact(HashMap hm, boolean sort_keys) {
        String json = "";
        ObjectMapper mapper = new ObjectMapper();
        try {
            mapper.configure(SerializationFeature.ORDER_MAP_ENTRIES_BY_KEYS, sort_keys);
            json = mapper.writeValueAsString(hm);
        } catch (JsonGenerationException e) {
            e.printStackTrace();
        } catch (JsonMappingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return json;
    }
}
```

# C#

```csharp
string MyDictionaryToJson(Dictionary<int, List<int>> dict)
{
    var entries = dict.Select(d =>
        string.Format("\"{0}\": [{1}]", d.Key, string.Join(",", d.Value)));
    return "{" + string.Join(",", entries) + "}";
}
```

## JavaScriptSerializer Snippet
```csharp
// using System.Web.Script.Serialization;

Dictionary<string, object> dictss = new Dictionary<string, object>();

dictss.Add("Method", "LOGIN");
dictss.Add("User", "User_Name");
dictss.Add("Pass", "Password");
dictss.Add("Type", "User_Type");

Dictionary<string, object> skills = new Dictionary<string, object>();
skills.Add("1", "SKILL-1");
skills.Add("2", "SKILL-2");
skills.Add("3", "SKILL-3");

dictss.Add("Skill", skills);

JavaScriptSerializer serializer = new JavaScriptSerializer();
string jsonString = serializer.Serialize((object)dictss);

//var json = JsonConvert.SerializeObject(dictss, Formatting.None);
```