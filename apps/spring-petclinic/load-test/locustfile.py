import time
import string
from locust import HttpUser, task, between
from random import randrange, choice
import requests
from urllib3.exceptions import InsecureRequestWarning

# Suppress only the single warning from urllib3 needed.
requests.packages.urllib3.disable_warnings(category=InsecureRequestWarning)

owners = 10

PET_TYPES = ['bird', 'cat', 'dog', 'hamster', 'lizard', 'snake']

def get_random_string(length):
    letters = string.ascii_lowercase
    result_str = ''.join(choice(letters) for i in range(length))
    return result_str

class SpringPetclinicUser(HttpUser):
    wait_time = between(1, 2)

    

    @task(50)
    def index_page(self):
        self.client.get("/", verify=False)

    @task(50)
    def owners_find(self):
        self.client.get("/owners/find", verify=False)

    @task(50)
    def owners_new(self):
        self.client.get("/owners/new", verify=False)

    @task(50)
    def owners_all(self):
        self.client.get("/owners?lastName=", verify=False)

    @task(50)
    def owners_specific(self):
        owner_id = randrange(owners) + 1
        self.client.get(f"/owners/{owner_id}", verify=False)

    @task(50)
    def owners_specific_edit(self):
        owner_id = randrange(owners) + 1
        self.client.get(f"/owners/{owner_id}/edit", verify=False)

    @task(50)
    def owners_specific_new_pet(self):
        owner_id = randrange(owners) + 1
        self.client.get(f"/owners/{owner_id}/pets/new", verify=False)

    @task(50)
    def vets(self):
        self.client.get("/vets.html", verify=False)

    # @task(5)
    # def oups(self):
    #     with self.client.get("/oups", catch_response=True, verify=False) as response:
    #         if response.status_code == 500:
    #             response.success()

    @task
    def owners_new(self):
        data = {}
        data['firstName'] = get_random_string(6)
        data['lastName'] = get_random_string(10)
        data['address'] = get_random_string(15)
        data['city'] = get_random_string(8)
        data['telephone'] = 5551234567
        self.client.post("/owners/new", data=data, verify=False)


    @task
    def owners_pets_new(self):
        owner_id = randrange(owners) + 1
        data = {}
        data['name'] = get_random_string(6)
        data['birthDate'] = '2000-01-01'
        data['type'] = choice(PET_TYPES)
        self.client.post(f"/owners/{owner_id}/pets/new", data=data, verify=False)

