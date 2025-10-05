class Item {
  String name;
  int price;
  String image; // image asset or network URL
  int stock;
  double rating;

  Item({
    required this.name,
    required this.price,
    required this.image,
    required this.stock,
    required this.rating,
  });
}