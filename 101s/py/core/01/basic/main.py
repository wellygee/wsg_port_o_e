from samples0 import sample0
import requests as r



print(f"Hello, World :)! {__name__}")

# sample0()

url = "http://api.quotable.io/random"

def fetch_url():
    response = r.get(url)
    # print(response.json())
    return response

print(fetch_url().json())

#################################################
# import requests

# def sync_net_call():
#     request_cnt = 2
#     # url = "https://httpbin.org/get"
#     url = "http://api.quotable.io/random"
#     session = requests.Session()
#     for i in range(request_cnt):
#         print(f"making request {i}")
#         response = session.get(url)
#         if response.status_code == 200:
#             pass
#         print(response.json())

# sync_net_call()