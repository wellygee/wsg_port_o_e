# 000

## Start
```
git clone ....
cd ... .\000
# python -m venv env   #create a virtual environment
virtualenv env -> powershell window
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

# STARTERs