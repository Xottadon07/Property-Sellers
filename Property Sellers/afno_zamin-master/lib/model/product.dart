import 'package:dale_the_property_sellers/model/user.dart';

class Product {
  String title;
  double price;
  double area;
  String description;
  String location;
  String purpose;
  String category;
  String image;
  String id;
  User? uploader;

  Product({
    required this.title,
    required this.price,
    required this.area,
    required this.description,
    required this.location,
    required this.purpose,
    required this.category,
    this.uploader,
    required this.image,
    required this.id,
  });

  static Product fromJson(Map<String, dynamic> json) {
    var price = 0.0;
    try {
      price = double.parse(json['price'].toString());
    } catch (e) {}

    var area = 0.0;
    try {
      area = double.parse(json['area'].toString());
    } catch (e) {}

    User? uploadedBy;
    if (json['user'] != null) {
      try {
        uploadedBy = User.fromJson(json['user']);
      } catch (e) {
        print("Error parsing user");
      }
    }

    return Product(
      title: json['title'] ?? "No Title",
      price: price,
      area: area,
      uploader: uploadedBy,
      description: json['description'] ?? "",
      location: json['location'] ?? "",
      purpose: json['purpose'] ?? "",
      category: json['category'] ?? "",
      image: json['image'] ?? "",
      id: json['_id'] ?? "",
    );
  }

  bool matches(String filter) {
    if (filter.isEmpty) return true;
    if (title.toLowerCase().contains(filter.trim().toLowerCase())) return true;
    if (description.toLowerCase().contains(filter.trim().toLowerCase())) {
      return true;
    }
    return false;
  }
}
