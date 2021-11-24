import 'package:equatable/equatable.dart';
import 'package:prayers_application/data/model/product_model.dart';

abstract class EditProductsState extends Equatable {
  const EditProductsState();

  @override
  List<Object> get props => [];
}

class EditProductsInitial extends EditProductsState {}

class ProductLoadingState extends EditProductsState {
  @override
  List<Object> get props => [];
}

class ProductLoadedState extends EditProductsState {
  //final List<Product> product;
  final Product product;
  const ProductLoadedState({required this.product});
  @override
  List<Object> get props => [product];
}

class ProductEditSuccessState extends EditProductsState {
  @override
  List<Object> get props => [];
}

class ProductEditFailedState extends EditProductsState {
  final String responseMessage;

  const ProductEditFailedState(this.responseMessage);
  @override
  List<Object> get props => [responseMessage];
}

class ProductEditLoadingState extends EditProductsState {
  @override
  List<Object> get props => [];
}





// class ProductLoadedState extends EditProductsState {
//   final Product product;
//   const ProductLoadedState({required this.product});
//   @override
//   List<Object> get props => [product];
// }
