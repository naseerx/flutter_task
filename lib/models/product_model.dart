class ProductModel {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double rating;
  final int stock;
  final String brand;
  final String thumbnail;
  final List<String> images;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.thumbnail,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 1,
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      category: json['category'] ?? 'Unknown Category',
      price: (json['price'] != null) ? (json['price'] as num).toDouble() : 0.0,
      rating:
          (json['rating'] != null) ? (json['rating'] as num).toDouble() : 0.0,
      stock: json['stock'] ?? 0,
      brand: json['brand'] ?? 'No Brand',
      thumbnail: json['thumbnail'] ?? '',
      images: (json['images'] != null && json['images'] is List)
          ? List<String>.from(json['images'])
          : ['https://via.placeholder.com/150'],
    );
  }
}
