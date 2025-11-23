import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'model/pizza.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter JSON Demo Rafi',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Pizza> myPizzas = [];
  int appCounter = 0;

  @override
  void initState() {
    super.initState();
    readAndWritePreference();
    readJsonFile().then((value) {
      setState(() {
        myPizzas = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JSON'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'You have opened the app $appCounter times.'),
            ElevatedButton(
              onPressed: () {
                deletePreference();
              },
              child: Text('Reset counter'),
            ),
          ],
        ),
      ),
    );
  }

  // Langkah 13: Method untuk delete preference
  Future<void> deletePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      appCounter = 0;
    });
  }

  // Langkah 5-9: Method untuk read dan write preference
  Future<void> readAndWritePreference() async {
    // Langkah 6: Dapatkan instance SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // Langkah 7: Baca, cek null, dan increment counter
    appCounter = prefs.getInt('appCounter') ?? 0;
    appCounter++;
    
    // Langkah 8: Simpan nilai baru
    await prefs.setInt('appCounter', appCounter);
    
    // Langkah 9: Perbarui state
    setState(() {
      appCounter = appCounter;
    });
  }

  Future<List<Pizza>> readJsonFile() async {
    final myString = await rootBundle.loadString('assets/pizzalist_broken.json');

    final List<dynamic> pizzaMapList = jsonDecode(myString);

    final List<Pizza> pizzas = pizzaMapList
        .map((pizza) => Pizza.fromJson(pizza as Map<String, dynamic>))
        .toList();
    String json = convertToJson(myPizzas);
    print(json);
    return pizzas;
  }

  String convertToJson(List<Pizza> pizzas) {
    return jsonEncode(pizzas.map((pizza) => pizza.toJson()).toList());
  }
}