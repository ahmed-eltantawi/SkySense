import 'package:geocoding/geocoding.dart' hide Location;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';

class NoWeatherBody extends StatefulWidget {
  const NoWeatherBody({
    Key? key,
  }) : super(key: key);

  @override
  State<NoWeatherBody> createState() => _NoWeatherBodyState();
}

class _NoWeatherBodyState extends State<NoWeatherBody> {
  Location location = Location();

  bool _serviceEnabled = false;

  PermissionStatus? _permissionGranted;

  LocationData? _locationData;

  Future<void> _requestLocationPermission() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    setState(() {});
  }

  bool isLoading = false;
  bool isThereError = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(flex: 1),
            SizedBox(
                height: 400,
                child: isThereError
                    ? Stack(
                        alignment: AlignmentGeometry.center,
                        children: [
                          LottieBuilder.asset(
                              'assets/lottie/gps/smallGPS.json'),
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: LottieBuilder.asset(
                              'assets/lottie/gps/Error6.json',
                              repeat: false,
                              reverse: true,
                            ),
                          ),
                        ],
                      )
                    : isLoading
                        ? LottieBuilder.asset('assets/lottie/gps/loading.json')
                        : LottieBuilder.asset('assets/lottie/gps/gps.json')),
            const Text(
              'Allow the GPS to get started📍',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const Spacer(flex: 5),
            GestureDetector(
              onTap: () async {
                await onTap(context);
              },
              child: Container(
                  margin:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 40),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xffF4444E)),
                  height: 50,
                  width: double.infinity,
                  child: const Center(
                      child: Text(
                    'Get Started',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ))),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onTap(BuildContext context) async {
    {
      setState(() {
        isLoading = true;
      });
      await _requestLocationPermission();

      if (_locationData?.latitude == null || _locationData?.longitude == null) {
        setState(() {
          isThereError = true;
        });
        await errorMethod();
      } else {
        var getWeatherCubit = BlocProvider.of<GetWeatherCubit>(context);
        List<Placemark> placemark = await placemarkFromCoordinates(
            _locationData?.latitude ?? 52.2165157,
            _locationData?.longitude ?? 6.9437819);
        String? cityName = placemark[0].locality;

        if (cityName == null || cityName == '') {
          cityName = placemark[0].country;
        }

        await getWeatherCubit.getWeather(cityName: cityName!);
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> errorMethod() async {
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      isThereError = false;
    });
  }
}
