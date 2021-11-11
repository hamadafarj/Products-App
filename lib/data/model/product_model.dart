import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  late String productDocsId;
  final String productName;
  final String productImage;
  final String productDetails;
  final String productsCategory;
  final bool productsIsSally;
  Product(this.productName, this.productImage, this.productDetails,
      this.productsCategory, this.productsIsSally);
  factory Product.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) =>
      _productJson(json);
}

Product _productJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
  return Product(
    json['products_name'] as String,
    json['products_image'] as String,
    json['products_details'] as String,
    json['products_category'] as String,
    json['products_isSally'] as bool,
  );
}
