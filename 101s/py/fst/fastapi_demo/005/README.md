# 000

## Start
```
git clone ....
cd ... .\000
python -m venv env   #create a virtual environment
.\env\Scripts\activate  #activate your virtual environment
# source env/bin/activate on unix

pip install -r .\requirements.txt
uvicorn f_api:app --reload     #start server


-- OR --

docker-compose up

Docs
    -> http://127.0.0.1:8000/docs#

curl -X 'GET' \
  'http://127.0.0.1:8000/' \

docker-composer down

```

# PG

# Alembic
## TODO:
-> main db init steps commented out so that we only use alembic
-> need to generate migrations ***this step wasn't done; finally -> used powershel
        - point to local pg instance (.env config) or copy accross output from build
      alembic revision --autogenerate -m 'create user and blog tables'
-> need to apply there on docker-compose up or manually

``` ps
(env) PS C:\work\portfolio_aug_25\wsg_port_o_e\101s\fastapi\fastapi-course\005> 
(env) PS C:\work\portfolio_aug_25\wsg_port_o_e\101s\fastapi\fastapi-course\005> uvicorn main:app --reload
```