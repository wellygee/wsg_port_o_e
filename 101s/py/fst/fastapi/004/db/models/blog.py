import datetime
from sqlalchemy import Column, Integer, String, Boolean, ForeignKey, DateTime
from sqlalchemy.orm import relationship

from db.base_class import Base


class BlogPost(Base):
    __tablename__ = "blog_posts"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, index=True, nullable=False)
    content = Column(String)
    published = Column(Boolean, default=True)
    created_at = Column(DateTime, default=datetime.datetime.utcnow)

    author_id = Column(Integer, ForeignKey("users.id"))
    author = relationship("User", back_populates="blog_posts")
