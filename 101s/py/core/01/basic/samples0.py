def sample0():
    print(f"Sample 0 {__name__}")

# -> prints on import - not ideal
# sample0()

 # -> print output only when this file is run directly
if __name__ == "__main__":
    sample0()

# to test
"""

(env) PS C:\work\portfolio_aug_25\tests\basic> python .\main.py
Hello, World :)! __main__

(env) PS C:\work\portfolio_aug_25\tests\basic> python .\samples.py
Sample 0 __main__

"""
