import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:weather_app/Models/weather_model.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/services/weather_service.dart';

class GetWeatherCubit extends Cubit<WeatherStates> {
  GetWeatherCubit() : super(WeatherInitialState());
  WeatherModel? weatherModel;

  getWeather({required cityName}) async {
    final bool isConnected = await InternetConnection().hasInternetAccess;
    if (isConnected) {
      try {
        weatherModel =
            await WeatherService(dio: Dio()).getWeatherIfo(city: cityName);
        emit(WeatherLoadedState(weatherModel: weatherModel!));
      } catch (e) {
        emit(WeatherFailureState());
      }
    } else {
      emit(NoInternetState());
    }
  }
}
