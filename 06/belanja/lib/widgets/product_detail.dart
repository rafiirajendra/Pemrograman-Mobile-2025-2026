import 'package:belanja/models/item.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  final Item item;

  const ProductDetail({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Hero(
              tag: 'item-${item.name}',
              child: Image.network(
                item.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.broken_image, size: 48)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Rp ${item.price}', style: const TextStyle(fontSize: 18, color: Colors.green)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange.shade700),
                    const SizedBox(width: 6),
                    Text(item.rating.toString()),
                    const Spacer(),
                    Text('Stok: ${item.stock}'),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: item.stock > 0 ? () {} : null,
                  child: const Text('Beli Sekarang'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
