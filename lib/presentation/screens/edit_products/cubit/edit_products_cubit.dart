import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prayers_application/data/model/product_model.dart';
import 'package:prayers_application/data/repositories/user_repository.dart';

part 'edit_products_state.dart';

class EditProductsCubit extends Cubit<EditProductsState> {
  EditProductsCubit() : super(EditProductsInitial());

  final _userRepository = UserRepository();

  getProductDetails(String productDocsId) async {
    List<Product> product;
    emit(ProductLoadingState());
    product = await _userRepository.getProductData(productDocsId);
    emit(ProductLoadedState(product: product));
  }

  Future editProductInformation({
    required String productsDetails,
    required String productsName,
    required String productsImage,
    required String productDocsId,
    required bool productsIsSale,
  }) async {
    emit(ProductEditChangeLoadingState());
    try {
      await _userRepository.upDateProduct(productsName, productsDetails,
          productsImage, productDocsId, productsIsSale);
    } catch (error) {
      emit(ProductEditChangeFailedState(error.toString()));
      return error;
    }
    emit(ProductEditChangeSuccessState());
  }
}
