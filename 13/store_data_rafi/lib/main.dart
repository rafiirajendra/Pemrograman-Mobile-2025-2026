import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'model/pizza.dart';

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

  @override
  void initState() {
    super.initState();
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
      body: myPizzas.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: myPizzas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(myPizzas[index].pizzaName),
                  subtitle: Text(
                    '${myPizzas[index].description} - € ${myPizzas[index].price}',
                  ),
                );
              },
            ),
    );
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