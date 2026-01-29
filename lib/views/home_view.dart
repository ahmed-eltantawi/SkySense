import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/views/error.dart';
import 'package:weather_app/views/search_view.dart';
import 'package:weather_app/widgets/no_weather_body.dart';
import 'package:weather_app/widgets/weather_info_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const SearchView();
                  },
                ));
              },
              icon: const Icon(Icons.search)),
        ],
        title: const Text('Sky Sense'),
      ),
      body: BlocBuilder<GetWeatherCubit, WeatherStates>(
        builder: (context, state) {
          if (state is NoInternetState) {
            return const Error(
              image: 'assets/lottie/general_errors/noInternet.json',
              text: "Please make sure \nWi-Fi is enabled.",
            );
          } else if (state is WeatherInitialState) {
            return const NoWeatherBody();
          } else if (state is WeatherLoadedState) {
            return WeatherInfoBody(weatherModel: state.weatherModel);
          } else {
            return const Error(
              image: 'assets/lottie/general_errors/cityNotfound.json',
              text: 'You entered an incorrect city name.',
            );
          }
        },
      ),
    );
  }
}
