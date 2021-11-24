import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:prayers_application/constants/my_string.dart';
import 'package:prayers_application/presentation/screens/my_card/cubit/mycard_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await checkUserToken();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => MycardCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: token == null ? loginScrren : loginScrren,
      ),
    );
  }
}

String? token;
Future checkUserToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString("UserToken");
  print("ddd $token");
  // var pdfText = await json.decode(json.encode(token));
  // print("eefji $pdfText");
}
