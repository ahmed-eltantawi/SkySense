import 'package:flutter/material.dart';

// ================= FUNCTION =================

ThemeData appTheme(BuildContext context, int? conditionCode) {
  if (conditionCode == null) {
    return ThemeData.dark();
  }

  final WeatherTheme weatherTheme = getWeatherTheme(conditionCode);

  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: weatherTheme.seedColor,
      brightness: Brightness.dark,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: weatherTheme.seedColor,
      foregroundColor: weatherTheme.foregroundColor,
    ),
  );
}

// ================= WEATHER THEME LOGIC =================
WeatherTheme getWeatherTheme(int code) {
  switch (code) {
    // ☀️ Clear / Sunny
    case 1000:
      return const WeatherTheme(
        seedColor: Color(0xFFFFB300), // Sunny gold
        foregroundColor: Colors.black,
      );

    // ⛅ Partly cloudy
    case 1003:
      return const WeatherTheme(
        seedColor: Color(0xFFFFD54F), // Warm yellow
        foregroundColor: Colors.black,
      );

    // ☁️ Cloudy / Overcast
    case 1006:
    case 1009:
      return const WeatherTheme(
        seedColor: Color(0xFF607D8B), // Deep blue grey
        foregroundColor: Colors.white,
      );

    // 🌫️ Fog / Mist
    case 1030:
    case 1135:
    case 1147:
      return const WeatherTheme(
        seedColor: Color(0xFF9E9E9E), // Soft fog grey
        foregroundColor: Colors.white,
      );

    // 🌧️ Rain
    case 1063:
    case 1150:
    case 1153:
    case 1180:
    case 1183:
    case 1186:
    case 1189:
    case 1192:
    case 1195:
    case 1240:
    case 1243:
    case 1246:
      return const WeatherTheme(
        seedColor: Color(0xFF1565C0), // Deep rainy blue
        foregroundColor: Colors.white,
      );

    // ❄️ Snow
    case 1066:
    case 1114:
    case 1117:
    case 1210:
    case 1213:
    case 1216:
    case 1219:
    case 1222:
    case 1225:
    case 1255:
    case 1258:
      return const WeatherTheme(
        seedColor: Color(0xFFE3F2FD), // Icy white-blue
        foregroundColor: Colors.black,
      );

    // 🧊 Ice / Sleet
    case 1069:
    case 1072:
    case 1168:
    case 1171:
    case 1198:
    case 1201:
    case 1204:
    case 1207:
    case 1237:
    case 1249:
    case 1252:
    case 1261:
    case 1264:
      return const WeatherTheme(
        seedColor: Color(0xFF80DEEA), // Frozen cyan
        foregroundColor: Colors.black,
      );

    // ⛈️ Thunder
    case 1087:
    case 1273:
    case 1276:
    case 1279:
    case 1282:
      return const WeatherTheme(
        seedColor: Color(0xFF311B92), // Storm purple
        foregroundColor: Colors.white,
      );

    // 🔁 Default
    default:
      return const WeatherTheme(
        seedColor: Color(0xFF90A4AE),
        foregroundColor: Colors.black,
      );
  }
}

// ================= MODEL =================

class WeatherTheme {
  final Color seedColor;
  final Color foregroundColor;

  const WeatherTheme({
    required this.seedColor,
    required this.foregroundColor,
  });
}
