import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:weather_app/Models/weather_model.dart';

class WeatherService {
  final Dio dio;
  final String baseUrl = "https://api.weatherapi.com/v1";
  final String apiKey = 'b78804f27e6a407484a82940262301';
  WeatherService({required this.dio});

  Future<WeatherModel> getWeatherIfo({required String city}) async {
    try {
      Response response =
          await dio.get('$baseUrl/forecast.json?key=$apiKey&q=$city&days=1');
      return WeatherModel.fromJson(response.data);
    } on DioException catch (e) {
      final String errorMessage = e.response?.data['error']['message'] ??
          'oops there is something wrong with city name';
      log(e.toString());
      throw Exception(errorMessage);
    } catch (e) {
      log(e.toString());
      throw ('oops there was an error, try again letter');
    }
  }
}
