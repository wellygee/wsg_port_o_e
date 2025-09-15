from pydantic import BaseModel, EmailStr, Field


class User(BaseModel):
    email: EmailStr = Field(..., example="user@example.com")
    password: str = Field(..., min_length=8, example="password123")

