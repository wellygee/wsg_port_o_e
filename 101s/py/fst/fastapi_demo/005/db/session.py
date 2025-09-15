from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

from core.config import settings
from typing import Generator

SQLALCHEMY_DATABASE_URL = settings.SQLALCHEMY_DATABASE_URL
print("DB URL:", SQLALCHEMY_DATABASE_URL)
engine = create_engine(SQLALCHEMY_DATABASE_URL)

SESSION_LOCAL = sessionmaker(autocommit=False, autoflush=False, bind=engine)

def get_db() -> Generator:
    db = SESSION_LOCAL()
    try:
        yield db
    finally:
        db.close()

