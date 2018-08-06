from setuptools import setup

setup(name='sky_eye',
      version='0.1',
      description='',
      url='https://github.com/Rainerino/sky_eye.git',
      author='Me',
      author_email='albertyanyy@gmail.com',
      license='MIT',
      packages=['sky_eye'],
      install_requires=[
          'piexif',
	      'dronekit',

      ],
      zip_safe=False)