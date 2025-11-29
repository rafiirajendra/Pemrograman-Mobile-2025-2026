// Langkah 1: Konstanta untuk kunci JSON
const String keyId = 'id';
const String keyName = 'pizzaName';
const String keyDescription = 'description';
const String keyPrice = 'price';
const String keyImage = 'imageUrl';

class Pizza {
  int id = 0;
  String pizzaName = '';
  String description = '';
  double price = 0.0;
  String imageUrl = '';

  Pizza();

  // Langkah 2: Perbarui fromJson() menggunakan konstanta
  Pizza.fromJson(Map<String, dynamic> json)
      : id = int.tryParse(json[keyId].toString()) ?? 0,
        pizzaName = (json[keyName] != null) ? json[keyName].toString() : 'No name',
        description = (json[keyDescription] != null) ? json[keyDescription].toString() : '',
        price = double.tryParse(json[keyPrice].toString()) ?? 0,
        imageUrl = json[keyImage]?.toString() ?? '';
  
  // Langkah 3: Perbarui toJson() menggunakan konstanta
  Map<String, dynamic> toJson() => {
        keyId: id,
        keyName: pizzaName,
        keyDescription: description,
        keyPrice: price,
        keyImage: imageUrl,
      };
}
