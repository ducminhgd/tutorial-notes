# Delete Queue via API

```python
import requests
import json

auth_data = {
    'username': 'username',
    'password': 'password',
}
host = 'localhost'
url = 'https://{}/api/queues/'.format(host)
response = requests.get(url, auth=(auth_data['username'], auth_data['password']))
data = json.loads(response.content)

for queue in data:
    if queue['vhost'] == "virtual_host" and queue['name'].find('amq.gen') == 0:
        print(requests.delete('{}{}/{}'.format(url, 'virtual_host', queue['name']), auth=(auth_data['username'], auth_data['password'])).content)
```