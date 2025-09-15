# from fastapi import FastAPI
# import time
# import requests
# import aiohttp
# import asyncio
# from typing import Optional
# from enum import Enum
# from datetime import datetime, timezone

# app = FastAPI(title="P001",version="1.0.0")

# @app.get("/generators")
# def generators():
#     cnt=0
#     while cnt<3:
#         match cnt:
#             case 0:
#                 yield {"message": "Hello, World!"}
#             case 1:
#                 yield {"message": "This is a generator example."}
#             case 2:
#                 yield {"message": "FastAPI is great for building APIs."}
#         cnt += 1

# @app.get("/countdown")
# def countdown():
#     numbers = []
#     for i in range(100, -1, -1):
#         numbers.append(i)
#     return {"numbers": numbers}

# @app.get("/async-countdown")
# async def async_countdown():
#     numbers = []
#     for i in range(100, -1, -1):
#         numbers.append(i)
#         await asyncio.sleep(0.01)
#     return {"numbers": numbers}

# def sync_net_call():
#     request_cnt = 10
#     url = "https://httpbin.org/get"
#     session = requests.Session()
#     for i in range(request_cnt):
#         print(f"making request {i}")
#         response = session.get(url)
#         if response.status_code == 200:
#             pass
#         print(response.json())

# @app.get("/net_call_sync")
# async def net_call_sync():
#     start = time.time()
#     sync_net_call()
#     end = time.time()

#     return {"time": f"Total time taken: {end - start} seconds"}

# async def async_net_call_rqst(session, req_num):
#     url = "https://httpbin.org/get"
#     print(f"making request {req_num}")
#     async with session.get(url) as response:
#         if response.status == 200:
#             print(await response.json())

# async def async_net_call():
#     request_cnt = 10
#     async with aiohttp.ClientSession() as session:
#         await asyncio.gather(
#             *[async_net_call_rqst(session, i) for i in range(request_cnt)]
#         )

# @app.get("/net_call_async")
# async def net_call_async():
#     # loop = asyncio.get_event_loop()
#     # start = time.time()
#     # loop.run_until_complete(async_net_call())
#     # end = time.time()

#     loop = asyncio.get_event_loop()
#     start = time.time()
#     await async_net_call()
#     end = time.time()    

#     return {"time": f"Total time taken: {end - start} seconds"}

# # --- Pydantic ---
# from pydantic import BaseModel, Field, field_validator

# class ItemType(str, Enum):
#     BOOK = "book"
#     ELECTRONICS = "electronics"
#     CLOTHING = "clothing"

# class CoolItem:
#     def coolify(self):
#         self.cool = True

# class Item(BaseModel, CoolItem):
#     name: str = Field(min_length=1, max_length=50, title="Name of the item", description="The name must be between 1 and 50 characters")
#     description: Optional[str] | None = None
#     price: float
#     tax: float | None = None
#     cool: bool = False
#     item_type: ItemType = ItemType.BOOK
#     created_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))
#     notes: list[str] = Field(default_factory=list) 

#     @field_validator('name')
#     @classmethod
#     def name_must_not_be_empty(cls, v):
#         if not v or v.strip() == "":
#             raise ValueError('Name must not be empty')
#         return v

#     @field_validator('price')
#     @classmethod
#     def price_must_be_positive(cls, v):
#         if v <= 0:
#             raise ValueError('Price must be positive')
#         return v
    
#     from pydantic import model_validator

#     @model_validator(mode="after")
#     def check_name_not_in_description(self):
#         if self.name and self.description and self.name in self.description:
#             raise ValueError('Name must not be part of the description')
#         return self

# @app.post("/items/")
# async def create_item(item: Item):
#     item.coolify()
#     return item
    

# # --- Dependency Injection ---
# from fastapi import Depends, HTTPException

# items = {
#     1: {"title": "First Item", "content": "This is the content of the first item."},
#     2: {"title": "Second Item", "content": "This is the content of the second item."},
# }

# def get_item(item_id: int):
#     return items.get(item_id)

# @app.get("/items/{item_id}")
# def read_item(item_id: int, item: dict = Depends(get_item)):
#     if item is None:
#         # return {"error": "Item not found"}
#         raise HTTPException(status_code=404, detail=f"Item {item_id} not found")
#     return item

# class GetObjOr404:
#     def __init__(self, model):
#         self.model = model

#     def __call__(self, id: int):
#         item = self.model.get(id)
#         if item is None:
#             raise HTTPException(status_code=404, detail=f"Item {id} not found")
#         return item

# items_dependency = GetObjOr404(items) # can be changed to other type of source eg dogs => get_dogs
# @app.get("/items-2/{id}")
# def read_item_2(id: int, item: dict = Depends(items_dependency)):
#     if item is None:
#         raise HTTPException(status_code=404, detail=f"Item {id} not found")
#     return item

# --- DI for Testing ---

from main import app, get_db_session

test_db = ["test_item1", "test_item2"]

def get_test_db_session():
    return test_db

from fastapi.testclient import TestClient

app.dependency_overrides[get_db_session] = get_test_db_session
client = TestClient(app)

def test_add_items():
    response = client.post("/items-db/test_item3")
    assert response.status_code == 200
    assert response.json() == {"rez": "test_item3 added to db"}
    assert "test_item3" in test_db

# docker exec -it xyz bash
# docker ps
# pytest -s
# pytest -v --tb=short