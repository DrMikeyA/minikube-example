from src.entrypoint import HelloWorld


def test_one():
    hw = HelloWorld()
    hw.print()
    assert True
