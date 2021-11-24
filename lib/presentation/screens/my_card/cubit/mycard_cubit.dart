import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prayers_application/data/model/product_model.dart';
part 'mycard_state.dart';

class MycardCubit extends Cubit<MycardState> {
  MycardCubit() : super(MycardInitial());
  double totalPrice = 0;
  List<Product> cardItems = [];
  getCardProduct() async {
    emit(ChangeState());
    List<Product> product;
    product = cardItems;
    for (var item in cardItems) {
      totalPrice += int.parse(item.productPrice);
    }
    emit(MyCardLoaded(product: product, totalPrice: totalPrice));
  }

  bool additemToList(Product item) {
    if (!cardItems.contains(item)) {
      cardItems.add(item);
      print("scusse");
      return true;
    } else {
      print("failed");
      return false;
    }
  }

  void removeItemFromList(Product items) {
    emit(ChangeState());
    cardItems.where((element) => element == items);
    cardItems.remove(items);
    items.cardNumberItem = 0;
    for (var item in cardItems) {
      totalPrice -= int.parse(item.productPrice);
    }
    emit(MyCardLoaded(product: cardItems, totalPrice: totalPrice));
  }

  void increment(Product product) {
    emit(ChangeState());
    cardItems.where((element) => element == product);
    product.cardNumberItem = product.cardNumberItem + 1;
    print("jjvvd ${product.productPrice} ");
    var x = int.tryParse(product.productPrice);
    if (x != null) {
      x = (x + x);
    }
    product.productPrice = x.toString();
    print("jjvvd ${product.productPrice} ");
    for (var item in cardItems) {
      totalPrice += int.parse(item.productPrice);
    }
    emit(MyCardLoaded(product: cardItems, totalPrice: totalPrice));
  }

  void decrement(Product product) {
    emit(ChangeState());
    cardItems.where((element) => element == product);
    product.cardNumberItem = product.cardNumberItem - 1;
    print("jjvvd ${product.productPrice} ");
    var x = int.tryParse(product.productPrice);
    if (x != null) {
      x = (x - x);
    }
    product.productPrice = x.toString();
    print("jjvvd ${product.productPrice} ");
    for (var item in cardItems) {
      totalPrice -= int.parse(item.productPrice);
    }
    emit(MyCardLoaded(product: cardItems, totalPrice: totalPrice));
  }
}



/*
    product.cardNumberItem = product.cardNumberItem + 1;
  var x = cardItems
        .indexWhere((element) => element.cardNumberItem == incrementItem);
    print("ffff $x");
*/
  //element.cardNumberItem + 1

  // void increment(int itemCount) {
  //   List<Product> product;
  //   product = cardItems;
  //   emit(Increment(product: product, count: itemCount));
  // }

  // void decrement(int itemCount) {
  //   emit(Decrement(product: cardItems, count: itemCount));
  // }