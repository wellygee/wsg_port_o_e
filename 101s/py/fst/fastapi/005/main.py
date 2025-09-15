from fastapi import Depends, FastAPI
from sqlalchemy import text
from core.config import settings
from db.session import engine, get_db
from db.base_class import Base
from db.models.user import User

def create_db_and_tables():
    Base.metadata.create_all(bind=engine)

def start_application():
    app = FastAPI(title=settings.PROJECT_NAME, version=settings.PROJECT_VERSION)
    create_db_and_tables()
    return app

app = start_application()

@app.get("/")
def hello():
    return {"message": "Alembic!"}

@app.get("/db_test")
def db_test(db=Depends(get_db)):
    # v=db.query(User).all()
    v = db.execute(text("SELECT 1")).fetchall()
    return {"message": "Database test successful!", "v": str(v)}

@app.get("/health")
def health_check():
    return {"status": "healthy"}
