class Service {
  String businessName;
  String description;
  String category;
  double duration;
  double price;

  Service(
      {required this.businessName,
      required this.description,
      required this.category,
      required this.duration,
      required this.price});

  Map<String, dynamic> toMap() {
    return {
      'businessName': businessName,
      'description': description,
      'category': category,
      'duration': duration,
      'price': price,
    };
  }
}
