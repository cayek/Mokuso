from setuptools import setup, find_packages

setup(name='mokuso',
      version='0.1',
      url='http://github.com/cayek/Mokuso/',
      description='Personal python package',
      author='Kevin Caye',
      author_email='',
      license='GNU',
      # to find all sub dir with a __init__.py file in.
      packages=find_packages(),
      # Rmk : a pkg is dir with .py files which are modules :D.
      zip_safe=False,
      # for test
      test_suite='nose.collector',
      tests_require=['nose'],
      entry_points={
          'console_scripts': [
              'hadjime = mokuso.hadjime.__main__:main'
          ]
      },
      )
