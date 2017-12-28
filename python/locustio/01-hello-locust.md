# Hello Locust

Python version: 3.6.3
Locust version: 0.8.1

## Create Task file

Create a file named `tutorial/locustfile.py` (this specific name not any others)

```python
from locust import HttpLocust, TaskSet

def index(l):
    l.client.get("/")

def profile(l):
    l.client.get("/ducminhgd")

class UserBehavior(TaskSet):
    tasks = {
        index: 2,
        profile: 1,
    }

class WebsiteUser(HttpLocust):
    task_set = UserBehavior
    min_wait = 5000
    max_wait = 9000
```

## Run

Change working directory to `tutorial` and run this command `locust --host=https://github.com`

Output should be like (I used vagrant):

```shell
[2017-12-28 14:48:37,466] vagrant/INFO/locust.main: Starting web monitor at *:8089
[2017-12-28 14:48:37,467] vagrant/INFO/locust.main: Starting Locust 0.8.1
```

If you run with localhost, then open the page `http://127.0.0.1:8089`, input values for `Number of users to simulate` and `Hatch rate` then start swarming and view results.

