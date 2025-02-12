// ignore_for_file: public_member_api_docs, sort_constructors_first
class Producktmodal {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Rating rating;

  Producktmodal.ProductModal({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory Producktmodal.fromJson(source) {
    return Producktmodal.ProductModal(
      id: source['id'],
      title: source['title'],
      price: source['price'], // Ensure price is cast to double
      description: source['description'],
      category: source['category'],
      image: source['image'],
      rating: Rating.fromJson(source['rating']),
    );
  }

  Object? get length => null;

  @override
  String toString() {
    return 'Producktmodal(id: $id, title: $title, price: $price, description: $description, category: $category, image: $image, rating: $rating)';
  }
}

class Rating {
  final double rating;
  final int count;

  Rating({required this.rating, required this.count});

  factory Rating.fromJson(source) {
    return Rating(
      rating: source['rate'], // Ensure rating is double
      count: source['count'], // Ensure count is int
    );
  }
}
