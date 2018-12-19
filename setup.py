from setuptools import setup, find_packages
from wdl2cwl import __version__

setup(name="wdl2cwl",
      version="0.2.1",
      description='Convertion from WDL workflow descriptions to CWL',
      author='Peter Amstutz, Anton Khodak',
      author_email='anton.khodak@ukr.net',
      url='https://github.com/common-workflow-language/wdl2cwl',
      install_requires=[
          'future',
          'jinja2',
          'wdl-parser'
      ],
      packages=find_packages(),
      package_data={'wdl2cwl': ['templates/*', 'expression-tools/*']},
      include_package_data=True,
      entry_points={
          'console_scripts': [
              'wdl2cwl=wdl2cwl.main:main'
          ]
      },
      classifiers=[
          'Development Status :: 3 - Alpha',
          'Operating System :: POSIX',
          'Intended Audience :: Developers',
          'Environment :: Console',
          'License :: OSI Approved :: Apache Software License',
      ],
      )
