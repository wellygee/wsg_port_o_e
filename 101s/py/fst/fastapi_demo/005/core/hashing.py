from passlib.context import CryptContext

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


class Hasher:
    @staticmethod
    def get_password_hash(password: str) -> str:
        return pwd_context.hash(password)

    @staticmethod
    def verify_password(plain_password: str, hashed_password: str) -> bool:
        return pwd_context.verify(plain_password, hashed_password)

# Usage example:
# hashed = Hasher.get_password_hash("mysecretpassword")
# is_valid = Hasher.verify_password("mysecretpassword", hashed)
# print(f"Hashed: {hashed}, Is valid: {is_valid}")

# Hasher.verify_password("mysecretpassword", hashed)