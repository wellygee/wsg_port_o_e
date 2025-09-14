

# JobBoard-Fastapi 
> A job board app using fastapi

## Udemy Course Link
[Udemy FastAPI Course](https://www.udemy.com/course/fastapi-course/?referralCode=866F5B710822DE67352F)


![](backend/static/images/lite.gif)

## Technology Stack:
* FastAPI
* Uvicorn (server)
* Pytest
* Sqlalchemy
* Postgres


## How to start the app ?
```
git clone https://github.com/nofoobar/JobBoard-Fastapi.git
cd .\JobBoard-Fastapi\
python -m venv env   #create a virtual environment
.\env\Scripts\activate  #activate your virtual environment
cd .\backend\
pip install -r .\requirements.txt
uvicorn main:app --reload     #start server
visit  127.0.0.1:8000/



# WG -> use docker-compose up and navigate to 
-> http://127.0.0.1:8000/docs#
-> http://127.0.0.1:8000/docs#/Jobs/retreive_all_jobs_job_all_get
```

Features:
 - ✔️ Course [Udemy FastAPI Course](https://www.udemy.com/course/fastapi-course/?referralCode=866F5B710822DE67352F)
 - ✔️ Serving Template
 - ✔️ Static Files in Development
 - ✔️ Connecting to Database
 - ✔️ Schemas
 - ✔️ Dependency Injection
 - ✔️ Password Hashing
 - ✔️ Unit Testing (What makes an app stable)
 - ✔️ Authentication login/create user/get token
 - ✔️ Authorization/Permissions 
 - ✔️ Webapp (Monolithic)

# WG Refs
- https://www.udemy.com/course/fastapi-course/learn/lecture/26861476#learning-tools
- https://github.com/nofoobar/fastapi-course

