from setuptools import setup
import os
from glob import glob

package_name = 'autodrive_roboracer'

setup(
    name=package_name,
    version='0.1.0',
    packages=[package_name],
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
        (os.path.join('share', package_name, 'launch'), glob('launch/*.launch.py')), # Launch files
        (os.path.join('share', package_name, 'rviz'), glob('rviz/*.rviz')), # RViz configuration files
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='Chinmay Vilas Samak' 'Tanmay Vilas Samak',
    maintainer_email='csamak@clemson.edu' 'tsamak@clemson.edu',
    description='AutoDRIVE Ecosystem ROS 2 Package for RoboRacer',
    license='BSD',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
            'autodrive_bridge = autodrive_roboracer.autodrive_bridge:main', # AutoDRIVE ROS 2 bridge
            'teleop_keyboard = autodrive_roboracer.teleop_keyboard:main', # Teleoperation with keyboard
        ],
    },
)