import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayers_application/constants/my_string.dart';

import 'cubit/add_product_cubit.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController productNameController = TextEditingController();

  TextEditingController productDetailsController = TextEditingController();

  TextEditingController productImageController = TextEditingController();

  TextEditingController productcategoryController = TextEditingController();
  bool checkedValue = false;
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
                  const Text("Add Your Product Catogare"),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        items: <String>['A', 'B', 'C', 'D'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (_) {
                          productcategoryController.text = _!;
                        },
                      ),
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
                            borderRadius: BorderRadius.circular(20)),
                        child: ElevatedButton(
                          onPressed: () async {
                            await BlocProvider.of<AddProductCubit>(context)
                                .addProduct(
                                    productsName: productNameController.text,
                                    productsDetails:
                                        productDetailsController.text,
                                    productsImage: productImageController.text,
                                    productscategory:
                                        productcategoryController.text,
                                    productsIsSally: checkedValue);
                          },
                          child: state is AddProductChangeLoadingState
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
                          // child: const Text(
                          //   'Add',
                          //   style: TextStyle(color: Colors.white, fontSize: 25),
                          // ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
