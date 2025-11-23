import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'model/pizza.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
  String documentsPath = '';
  String tempPath = '';
  late File myFile;
  String fileText = '';
  
  // Langkah 3: Tambahkan controller dan variabel
  final pwdController = TextEditingController();
  String myPass = '';
  
  // Langkah 4: Inisialisasi Secure Storage
  final storage = const FlutterSecureStorage();
  final myKey = 'myPass';

  @override
  void initState() {
    getPaths().then((_) {
      myFile = File('$documentsPath/pizzas.txt');
      writeFile();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Path Provider'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: pwdController,
              ),
              ElevatedButton(
                child: const Text('Save Value'),
                onPressed: () {
                  writeToSecureStorage();
                },
              ),
              ElevatedButton(
                child: const Text('Read Value'),
                onPressed: () {
                  readFromSecureStorage().then((value) {
                    setState(() {
                      myPass = value;
                    });
                  });
                },
              ),
              Text(myPass),
            ],
          ),
        ),
      ),
    );
  }

  // Langkah 5: Method untuk write to secure storage
  Future writeToSecureStorage() async {
    await storage.write(key: myKey, value: pwdController.text);
  }

  // Langkah 6: Method untuk read from secure storage
  Future<String> readFromSecureStorage() async {
    String secret = await storage.read(key: myKey) ?? '';
    return secret;
  }

  // Langkah 3: Method untuk write file
  Future<bool> writeFile() async {
    try {
      await myFile.writeAsString('2341720158, Muhammad Rafi Rajendra');
      return true;
    } catch (e) {
      return false;
    }
  }

  // Langkah 5: Method untuk read file
  Future<bool> readFile() async {
    try {
      // Read the file.
      String fileContent = await myFile.readAsString();
      setState(() {
        fileText = fileContent;
      });
      return true;
    } catch (e) {
      // On error, return false.
      return false;
    }
  }

  // Langkah 4: Method untuk get paths
  Future<void> getPaths() async {
    final docDir = await getApplicationDocumentsDirectory();
    final tempDir = await getTemporaryDirectory();
    setState(() {
      documentsPath = docDir.path;
      tempPath = tempDir.path;
    });
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