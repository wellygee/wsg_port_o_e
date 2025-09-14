## Start
```
cd ... .\basic
# python -m venv env   #create a virtual environment
virtualenv env -> powershell window
.\env\Scripts\activate  #activate your virtual environment
# source env/bin/activate on unix

pip install -r .\requirements.txt
uvicorn f_api:app --reload     #start server
```

# STARTERs

# pytest -s
# pytest -v --tb=short