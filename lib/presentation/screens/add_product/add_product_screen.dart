import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:prayers_application/constants/my_string.dart';
import 'package:prayers_application/helper/ads_helper.dart';
import 'cubit/add_product_state.dart';
import 'cubit/add_product_cubit.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  DateTime selectedDate = DateTime.now();
  DateTime? picked;
  TextEditingController productNameController = TextEditingController();

  TextEditingController productDetailsController = TextEditingController();

  TextEditingController productImageController = TextEditingController();

  TextEditingController productcategoryController = TextEditingController();

  TextEditingController productPriceController = TextEditingController();
  bool checkedValue = false;
  String dropDownValue = "Choose item";

  late BannerAd _ad;
  bool _isBannerAdReady = false;
  @override
  void dispose() {
    _ad.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _ad = BannerAd(
        size: AdSize.banner,
        adUnitId: AdHelper.bannerAdUnitId,
        listener: BannerAdListener(
          onAdLoaded: (_) {
            setState(() {
              _isBannerAdReady = true;
            });
          },
          onAdFailedToLoad: (ad, err) {
            print('Failed to load a banner ad: ${err.message}');
            _isBannerAdReady = false;
            ad.dispose();
          },
        ),
        request: const AdRequest());
    _ad.load();
  }

  Widget checkForAd() {
    if (_isBannerAdReady == true) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: _ad.size.width.toDouble(),
          height: _ad.size.height.toDouble(),
          child: AdWidget(ad: _ad),
        ),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddProductCubit, AddProductState>(
      listener: (context, state) {
        if (state is AddProductFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.responseMessage),
            ),
          );
        } else if (state is AddProductSuccessState) {
          Navigator.pushNamedAndRemoveUntil(
              context, homeScrren, (route) => false);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text("Add Your Product name"),
                  TextFormField(
                    controller: productNameController,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text("Add Your Product Details"),
                  TextFormField(
                    controller: productDetailsController,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text("Add Your Product Image Url"),
                  TextFormField(
                    controller: productImageController,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text("Add Your Product price"),
                  TextFormField(
                    controller: productPriceController,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    height: 60,
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () async {
                        picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2015, 8),
                            lastDate: DateTime(2101));
                        setState(() {});
                      },
                      child: Text(
                        picked == null
                            ? selectedDate.toString().split(" ").first
                            : picked.toString().split(" ").first,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text("Add Your Product Catogare"),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        hint: Text(dropDownValue),
                        items: <String>['A', 'B', 'C', 'D'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (_) {
                          dropDownValue = _!;
                          productcategoryController.text = _;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CheckboxListTile(
                    title: const Text("Products IsSale"),
                    value: checkedValue,
                    onChanged: (newValue) {
                      setState(() {
                        checkedValue = newValue!;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20)),
                        child: ElevatedButton(
                          onPressed: () async {
                            await BlocProvider.of<AddProductCubit>(context)
                                .addProduct(
                              productsName: productNameController.text,
                              productsDetails: productDetailsController.text,
                              productsImage: productImageController.text,
                              productscategory: productcategoryController.text,
                              productsIsSale: checkedValue,
                              productsPrice: productPriceController.text,
                              productDate: picked ?? selectedDate,
                            );
                          },
                          child: state is AddProductLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.green,
                                  ),
                                )
                              : const Text(
                                  'Add',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                        ),
                      ),
                    ],
                  ),
                  checkForAd()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
