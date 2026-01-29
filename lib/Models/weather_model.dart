class WeatherModel {
  final String city;
  final String image;
  final double temp;
  final double maxTemp;
  final double minTemp;
  final String condition;
  final int conditionCode;
  final DateTime updatedTime;

  WeatherModel(
      {required this.city,
      required this.image,
      required this.temp,
      required this.maxTemp,
      required this.minTemp,
      required this.condition,
      required this.updatedTime,
      required this.conditionCode});

  factory WeatherModel.fromJson(json) {
    return WeatherModel(
      city: json['location']['name'],
      updatedTime: DateTime.parse(json["current"]["last_updated"]),
      image: 'assets/images/clear.png',
      temp: json['forecast']["forecastday"][0]['day']['avgtemp_c'],
      maxTemp: json['forecast']["forecastday"][0]['day']['maxtemp_c'],
      minTemp: json['forecast']["forecastday"][0]['day']['mintemp_c'],
      condition: json['forecast']["forecastday"][0]['day']["condition"]['text'],
      conditionCode: json['forecast']["forecastday"][0]['day']["condition"]
          ['code'],
    );
  }
}
