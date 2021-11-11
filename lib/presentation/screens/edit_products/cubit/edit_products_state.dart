part of 'edit_products_cubit.dart';

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
  final List<Product> product;
  const ProductLoadedState({required this.product});
  @override
  List<Object> get props => [product];
}

class ProductEditChangeSuccessState extends EditProductsState {
  @override
  List<Object> get props => [];
}

class ProductEditChangeFailedState extends EditProductsState {
  final String responseMessage;

  const ProductEditChangeFailedState(this.responseMessage);
  @override
  List<Object> get props => [responseMessage];
}

class ProductEditChangeLoadingState extends EditProductsState {
  @override
  List<Object> get props => [];
}





// class ProductLoadedState extends EditProductsState {
//   final Product product;
//   const ProductLoadedState({required this.product});
//   @override
//   List<Object> get props => [product];
// }
