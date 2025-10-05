import 'package:belanja/models/item.dart';
import 'package:belanja/widgets/product_grid.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<Item> items = [
    Item(name: 'Apple', price: 10000, image: 'https://picsum.photos/200?image=10', stock: 12, rating: 4.5),
    Item(name: 'Banana', price: 5000, image: 'https://picsum.photos/200?image=20', stock: 30, rating: 4.0),
    Item(name: 'Orange', price: 8000, image: 'https://picsum.photos/200?image=30', stock: 8, rating: 4.2),
    Item(name: 'Mango', price: 15000, image: 'https://picsum.photos/200?image=40', stock: 5, rating: 4.8),
    Item(name: 'Grapes', price: 12000, image: 'https://picsum.photos/200?image=50', stock: 20, rating: 4.3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Belanja')),
      body: ProductGrid(
        items: items,
        onItemTap: (item) => Navigator.pushNamed(context, '/item', arguments: item),
      ),
      bottomNavigationBar: Container(
        color: Colors.grey.shade200,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Nama: Rafi Rajendra', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(width: 16),
            Text('NIM: 2341720158'),
          ],
        ),
      ),
    );
  }
}