import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  //variables for drawPolyLine
  final Set<Marker> markers = {};
  final Set<Polyline> polyline = {};

  List<LatLng> latLen = [
    const LatLng(19.0759837, 72.8776559),
    const LatLng(28.679079, 77.069710),
    const LatLng(26.850000, 80.949997),
    const LatLng(24.879999, 74.629997),
    const LatLng(16.166700, 74.833298),
    const LatLng(12.971599, 77.594563),
  ];

  //variables for getCurrentLocation
  final Completer<GoogleMapController> myController =
      Completer<GoogleMapController>();
  late LatLng currentLocation;
  bool isMarkerVisible = false;

  @override
  void initState() {
    super.initState();

    checkBeforeGettingLocation();
    isMarkerVisible = true;

    /*  int i;
    for (i = 0; i < latLen.length; i++) {
      markers.add(Marker(
        markerId: MarkerId(i.toString()),
        position: latLen[i],
        infoWindow:
            const InfoWindow(title: "source", snippet: "path for hotel"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ));
      setState(() {});
    }

    polyline.add(Polyline(
      polylineId:PolylineId("1"),
      points: latLen,
      color: Colors.red
    ));*/

    currentLocation = const LatLng(19.228825, 72.854118);
    // isMarkerVisible = false;
  }

  /*@override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
            target: LatLng(19.228825, 72.854118), zoom: 15, tilt: 50.0),
        polylines: polyline,
        markers: markers,
        onMapCreated: (GoogleMapController controller){
             myController.complete(controller);
        },

      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return Scaffold(
          body: GoogleMap(
            initialCameraPosition: const CameraPosition(
                target: LatLng(19.228825, 72.854118), zoom: 15, tilt: 50.0),
            onMapCreated: (GoogleMapController controller) {
              myController.complete(controller);
            },
            markers: {
              Marker(
                  draggable: true,
                  onDragEnd: (location) {
                    print(
                        "location ${location.latitude},${location.longitude}");
                  },
                  infoWindow:
                      const InfoWindow(title: "Source", snippet: "Something"),
                  markerId: const MarkerId("marker1"),
                  position: const LatLng(19.228825, 72.854118),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueMagenta)),
              Marker(
                  visible: isMarkerVisible,
                  infoWindow: const InfoWindow(
                      title: "Current Location", snippet: "my location"),
                  markerId: const MarkerId("marker2"),
                  position: currentLocation,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueGreen)),
            },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
            onPressed: () {
              isMarkerVisible = true;
              checkBeforeGettingLocation();
              // setState(() {});
            },
            child: const Icon(
              Icons.my_location,
              size: 24,
            ),
          ),
        );
      },
    );
  }

  void checkBeforeGettingLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please enabled location services"),
      ));
    } else {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Please allow ur app to access ur current location"),
          ));
        } else if (permission == LocationPermission.deniedForever) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'You \'ve denied permission forever therefore u want be able to access this feature '),
          ));
        } else {
          // permission granted !
          //getCurrentLocation();
          getContinuousLocation();
        }
      } else {
        //permission already given
        // getCurrentLocation();
        getContinuousLocation();
      }
    }
  }

  Future<void> getCurrentLocation() async {
    var pos = await Geolocator.getCurrentPosition();
    currentLocation = LatLng(pos.latitude, pos.longitude);

    final GoogleMapController controller = await myController.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: currentLocation, zoom: 15, tilt: 60.0)));
    print("location ===> ${pos.latitude},${pos.longitude}");
    setState(() {});
  }

  getContinuousLocation() {
    const LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high, timeLimit: Duration(seconds: 10));
    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      print(position == null
          ? 'Unknown'
          : '${position.latitude.toString()}, ${position.longitude.toString()}');
    });
  }
}
