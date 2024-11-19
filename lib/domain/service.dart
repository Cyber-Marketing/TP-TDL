class Service {
  String ownerUid;
  String businessName;
  String description;
  String category;
  double duration;
  double price;

  Service(
      {required this.ownerUid,
      required this.businessName,
      required this.description,
      required this.category,
      required this.duration,
      required this.price});

  factory Service.fromMap(serviceMap) {
    return Service(
      ownerUid: serviceMap["ownerUid"],
      businessName: serviceMap["businessName"],
      description: serviceMap["description"],
      category: serviceMap["category"],
      duration: serviceMap["duration"],
      price: serviceMap["price"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ownerUid': ownerUid,
      'businessName': businessName,
      'description': description,
      'category': category,
      'duration': duration,
      'price': price,
    };
  }
}
