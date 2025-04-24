import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:live_tracking/constants.dart';

class LiveTrackingPage extends StatefulWidget {
  const LiveTrackingPage({super.key});

  @override
  State<LiveTrackingPage> createState() => _LiveTrackingPageState();
}

String? selectedValue = colonias.keys.first;

Map<String, dynamic> colonias = {
  '96700, Col. Minatitlan Centro': [
    LatLng(17.984976276332784, -94.54507352605951),
    LatLng(17.986561563708833, -94.5461503932459),
    LatLng(17.98672592556354, -94.54696218519639),
    LatLng(17.986928510893467, -94.54772977065647),
    LatLng(17.98750146449877, -94.54982934729816),
    LatLng(17.98784238162172, -94.55133955947419),
    LatLng(17.988063963416337, -94.55257476411047),
    LatLng(17.98761964917892, -94.55173144997609),
  ],
  '96710, Coppel Insurgentes': [
    LatLng(17.994074006328137, -94.57608119896605),
    LatLng(17.99620252672911, -94.57639982906404),
    LatLng(17.996501960580026, -94.57694605209474),
    LatLng(17.995946384109814, -94.57677915061078),
    LatLng(17.99466566542822, -94.57751503440636),
    LatLng(17.994434382241607, -94.57779069685722),
    LatLng(17.99449165051676, -94.57829649060255),
  ],
  '96846, Coppel Beisborama': [
    LatLng(17.996880930566235, -94.54100835140603),
    LatLng(17.999077457762517, -94.53825000885844),
    LatLng(17.999406898621853, -94.53804809029685),
    LatLng(17.999654136503217, -94.53789817437541),
    LatLng(18.002699980097937, -94.53654002522082),
    LatLng(18.00238297498436, -94.5365161024707),
    LatLng(18.001973445997685, -94.53678722702595),
  ],
};

List<LatLng> routePoints = [];

class _LiveTrackingPageState extends State<LiveTrackingPage> {
  final Completer<GoogleMapController> _googleMapController = Completer();
  final PolylinePoints polylinePoints = PolylinePoints();

  int polylineIndex = 0;
  Timer? markerTimer;
  Marker? movingMarker;
  int routeIndex = 0;
  bool hasFinished = false;

  final Set<Circle> _circles = {};
  final Set<Marker> _markers = {};
  List<LatLng> polyPoints = [];

  @override
  void initState() {
    super.initState();
    routePoints = colonias[selectedValue] ?? [];
    _initializeZones();
  }

  void _initializeZones() {
    final List<Map<String, dynamic>> circleData = [
      {
        "id": "circle_1",
        "position": LatLng(17.98672592556354, -94.54696218519639),
        "color": Colors.blue,
        "radio": 100.0,
      },
      {
        "id": "circle_2",
        "position": LatLng(17.98784238162172, -94.55133955947419),
        "color": Colors.red,
        "radio": 210.0,
      },
      {
        "id": "circle_3",
        "position": LatLng(17.994434382241607, -94.57779069685722),
        "color": Colors.blue,
        "radio": 55.0,
      },
      {
        "id": "circle_4",
        "position": LatLng(17.996244933615575, -94.57665662831363),
        "color": Colors.red,
        "radio": 50.0,
      },
      {
        "id": "circle_5",
        "position": LatLng(17.999406898621853, -94.53804809029685),
        "color": Colors.blue,
        "radio": 55.0,
      },
      {
        "id": "circle_6",
        "position": LatLng(18.00238297498436, -94.5365161024707),
        "color": Colors.red,
        "radio": 53.0,
      },
    ];

    for (var data in circleData) {
      _markers.add(
        Marker(
          markerId: MarkerId('marker_${data["id"]}'),
          position: data["position"],
        ),
      );

      _circles.add(
        Circle(
          circleId: CircleId(data["id"]),
          center: data["position"],
          radius: data["radio"],
          fillColor: data["color"].withOpacity(0.2),
          strokeColor: data["color"],
          strokeWidth: 2,
        ),
      );
    }
  }

