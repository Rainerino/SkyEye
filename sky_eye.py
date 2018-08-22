import cv2
import dronekit
import os
from GeoTag import geotag
import time

DEBUG = False


def create_or_purge_dir(path_output_dir):
	if not os.path.exists(path_output_dir):
		os.makedirs(path_output_dir)
	else:
		# remove everything in the file
		folder = path_output_dir
		for the_file in os.listdir(folder):
			file_path = os.path.join(folder, the_file)
			try:
				if os.path.isfile(file_path):
					os.unlink(file_path)
			# elif os.path.isdir(file_path): shutil.rmtree(file_path)
			except Exception as e:
				print(e)


def main():
	path_output_dir = "./raw_image"
	create_or_purge_dir(path_output_dir)

	vehicle = None

	if not DEBUG:
		while True:
			try:
				vehicle = dronekit.connect("/dev/ttyUSB0", wait_ready=True, baud=1500000)
			except:
				print("Connection failed")
				time.sleep(3)
			else:
				print("Connected")
				break

		while not vehicle.home_location:
			cmds = vehicle.commands
			cmds.download()
			cmds.wait_ready()
			if not vehicle.home_location:
				print(" Waiting for home location ...")
		# We have a home location, so print it!
		print("\n Home location: %s" % vehicle.home_location)

	while not vehicle.armed:
		print("waiting to be armed")
		time.sleep(1)

	vidcap = cv2.VideoCapture(0)

	count = 0

	while vidcap.isOpened():
		success, image = vidcap.read()
		if success:

			current_path = os.path.join(path_output_dir, '%d.JPEG') % count
			cv2.imwrite(current_path, image)

			if DEBUG:
				lat = 1
				lon = 1
				alt = 1
				hdg = 1
			else:
				lat = vehicle.location.global_relative_frame.lat
				lon = vehicle.location.global_relative_frame.lon
				alt = vehicle.location.global_relative_frame.alt
				if alt < 0:
					alt = 0.15
				hdg = vehicle.heading

			print("Current location is at: lat: %f, lon: %f, alt %f, hdg %f" % (lat, lon, alt, hdg))
			geotag.write_geo_tag(current_path, lat, lon, alt, hdg)

			count += 1
		else:
			break
		time.sleep(3)

	cv2.destroyAllWindows()
	vidcap.release()


# When everything done, release the capture


if __name__ == '__main__':
	main()
