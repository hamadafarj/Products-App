import 'package:equatable/equatable.dart';
import 'package:prayers_application/data/model/product_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadedState extends HomeState {
  final List<Product> product;
  const HomeLoadedState({required this.product});
  @override
  List<Object> get props => [product];
}
