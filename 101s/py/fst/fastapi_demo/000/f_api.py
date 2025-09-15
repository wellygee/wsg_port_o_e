from fastapi import FastAPI

app = FastAPI(title="P000",version="1.0.0")

@app.get("/")
def my_root():
    return {"message": "Hello, P000!"}