  Future<void> moveCameraTo(LatLng position) async {
    final controller = await _googleMapController.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(position, 18));
  }

  void restartTracking() {
    setState(() {
      routeIndex = 0;
      polylineIndex = 0;
      polyPoints.clear();
      movingMarker = null;
      hasFinished = false;
    });

    getPolyPoints();
  }

  LatLng get sourceLocation => routePoints[routeIndex];
  LatLng get destinationLocation => routePoints[routeIndex + 1];

  Future<void> getPolyPoints() async {
    try {
      PolylineResult polylineResult = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: google_api_key,
        request: PolylineRequest(
          origin: PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
          destination: PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
          mode: TravelMode.driving,
          optimizeWaypoints: true,
        ),
      );

      if (polylineResult.points.isNotEmpty) {
        setState(() {
          polyPoints = polylineResult.points
              .map((point) => LatLng(point.latitude, point.longitude))
              .toList();
          polylineIndex = 0;
        });

        startMovingMarker();
      }
    } catch (e) {
      print(e);
    }
  }

  void startMovingMarker() {
    markerTimer?.cancel();

    markerTimer = Timer.periodic(Duration(milliseconds: 400), (timer) async {
      if (polylineIndex >= polyPoints.length) {
        timer.cancel();
        onDestinationReached();
        return;
      }

      LatLng newPosition = polyPoints[polylineIndex];

      final controller = await _googleMapController.future;
      controller.animateCamera(CameraUpdate.newLatLng(newPosition));

      setState(() {
        movingMarker = Marker(
          markerId: MarkerId("moving"),
          position: newPosition,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        );
        polylineIndex++;
      });
    });
  }

  void onDestinationReached() async {
    if (hasFinished) return;

    if (routeIndex + 1 >= routePoints.length - 1) {
      markerTimer?.cancel();
      setState(() {
        hasFinished = true;
        movingMarker = null;
      });
      await Future.delayed(Duration(milliseconds: 300));
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: Text("Fin de la ruta"),
          content: Text("¿El usuario estaba en casa?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  polyPoints.clear();
                });
              },
              child: Text("Sí"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  polyPoints.clear();
                });
              },
              child: Text("No"),
            ),
          ],
        ),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text("¿Continuar la ruta?"),
        content: Text("¿El usuario estaba en casa?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                routeIndex++;
                polyPoints.clear();
                polylineIndex = 0;
                movingMarker = null;
              });
              getPolyPoints();
            },
            child: Text("Sí"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                routeIndex++;
                polyPoints.clear();
                polylineIndex = 0;
                movingMarker = null;
              });
              getPolyPoints();
            },
            child: Text("No"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    markerTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        title: const Text("Live Tracking"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          restartTracking();
          getPolyPoints();
        },
        backgroundColor: const Color.fromARGB(255, 212, 243, 33),
        child: Icon(Icons.play_arrow),
      ),
      body: Stack(
        children: [
          if (routePoints.isNotEmpty)
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: sourceLocation,
                zoom: 18,
              ),
              onMapCreated: (controller) {
                _googleMapController.complete(controller);
              },
              markers: {
                for (var i = 0; i < routePoints.length; i++)
                  Marker(
                    markerId: MarkerId('point$i'),
                    position: routePoints[i],
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      i == 0
                          ? BitmapDescriptor.hueAzure
                          : BitmapDescriptor.hueAzure,
                    ),
                  ),
                if (movingMarker != null) movingMarker!,
              },
              circles: _circles,
              polylines: {
                Polyline(
                  polylineId: PolylineId("route"),
                  points: polyPoints,
                  width: 5,
                  color: Colors.amber,
                  consumeTapEvents: true,
                ),
              },
            ),
          Positioned(
            top: 20,
            left: 16,
            child: Container(
              width: 290,
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
              ),
              child: DropdownButtonFormField<String>(
                value: selectedValue,
                decoration: InputDecoration(border: InputBorder.none),
                items: colonias.keys.map<DropdownMenuItem<String>>((colonia) {
                  return DropdownMenuItem<String>(
                    value: colonia,
                    child: Text(colonia),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                    routePoints = colonias[selectedValue] ?? [];
                    routeIndex = 0;
                    polylineIndex = 0;
                    polyPoints.clear();
                    movingMarker = null;
                    hasFinished = false;
                  });
                  if (routePoints.isNotEmpty) {
                    moveCameraTo(routePoints.first);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
