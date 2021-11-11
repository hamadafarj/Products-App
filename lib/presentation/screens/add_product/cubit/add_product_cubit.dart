import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prayers_application/data/repositories/user_repository.dart';
part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(AddProductInitial());
  final _userRepository = UserRepository();

  Future addProduct({
    required String productsDetails,
    required String productsName,
    required String productsImage,
    required String productscategory,
    required bool productsIsSally,
  }) async {
    emit(AddProductChangeLoadingState());
    try {
      await _userRepository.addDateProduct(productsName, productsDetails,
          productsImage, productscategory, productsIsSally);
    } catch (error) {
      emit(AddProductFailedState(error.toString()));
      return error;
    }
    emit(AddProductSuccessState());
  }
}
