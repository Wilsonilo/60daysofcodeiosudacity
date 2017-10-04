"""
Simple API Mashup, request geo location and returns first venue using Foursquare API
"""

import os
import sys
import json
import googlemaps
import requests

#Environment Vars
#Google Maps API KEY / FOURSQUARE key and secret
gmaps 			= googlemaps.Client(os.environ.get("MAPS_API_KEY"))
foursquareID 	= os.environ.get("FOURSQUARE_ID")
foursquareSE 	= os.environ.get("FOURSQUARE_SECRET")

#main
def main():
	if len(sys.argv) != 2:
		print("\nNeed string address to decode.\nUsage example: getGeoLocation.py \"Cancun, Mexico\"\n")
		return
	else :
		result = askGoogleWhatsup(sys.argv[1])
		#print(result[0]['geometry']['location'])

		#Should check Nil but for now let's go like this.
		lat = result[0]['geometry']['location']['lat']
		lon = result[0]['geometry']['location']['lng']
		position = (lat, lon)

		#print(position)
		searchRestaurant(position)

#Asks Google for Locations
def askGoogleWhatsup(string):
	geocode_result = gmaps.geocode(string)
	return geocode_result

#Ask foursquare
def searchRestaurant(location):

	#https://developer.foursquare.com/docs/

	#Set URI
	v = 20170930 # https://developer.foursquare.com/overview/versioning
	requestURI = "https://api.foursquare.com/v2/venues/search?ll={}, {}&client_id={}&client_secret={}&v={}".format(location[0], location[1], foursquareID, foursquareSE, v)
	#print(requestURI)

	#Make Request to foursquare, payload can be managed as an Object instead of using the URI
	#For now this is ok http://docs.python-requests.org/en/master/user/quickstart/
	r = requests.get(requestURI)

	#Get json
	jsonResponse = r.json()

	#Filter
	responseKey = jsonResponse['response']

	#Get venues
	venuesKey	= responseKey['venues']

	print("Amount of venues: {}, first Venue: {} ".format(len(venuesKey), venuesKey[0])

	#looping and working placeholder for venues is not worked, i got lazy.
	#Solution from Udacity: https://github.com/udacity/APIs/blob/master/Lesson_2/12_Make_Your_Own_Mashup/solution_code/findARestaurant.py

if __name__ == '__main__':
    main()
