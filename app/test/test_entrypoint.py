import os
from src.run import hello_world
import unittest
import tempfile


class FlaskTestCase(unittest.TestCase):
    # def setUp(self):

    # self.app = flaskr.app.test_client()

    # def tearDown(self):

    def test1(self):
        print(f"{hello_world()}")
        assert True


if __name__ == "__main__":
    unittest.main()
