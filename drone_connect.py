#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
© Copyright 2015-2016, 3D Robotics.
simple_goto.py: GUIDED mode "simple goto" example (Copter Only)

This module will
"""

from dronekit import connect, VehicleMode, LocationGlobalRelative
import time
from GeoTag import *
import argparse

def get_current_geo_tag(vehicle, ):



# Set up option parsing to get connection string


parser = argparse.ArgumentParser(description='Commands vehicle using vehicle.simple_goto.')
parser.add_argument('--connect',
                    help="Vehicle connection target string. If not specified, SITL automatically started and used.")
args = parser.parse_args()

connection_string = args.connect

# Connect to the Vehicle
print('Connecting to vehicle on: %s' % connection_string)
vehicle = connect(connection_string, wait_ready=True)



vehicle.close()

# Shut down simulator if it was started.
