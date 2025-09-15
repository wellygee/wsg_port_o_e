from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

from core.config import settings

# SQLALCHEMY_DATABASE_URL = settings.SQLALCHEMY_DATABASE_URL
# print("DB URL:", SQLALCHEMY_DATABASE_URL)
# engine = create_engine(SQLALCHEMY_DATABASE_URL)

SQLALCHEMY_DATABASE_URL = "sqlite:///./sql_app.db"

engine = create_engine(SQLALCHEMY_DATABASE_URL, connect_args={"check_same_thread": False})

SESSION_LOCAL = sessionmaker(autocommit=False, autoflush=False, bind=engine)
