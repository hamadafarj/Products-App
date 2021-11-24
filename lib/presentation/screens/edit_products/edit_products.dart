import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:prayers_application/constants/my_string.dart';
import 'package:prayers_application/helper/ads_helper.dart';
import 'cubit/edit_products_cubit.dart';
import 'cubit/edit_products_state.dart';

class EditProducts extends StatefulWidget {
  final String productDocId;
  const EditProducts({Key? key, required this.productDocId}) : super(key: key);

  @override
  _EditProductsState createState() => _EditProductsState();
}

class _EditProductsState extends State<EditProducts> {
  TextEditingController? productNameController;

  TextEditingController? productDetailsController;

  TextEditingController? productImageController;

  bool checkedValue = false;

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
    BlocProvider.of<EditProductsCubit>(context)
        .getProductDetails(widget.productDocId);
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
    return BlocConsumer<EditProductsCubit, EditProductsState>(
      listener: (context, state) {
        if (state is ProductEditFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.responseMessage),
            ),
          );
        } else if (state is ProductEditSuccessState) {
          Navigator.pushNamedAndRemoveUntil(
              context, homeScrren, (route) => false);
        } else if (state is ProductEditLoadingState) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: BlocBuilder<EditProductsCubit, EditProductsState>(
            builder: (context, state) {
              if (state is ProductLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ProductLoadedState) {
                productNameController =
                    TextEditingController(text: state.product.productName);
                productDetailsController =
                    TextEditingController(text: state.product.productDetails);
                productImageController =
                    TextEditingController(text: state.product.productImage);
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Edit Product name"),
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
                            const Text("Edit Product Details"),
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
                            const Text("Edit Product Image Url"),
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
                                      print("object ${widget.productDocId}");
                                      await BlocProvider.of<EditProductsCubit>(
                                              context)
                                          .editProductInformation(
                                              productsName:
                                                  productNameController!.text,
                                              productsDetails:
                                                  productDetailsController!
                                                      .text,
                                              productsImage:
                                                  productImageController!.text,
                                              productDocsId:
                                                  widget.productDocId,
                                              productsIsSale: checkedValue);
                                    },
                                    child: state is ProductEditLoadingState
                                        ? const Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.green,
                                            ),
                                          )
                                        : const Text(
                                            'Save Change',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                            checkForAd()
                          ],
                        ),
                      )
                    ],
                  ),
                );
              } else if (state is EditProductsState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Text("Error Message");
              }
            },
          ),
        );
      },
    );
  }
}
