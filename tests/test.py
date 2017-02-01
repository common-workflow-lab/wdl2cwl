import os
import subprocess
import unittest


class ValidateTestCase(unittest.TestCase):
    test_dir = "results/"

    def test_tools_general(self):
        for toolkit in os.listdir(self.test_dir):
            for tool in os.listdir(self.test_dir+toolkit):
                # TODO: rewrite universally
                path = os.path.join(os.path.dirname(os.path.abspath(__file__)), '{0}{1}/{2}'.format(self.test_dir, toolkit, tool))
                print(os.getcwd())
                try:
                    result = subprocess.check_output(['/usr/local/bin/cwltool', '--validate', '{0}'.format(path)])
                except subprocess.CalledProcessError as e:
                    print(e.output)
                    self.fail("Validation failed")
