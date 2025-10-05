import 'package:belanja/models/item.dart';
import 'package:belanja/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductGrid extends StatelessWidget {
  final List<Item> items;
  final void Function(Item) onItemTap;

  const ProductGrid({Key? key, required this.items, required this.onItemTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ProductCard(
          item: item,
          onTap: () => onItemTap(item),
        );
      },
    );
  }
}
