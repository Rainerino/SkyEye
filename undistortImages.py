import cv2
import os
from GeoTag import geotag

from sky_eye import create_or_purge_dir
from sky_eye import DEBUG

def read_camera_parameter(path):
	fs = cv2.FileStorage(path, cv2.FILE_STORAGE_READ)
	if not fs.isOpened():
		print("Error! Failed to open")
		raise IOError
	cameraMatrix = fs.getNode('camera_matrix').mat()
	distCoeffs = fs.getNode("distortion_coefficients").mat()

	print(cameraMatrix)
	print(distCoeffs)

	fs.release()
	return cameraMatrix, distCoeffs


def geotag_transfer_images(from_image_path, to_image_path):
	lat, lon, alt, hdg = geotag.read_geo_tag(from_image_path)
	geotag.write_geo_tag(to_image_path, lat, lon, alt, hdg)


read_camera_parameter("./out_camera_data.xml")


def undistort_image_in_dir(path, to_path):
	mtx, dist = read_camera_parameter("./out_camera_data.xml")

	create_or_purge_dir(to_path)

	for file in os.listdir(path):
		if file.endswith(".JPEG"):
			from_file_path = os.path.join(path, file)
			to_file_path = os.path.join(to_path, file)

			print(from_file_path)

			raw_img = cv2.imread(from_file_path)

			if DEBUG:
				cv2.imshow('image', raw_img)
				cv2.waitKey(0)

			undistorted_img = cv2.undistort(raw_img, mtx, dist)

			if DEBUG:
				cv2.imshow('image', undistorted_img)
				cv2.waitKey(0)

			cv2.imwrite(to_file_path, undistorted_img)
			geotag_transfer_images(from_file_path, to_file_path)

undistort_image_in_dir("./raw_image", "./processed_image")
