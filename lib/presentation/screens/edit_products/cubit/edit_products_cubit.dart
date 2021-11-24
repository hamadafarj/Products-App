import 'package:bloc/bloc.dart';
import 'package:prayers_application/data/model/product_model.dart';
import 'package:prayers_application/data/repositories/user_repository.dart';
import './edit_products_state.dart';

class EditProductsCubit extends Cubit<EditProductsState> {
  EditProductsCubit() : super(EditProductsInitial());
  final _userRepository = UserRepository();
  getProductDetails(String productDocsId) async {
    Product product;
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
    try {
      emit(ProductEditLoadingState());
      await _userRepository.upDateProduct(productsName, productsDetails,
          productsImage, productDocsId, productsIsSale);
      emit(ProductEditSuccessState());
    } catch (error) {
      emit(ProductEditFailedState(error.toString()));
      return error;
    }
  }
}
