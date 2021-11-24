import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayers_application/constants/my_string.dart';
import 'package:prayers_application/presentation/screens/edit_products/cubit/edit_products_cubit.dart';
import 'package:prayers_application/presentation/screens/edit_products/edit_products.dart';
import 'package:prayers_application/presentation/screens/login/cubit/login_cubit.dart';
import 'package:prayers_application/presentation/screens/login/login_screen.dart';
import 'package:prayers_application/presentation/screens/my_card/my_card_screen.dart';
import 'package:prayers_application/presentation/screens/register/cubit/register_cubit.dart';
import 'package:prayers_application/presentation/screens/register/register_screen.dart';
import 'presentation/screens/add_product/add_product_screen.dart';
import 'presentation/screens/add_product/cubit/add_product_cubit.dart';
import 'presentation/screens/home/cubit/home_cubit.dart';
import 'presentation/screens/home/home_screen.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScrren:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (contxt) => LoginCubit(),
            child: const LoginScreen(),
          ),
        );
      case registerScrren:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (contxt) => RegisterCubit(),
            child: const RegisterScreen(),
          ),
        );
      case homeScrren:
        // final userData = settings.arguments as User;
        //?? token as User
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (contxt) => HomeCubit(),
            child: const HomeScreen(
                //  user: userData,
                ),
          ),
        );
      case editProduct:
        final productId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (contxt) => EditProductsCubit(),
            child: EditProducts(
              productDocId: productId,
            ),
          ),
        );
      case addProduct:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => AddProductCubit(),
                  child: const AddProductScreen(),
                ));
      case myCard:
        return MaterialPageRoute(builder: (_) => const MyCardScreen());
    }
  }
}
