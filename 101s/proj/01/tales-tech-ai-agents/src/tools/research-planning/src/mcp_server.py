import random
import re
import uuid
from datetime import datetime, timedelta
from typing import Annotated

from faker import Faker
from mcp.server.fastmcp import FastMCP
from pydantic import Field

mcp = FastMCP("weather")
fake = Faker()


def validate_iso_date(date_str: str, param_name: str) -> datetime.date:
    """
    Validates that a string is in ISO format (YYYY-MM-DD) and returns the parsed date.

    Args:
        date_str: The date string to validate
        param_name: Name of the parameter for error messages

    Returns:
        The parsed date object

    Raises:
        ValueError: If the date is not in ISO format or is invalid
    """
    iso_pattern = re.compile(r"^\d{4}-\d{2}-\d{2}$")
    if not iso_pattern.match(date_str):
        raise ValueError(f"{param_name} must be in ISO format (YYYY-MM-DD), got: {date_str}")

    try:
        return datetime.strptime(date_str, "%Y-%m-%d").date()
    except ValueError as e:
        raise ValueError(f"Invalid {param_name}: {e}")

@mcp.tool()
async def suggest_books(
    domain: Annotated[str, Field(description="Genre or Theme (subject, idea or topic) to search for books")],
    earliest_publication: Annotated[str, Field(description="Earliest publication date in ISO format (YYYY-MM-DD)")],
    latest_publication: Annotated[str, Field(description="Latest publication date in ISO format (YYYY-MM-DD)")],
) -> str:
    """
    Suggest books based on the domain and dates.
    """
    # Validate dates
    earliest_date = validate_iso_date(earliest_publication, "earliest_publication")
    latest_date = validate_iso_date(latest_publication, "latest_publication")

    # Ensure latest publication is after earliest publication
    if latest_date <= earliest_date:
        raise ValueError("latest_publication date must be after earliest_publication date")

    # Create realistic mock data for books
    book_domain = ["Medicine", "Engineering", "Humanities"]
    book_theme = ["Adventure", "War", "Science", "History", "Royalty", "College", "Sports", "Space", "Time travel", "AI", "Cancer", "Physics", "Chemistry", "Biology"]

    # Generate a rating between 3.0 and 5.0
    def generate_rating():
        return round(random.uniform(3.0, 5.0), 1)

    # Generate a price based on book genre
    def generate_price(book_domain):
        price_ranges = {
            "Engineering": (20, 60),
            "Medicine": (18, 35),
            "Humanities": (8, 15),
        }
        min_price, max_price = price_ranges.get(book_domain, (100, 300))
        return round(random.uniform(min_price, max_price))

    # Generate between 3 and 8 books
    num_books = random.randint(3, 8)
    books = []

    for i in range(num_books):
        book = {
            "title": fake.catch_phrase(),
            "author": fake.name(),
            "domain": domain,
            "theme": random.choice(book_theme),
            "publication_date": fake.date_between(start_date=earliest_date, end_date=latest_date),
            "rating": generate_rating(),
            "price": generate_price(domain),
            "isbn": str(uuid.uuid4()),  # Generate a random ISBN
        }
        books.append(book)

    # Sort by rating to show best books first
    books.sort(key=lambda x: x["rating"], reverse=True)
    return books

@mcp.tool()
async def suggest_articles(
    domain: Annotated[str, Field(description="Domain (topic or subject) to search for articles")],
    earliest_date: Annotated[str, Field(description="Earliest publication date in ISO format (YYYY-MM-DD)")],
    latest_date: Annotated[str, Field(description="Latest publication date in ISO format (YYYY-MM-DD)")],
) -> str:
    """
    Suggest articles based on domains and dates.
    """
    # Validate dates
    earliest_pub_date = validate_iso_date(earliest_date, "earliest_date")
    latest_pub_date = validate_iso_date(latest_date, "latest_date")

    # Ensure latest publication is after earliest publication
    if latest_pub_date <= earliest_pub_date:
        raise ValueError("latest_date must be after earliest_date")

    # Create realistic mock data for articles
    articles = []
    num_articles = random.randint(3, 8)

    for _ in range(num_articles):
        article = {
            "title": fake.catch_phrase(),
            "author": fake.name(),
            "domain": domain,
            "publication_date": fake.date_between(start_date=earliest_pub_date, end_date=latest_pub_date),
            "abstract": fake.paragraph(),
        }
        articles.append(article)

    # Sort by publication date to show most recent articles first
    articles.sort(key=lambda x: x["publication_date"], reverse=True)
    return articles

if __name__ == "__main__":
    mcp.run(transport="sse")
