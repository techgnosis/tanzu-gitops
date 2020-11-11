import base64

from locust import HttpUser, TaskSet, task
from random import randint, choice

import requests
from urllib3.exceptions import InsecureRequestWarning

# Suppress only the single warning from urllib3 needed.
requests.packages.urllib3.disable_warnings(category=InsecureRequestWarning)

class WebTasks(TaskSet):

    @task
    def load(self):
        base64string = base64.encodebytes(('%s:%s' % ('user', 'password')).encode()).decode().strip()
        catalogue = self.client.get("/catalogue", verify=False).json()
        category_item = choice(catalogue)
        item_id = category_item["id"]

        self.client.get("/", verify=False)
        self.client.get("/login", headers={"Authorization":"Basic %s" % base64string}, verify=False)
        self.client.get("/category.html", verify=False)
        self.client.get("/detail.html?id={}".format(item_id), verify=False)
        self.client.delete("/cart", verify=False)
        self.client.post("/cart", json={"id": item_id, "quantity": 1}, verify=False)
        self.client.get("/basket.html", verify=False)
        self.client.post("/orders", verify=False)


class SockShopUser(HttpUser):
    tasks = {WebTasks}
    min_wait = 0
    max_wait = 0