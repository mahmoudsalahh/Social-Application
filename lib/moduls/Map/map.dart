import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {

  @override
  State<MapScreen> createState() => _MapScreenState();
}
CameraPosition  _initialCameraPosition  =  CameraPosition(
  target: LatLng(26.549999, 31.700001),
  bearing: 60,
  tilt:45 ,
  zoom: 4,
);
Set<Marker> myMarkers ={
  Marker(
      markerId: MarkerId('l1'),
      position: LatLng(
        _initialCameraPosition.target.latitude,
        _initialCameraPosition.target.longitude,
      ))
};
class _MapScreenState extends State<MapScreen> {
  late GoogleMapController googleMapController;
  late LatLng  _currentMapPosition ;
  _onCameraMove(CameraPosition position)=>_currentMapPosition = position.target;
  @override
  Widget build(BuildContext context) {
    return GoogleMap(initialCameraPosition:_initialCameraPosition,
      onCameraMove: _onCameraMove,
      onMapCreated: (controller) {
        googleMapController=controller;} ,
      markers: myMarkers,
      onTap: (LatLng current)async{
        print(current.latitude);
        print(current.longitude);
        setState(() {
          myMarkers.add(Marker(markerId: MarkerId('l9'),
            position: LatLng(current.longitude,current.latitude),
          ),
          );
        });




      },
    );
  }
}

