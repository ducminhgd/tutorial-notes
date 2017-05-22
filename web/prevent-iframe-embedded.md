# Using Javascript

```javascript
if (window.top !== window.self) {
    alert("IFrame is detected!");
    window.top.location = window.self.location
}
```

# Using X-Frame-Options

```
X-Frame-Options: DENY
X-Frame-Options: SAMEORIGIN
X-Frame-Options: ALLOW-FROM https://example.com/
```

## Values

| Value          | Description                                                                          |
|----------------|--------------------------------------------------------------------------------------|
| DENY           | The page cannot be displayed in a frame, regardless of the site attempting to do so. |
| SAMEORIGIN     | The page can only be displayed in a frame on the same origin as the page itself.     |
| ALLOW-FROM uri | The page can only be displayed in a frame on the specified origin.                   |

## Configuring Apache

For `SAMEORIGIN`

```
Header always append X-Frame-Options SAMEORIGIN
```

For `DENY`

```
Header set X-Frame-Options DENY
```

## Configuring Nginx

```
add_header X-Frame-Options SAMEORIGIN;
```

## Configuring IIS

```xml
<system.webServer>
  ...

  <httpProtocol>
    <customHeaders>
      <add name="X-Frame-Options" value="SAMEORIGIN" />
    </customHeaders>
  </httpProtocol>

  ...
</system.webServer>
```

## HAProxy

```
rspadd X-Frame-Options:\ SAMEORIGIN
```