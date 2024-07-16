import 'package:flutter/material.dart';
import 'package:flutter_application_9/fetchdata.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _showWeather() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyApp1()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
         
          Image.asset(
            'assets/bunny.jpg',
            fit: BoxFit.cover,
          
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 100),
              child: ElevatedButton(
                onPressed: _showWeather,
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(20, 60)),
                ),
                child: const Text('Weather Forecast', style: TextStyle(fontSize: 25)),
              ),
            ),
          ),
        
        ],
      ),
    );
  }
}