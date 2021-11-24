import 'package:bloc/bloc.dart';
import 'package:prayers_application/data/model/product_model.dart';
import 'package:prayers_application/data/repositories/user_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeLoadingState());
  final _userRepository = UserRepository();

  deleteProduct(
    String productDocsId,
  ) async {
    await _userRepository.deleteDateProduct(productDocsId);
  }

  refreshHomePage() async {
    List<Product> product;
    product = await _userRepository.getData();
    emit(HomeLoadedState(product: product));
  }

  getAllProduct() async {
    List<Product> product;
    emit(HomeLoadingState());
    product = await _userRepository.getData();
    emit(HomeLoadedState(product: product));
  }

  geSpecificProduct({required String productsCategory}) async {
    List<Product> product;
    emit(HomeLoadingState());
    product = await _userRepository.getProductCategory(productsCategory);
    emit(HomeLoadedState(product: product));
  }
}
