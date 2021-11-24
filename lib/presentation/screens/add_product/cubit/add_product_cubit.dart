import 'package:bloc/bloc.dart';
import 'package:prayers_application/data/repositories/user_repository.dart';
import 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(AddProductInitial());
  final _userRepository = UserRepository();

  Future addProduct({
    required String productsName,
    required String productsDetails,
    required String productsImage,
    required String productscategory,
    required bool productsIsSale,
    required String productsPrice,
    required DateTime productDate,
  }) async {
    try {
      emit(AddProductLoadingState());
      await _userRepository.addDateProduct(
          productsName: productsName,
          productsDetails: productsDetails,
          productsImage: productsImage,
          productsIsSale: productsIsSale,
          productscategory: productscategory,
          productsPrice: productsPrice,
          productDate: productDate);
      emit(AddProductSuccessState());
    } catch (error) {
      emit(AddProductFailedState(error.toString()));
      return error;
    }
  }
}
