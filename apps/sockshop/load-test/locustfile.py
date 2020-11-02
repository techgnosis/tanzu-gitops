from locust import HttpUser, task
from random import choice




class SockShopUser(HttpUser):
    min_wait = 0
    max_wait = 0        
    
    def on_start(self):
        catalogue = self.client.get("/catalogue").json()
        category_item = choice(catalogue)
        self.item_id = category_item["id"]

    @task
    def root(self):
        self.client.get("/")

    @task
    def get_category(self):
        self.client.get("/category.html")

    @task
    def get_detail(self):
        self.client.get("/detail.html?id={}".format(self.item_id))

    def delete_cart(self):
        self.client.delete("/cart")

    def post_cart(self):
        self.client.post("/cart", json={"id": self.item_id, "quantity": 1})

    def get_basket(self):
        self.client.get("/basket.html")

    def post_orders(self):
        self.client.post("/orders")





