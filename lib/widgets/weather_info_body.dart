import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Models/weather_model.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';

class WeatherInfoBody extends StatelessWidget {
  const WeatherInfoBody({
    Key? key,
    required this.weatherModel,
  }) : super(key: key);

  final WeatherModel weatherModel;
  @override
  Widget build(BuildContext context) {
    var weatherModel = BlocProvider.of<GetWeatherCubit>(context).weatherModel!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 25,
            ),
            Text(
              weatherModel.city,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            Text(
              'Updated at: ${weatherModel.updatedTime.hour}:${weatherModel.updatedTime.minute}',
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            SizedBox(
                height: 250,
                child: Lottie.asset(
                    "assets/lottie/weather_states/${getImage(weatherModel.condition)}")),
            Text(
              weatherModel.temp.round().toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 100,
              ),
            ),
            Text(
              weatherModel.condition,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Text(
              'H: ${weatherModel.maxTemp.round()}° \t L: ${weatherModel.minTemp.round()}°',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getImage(String condition) {
    switch (condition) {
      // Clear
      case 'Sunny':
      case 'Clear':
        return 'Sunny.json';

      // Cloudy
      case 'Partly cloudy':
      case 'Cloudy':
      case 'Overcast':
        return 'cloudy.json';

      // Fog / Mist
      case 'Mist':
      case 'Fog':
      case 'Freezing fog':
        return 'fogy.json';

      // Rain / Drizzle
      case 'Patchy rain possible':
      case 'Patchy light drizzle':
      case 'Light drizzle':
      case 'Patchy light rain':
      case 'Light rain':
      case 'Moderate rain at times':
      case 'Moderate rain':
      case 'Heavy rain at times':
      case 'Heavy rain':
      case 'Light rain shower':
      case 'Moderate or heavy rain shower':
      case 'Torrential rain shower':
        return 'heavy rain.json';

      // Freezing rain / Sleet / Ice
      case 'Patchy sleet possible':
      case 'Patchy freezing drizzle possible':
      case 'Freezing drizzle':
      case 'Heavy freezing drizzle':
      case 'Light freezing rain':
      case 'Moderate or heavy freezing rain':
      case 'Light sleet':
      case 'Moderate or heavy sleet':
      case 'Ice pellets':
      case 'Light sleet showers':
      case 'Moderate or heavy sleet showers':
      case 'Light showers of ice pellets':
      case 'Moderate or heavy showers of ice pellets':
        return 'ice.json';

      // Snow
      case 'Patchy snow possible':
      case 'Blowing snow':
      case 'Blizzard':
      case 'Patchy light snow':
      case 'Light snow':
      case 'Patchy moderate snow':
      case 'Moderate snow':
      case 'Patchy heavy snow':
      case 'Heavy snow':
      case 'Light snow showers':
      case 'Moderate or heavy snow showers':
        return 'snow.json';

      // Thunder
      case 'Thundery outbreaks possible':
      case 'Patchy light rain with thunder':
      case 'Moderate or heavy rain with thunder':
      case 'Patchy light snow with thunder':
      case 'Moderate or heavy snow with thunder':
        return 'thunder.json';

      default:
        return 'default.json';
    }
  }
}
