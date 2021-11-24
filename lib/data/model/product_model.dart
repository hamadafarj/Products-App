import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  late String productDocsId;
  final String productName;
  final String productImage;
  final String productDetails;
  final String productCategory;
  String productPrice;
  final DateTime productDate;
  final bool productsIsSale;
  int cardNumberItem = 0;
  Product(
    this.productName,
    this.productImage,
    this.productDetails,
    this.productCategory,
    this.productPrice,
    this.productDate,
    this.productsIsSale,
  );
  factory Product.fromJson(DocumentSnapshot<Map<String, dynamic>> json) =>
      _productJson(json);
}

Product _productJson(DocumentSnapshot<Map<String, dynamic>> json) {
  return Product(
    json['products_name'] as String,
    json['products_image'] as String,
    json['products_details'] as String,
    json['products_category'] as String,
    json['products_price'] as String,
    (json['products_date'] as Timestamp).toDate(),
    json['products_isSale'] as bool,
  );
}
