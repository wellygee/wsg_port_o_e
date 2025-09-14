# from samples import always_pass, always_fail
# from pytest import fixture, assertions

def test_always_pass(capfd):
    # always_pass()
    assert True
    # captured = capfd.readouterr()
    # assert "This will pass" in captured.out

def test_always_fail(capfd):
    # always_fail()
    assert False
    # captured = capfd.readouterr()
    # assert "This will fail" in captured.out
