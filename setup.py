from setuptools import setup
from wdl2cwl import __version__

setup(name="wdl2cwl",
      version=__version__,
      description='Convertion from WDL workflow descriptions to CWL',
      author='Peter Amstutz, Anton Khodak',
      author_email='anton.khodak@ukr.net',
      url='https://github.com/common-workflow-language/wdl2cwl',
      install_requires=['future', 'wdl', 'jinja2'],
      entry_points={
          'console_scripts': [
              'wdl2cwl = wd2cwl.main:main'
          ]
      },
      classifiers=[
          'Development Status :: 3 - Alpha',
          'Operating System :: POSIX',
          'Intended Audience :: Developers',
          'Environment :: Console',
          'License :: OSI Approved :: Apache Software License',
      ],
      include_package_data=True,
      )
