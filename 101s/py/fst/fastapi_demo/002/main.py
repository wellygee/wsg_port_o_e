from fastapi import FastAPI
from core.config import settings
from db.session import engine
from db.base_class import Base

def create_db_and_tables():
    Base.metadata.create_all(bind=engine)

def start_application():
    app = FastAPI(title=settings.PROJECT_NAME, version=settings.PROJECT_VERSION)
    create_db_and_tables()
    return app

app = start_application()

@app.get("/")
def hello():
    return {"message": "SQLAlchemy!"}

@app.get("/health")
def health_check():
    return {"status": "healthy"}