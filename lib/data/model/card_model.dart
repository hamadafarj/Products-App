import 'package:prayers_application/data/model/product_model.dart';

class CardModel {
  List<Product> product;
  int itemCount;
  int totalItemPrice;
  int totalPrice;
  CardModel({required this.product,required this.itemCount,required this.totalItemPrice,required this.totalPrice});
}
