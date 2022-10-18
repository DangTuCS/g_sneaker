class Shoes {
  final int id;
  final String image;
  final String name;
  final String description;
  final double price;
  final String color;

  const Shoes({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'image': this.image,
      'name': this.name,
      'description': this.description,
      'price': this.price,
      'color': this.color,
    };
  }

  factory Shoes.fromMap(Map<String, dynamic> map) {
    return Shoes(
      id: map['id'] as int,
      image: map['image'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as double,
      color: map['color'] as String,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Shoes && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}