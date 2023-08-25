class Product {
  int id;
  String name;
  String description;
  String color;
  String size;
  String imageUrl;
  double vat;
  double unitPrice;
  int quantity;
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.color,
    required this.size,
    required this.imageUrl,
    required this.vat,
    required this.unitPrice,
    required this.quantity,
  });

  Map toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'color': color,
      'size': size,
      'imageUrl': imageUrl,
      'vat': vat,
      'unitPrice': unitPrice,
      'quantiy': quantity,
    };
  }
}

List<Product> products = [
  Product(
      id: 0,
      name: "shoes",
      description:
          "hi im cristian ronaldo this is my description im a product nice to meet you i hope you are doing great my friend, good bye",
      color: "blue",
      size: "M",
      imageUrl: "shoes.png",
      vat: 0.19,
      unitPrice: 30.00,
      quantity: 0),
  Product(
      id: 1,
      name: "boots",
      description:
          "hi im cristian ronaldo this is my discription im a product nice to meet you i hope you are doing great my friend, good bye",
      color: "black",
      size: "XL",
      imageUrl: "boots.png",
      vat: 0.19,
      unitPrice: 149.00,
      quantity: 0),
  Product(
      id: 2,
      name: "cargo",
      description:
          "hi im cristian ronaldo this is my discription im a product nice to meet you i hope you are doing great my friend, good bye",
      color: "brown",
      size: "S",
      imageUrl: "cargo.png",
      vat: 0.19,
      unitPrice: 120.00,
      quantity: 0),
  Product(
      id: 3,
      name: "hat",
      description:
          "hi im cristian ronaldo this is my discription im a product nice to meet you i hope you are doing great my friend, good bye",
      color: "yellow",
      size: "L",
      imageUrl: "hat.png",
      vat: 0.19,
      unitPrice: 40.00,
      quantity: 0),
  Product(
      id: 4,
      name: "jacket",
      description:
          "hi im cristian ronaldo this is my discription im a product nice to meet you i hope you are doing great my friend, good bye",
      color: "red",
      size: "XL",
      imageUrl: "jacket.png",
      vat: 0.19,
      unitPrice: 190.00,
      quantity: 0),
];
