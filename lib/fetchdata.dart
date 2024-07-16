import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class MyApp1 extends StatefulWidget {
  const MyApp1({Key? key});

  @override
  State<MyApp1> createState() => _MyAppState();
}

class Weather {
  Location? location;
  Current? current;

  Weather({this.location, this.current});

  Weather.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    current = json['current'] != null ? Current.fromJson(json['current']) : null;
  }
}

class Location {
  String? name;

  Location({this.name});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}

class Current {
  double? tempC;
  Condition? condition;

  Current({this.tempC, this.condition});

  Current.fromJson(Map<String, dynamic> json) {
    tempC = json['temp_c'];
    condition = json['condition'] != null ? Condition.fromJson(json['condition']) : null;
  }
}

class Condition {
  String? text;

  Condition({this.text});

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }
}

Future<Weather> fetchWeather() async {
  final response = await http.get(Uri.parse('https://api.weatherapi.com/v1/current.json?q=america&key=%20e8e7dd2f09a14ba0b51103205232710'));

  if (response.statusCode == 200) {
    return Weather.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load weather data');
  }
}

class _MyAppState extends State<MyApp1> {
  late Future<Weather> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Weather Status', style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic, color: Colors.black)),
        ),
        body: Stack(
          children: [
            Image.network(
              'https://offloadmedia.feverup.com/secretldn.com/wp-content/uploads/2015/10/25144514/shutterstock_1036334149-min-1024x683.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Center(
              child: FutureBuilder<Weather>(
                future: futureWeather,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final weatherData = snapshot.data!;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Location: ${weatherData.location!.name ?? "Unknown"}', style: TextStyle(fontSize: 25)),
                        Text('Current Temperature: ${weatherData.current!.tempC}°C', style: TextStyle(fontSize: 25)),
                        Text('Weather Condition: ${weatherData.current!.condition!.text ?? "Unknown"}', style: TextStyle(fontSize: 25)),
                     
                      ],
                    );
                  } else {
                    return Text('No data available');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
