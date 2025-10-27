import 'package:equatable/equatable.dart';

class MarketplaceItemApiModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String price;
  final String type; //* <--- ["best seller", "free", "recommended"]
  final String image;

  const MarketplaceItemApiModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.type,
    required this.image,
  });

  factory MarketplaceItemApiModel.fromJson(Map<String, dynamic> json) {
    print('[MarketplaceItemApiModel] fromJson called with: $json');

    final item = MarketplaceItemApiModel(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: json['price']?.toString() ?? '', // Convert number to string
      type: json['type']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
    );

    print(
      '[MarketplaceItemApiModel] created item: ${item.title} with price: ${item.price}',
    );
    return item;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'type': type,
      'image': image,
    };
  }

  bool get isBestSeller => type.toLowerCase() == 'best seller';
  bool get isFree => type.toLowerCase() == 'free';
  bool get isRecommended => type.toLowerCase() == 'recommended';

  String get displayPrice {
    if (price.isEmpty) return 'Free';

    // Handle both string and numeric price formats
    final priceValue = double.tryParse(price) ?? 0.0;
    if (priceValue == 0.0) return 'Free';

    return '\$${priceValue.toStringAsFixed(2)}';
  }

  //* Correcting text style for showing in screen
  String get displayType {
    switch (type.toLowerCase()) {
      case 'best seller':
        return 'Best Seller';
      case 'free':
        return 'Free';
      case 'recommended':
        return 'Recommended';
      default:
        return type.isNotEmpty ? type.toUpperCase() : '';
    }
  }

  @override
  List<Object?> get props => [id, title, description, price, type, image];
}
