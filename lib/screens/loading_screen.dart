// screens/loading_screen.dart
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Position? position;
  bool? isLoaded;

  void getLocation() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Enter the button to get your location"),
            ElevatedButton(
              onPressed: () async {

                //display loader
                setState(() {
                  isLoaded = true;
                });
                
                //ask permission
                await Geolocator.requestPermission();
                
                //get location
                Geolocator.getCurrentPosition().then(
                  (positionValue) => setState(() {
                    position = positionValue;
                    isLoaded = false;
                  }),
                );
              },
              child: Text('Get Location'),
            ),
            SizedBox(height: 32),
            if(isLoaded ?? false) CircularProgressIndicator(),
            Text('${position?.latitude ?? ""}'),
            SizedBox(height: 8),
            Text('${position?.longitude ?? ""}'),
          ],
        ),
      ),
    );
  }
}
