import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayers_application/constants/my_string.dart';
import 'cubit/edit_products_cubit.dart';

class EditProducts extends StatefulWidget {
  final String productId;
  const EditProducts({Key? key, required this.productId}) : super(key: key);

  @override
  _EditProductsState createState() => _EditProductsState();
}

class _EditProductsState extends State<EditProducts> {
  TextEditingController? productNameController;

  TextEditingController? productDetailsController;

  TextEditingController? productImageController;

  bool checkedValue = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<EditProductsCubit>(context)
        .getProductDetails(widget.productId);
  }

  @override
  void dispose() {
    super.dispose();
    productNameController?.dispose();
    productDetailsController?.dispose();
    productImageController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProductsCubit, EditProductsState>(
      listener: (context, state) {
        if (state is ProductEditChangeFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.responseMessage),
            ),
          );
        } else if (state is ProductEditChangeSuccessState) {
          Navigator.pushNamedAndRemoveUntil(
              context, homeScrren, (route) => false);
        } else if (state is ProductEditChangeLoadingState) {
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
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  child: SizedBox(
                    child: ListView.builder(
                        itemCount: state.product.length,
                        itemBuilder: (BuildContext context, index) {
                          productNameController = TextEditingController(
                              text: state.product[index].productName);
                          productDetailsController = TextEditingController(
                              text: state.product[index].productDetails);
                          productImageController = TextEditingController(
                              text: state.product[index].productImage);
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
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
                                  title: const Text("Products IsSally"),
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
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          print(
                                              "object ${state.product[index].productDocsId}");
                                          await BlocProvider.of<
                                                  EditProductsCubit>(context)
                                              .editProductInformation(
                                                  productsName:
                                                      productNameController!
                                                          .text,
                                                  productsDetails:
                                                      productDetailsController!
                                                          .text,
                                                  productsImage:
                                                      productImageController!
                                                          .text,
                                                  productDocsId: state
                                                      .product[index]
                                                      .productDocsId,
                                                  productsIsSale: checkedValue);
                                        },
                                        child: state
                                                is ProductEditChangeLoadingState
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.green,
                                                ),
                                              )
                                            : const Text(
                                                'Save Change',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25),
                                              ),
                                        // child: const Text(
                                        //   'Save Change',
                                        //   style: TextStyle(
                                        //       color: Colors.white,
                                        //       fontSize: 25),
                                        // ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        );
      },
    );
  }
}
