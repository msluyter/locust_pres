import random

from locust import HttpLocust, TaskSet, task


class MyTaskSet(TaskSet):
    def on_start(self):
        res = self.client.post('/login',
                         {
                             "username": 'admin',
                             "password": 'default'
                         })
        res.raise_for_status()

    @task(1)
    def index(self):
        self.client.get("/")

    @task(1)
    def entry(self):
        entry = random.randint(1, 5)

        self.client.get(f"/entry/{entry}", name="Entry")

    @task(1)
    def slow(self):
        self.client.get('/slow')

class MyLocust(HttpLocust):
    task_set = MyTaskSet
    min_wait = 1000
    max_wait = 2000
