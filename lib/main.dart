import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/views/home_view.dart';
import 'package:weather_app/appThem.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit(),
      child: Builder(
        builder: (context) {
          return BlocBuilder<GetWeatherCubit, WeatherStates>(
            builder: (context, state) {
              return MaterialApp(
                theme: appTheme(
                    context,
                    BlocProvider.of<GetWeatherCubit>(context)
                        .weatherModel
                        ?.conditionCode),
                debugShowCheckedModeBanner: false,
                home: const HomeView(),
              );
            },
          );
        },
      ),
    );
  }
}
