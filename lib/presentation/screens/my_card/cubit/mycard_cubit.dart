import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prayers_application/data/model/product_model.dart';
part 'mycard_state.dart';

class MycardCubit extends Cubit<MycardState> {
  MycardCubit() : super(MycardInitial());
  List<Product> cardItems = [];
  getCardProduct() async {
    emit(ChangeState());
    List<Product> product;
    product = cardItems;
    emit(MyCardLoaded(product: product));
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
    cardItems.remove(items);
    emit(MyCardLoaded(product: cardItems));
  }

  void increment(int incrementItem) {
    emit(ChangeState());
    var x = cardItems
        .indexWhere((element) => element.cardNumberItem == incrementItem);
    print("ffff $x");
    emit(MyCardLoaded(product: cardItems));
  }

  //element.cardNumberItem + 1
  void decrement(int decrementItem) {
    emit(ChangeState());
    var x =
        cardItems.where((element) => element.cardNumberItem == decrementItem);
    print("ffff $x");
    emit(MyCardLoaded(product: cardItems));
  }

  // void increment(int itemCount) {
  //   List<Product> product;
  //   product = cardItems;
  //   emit(Increment(product: product, count: itemCount));
  // }

  // void decrement(int itemCount) {
  //   emit(Decrement(product: cardItems, count: itemCount));
  // }
}
