part of 'add_product_cubit.dart';

abstract class AddProductState extends Equatable {
  const AddProductState();

  @override
  List<Object> get props => [];
}

class AddProductInitial extends AddProductState {}

class AddProductSuccessState extends AddProductState {
  @override
  List<Object> get props => [];
}

class AddProductFailedState extends AddProductState {
  final String responseMessage;

  const AddProductFailedState(this.responseMessage);
  @override
  List<Object> get props => [responseMessage];
}

class AddProductChangeLoadingState extends AddProductState {
  @override
  List<Object> get props => [];
}
