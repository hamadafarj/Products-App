import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/mycard_cubit.dart';

class MyCardScreen extends StatefulWidget {
  const MyCardScreen({Key? key}) : super(key: key);

  @override
  State<MyCardScreen> createState() => _MyCardScreenState();
}

class _MyCardScreenState extends State<MyCardScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MycardCubit>(context).getCardProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<MycardCubit, MycardState>(
        builder: (context, state) {
          if (state is ChangeState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MyCardLoaded) {
            var product = state.product;
            return Column(
              children: [
                SizedBox(
                  height: 100,
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 12,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      child: Text(
                          "Total Products in cart: ${product.length.toString()} Total Price ${state.totalPrice}"),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ListView.builder(
                        itemCount: product.length,
                        itemBuilder: (BuildContext context, index) {
                          return SizedBox(
                            height: 100,
                            child: Card(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              elevation: 0.9,
                              color: const Color(0xffF9F9F9),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        product[index].productsIsSale
                                            ? Container(
                                                height: double.infinity,
                                                width: 5,
                                                color: Colors.red,
                                              )
                                            : Container(
                                                height: double.infinity,
                                                width: 5,
                                                color: Colors.green,
                                              ),
                                        SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: FittedBox(
                                            child: Text(
                                              product[index].productName,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                height: 2,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(product[index]
                                            .productPrice
                                            .toString()),
                                        IconButton(
                                            onPressed: () {
                                              BlocProvider.of<MycardCubit>(
                                                      context)
                                                  .increment(product[index]);
                                            },
                                            icon: const Icon(Icons.add)),
                                        Text(product[index]
                                            .cardNumberItem
                                            .toString()),
                                        IconButton(
                                            onPressed: () {
                                              BlocProvider.of<MycardCubit>(
                                                      context)
                                                  .decrement(product[index]);
                                            },
                                            icon: const Icon(Icons.remove)),
                                        IconButton(
                                            onPressed: () {
                                              BlocProvider.of<MycardCubit>(
                                                      context)
                                                  .removeItemFromList(
                                                      product[index]);
                                            },
                                            icon: const Icon(Icons
                                                .highlight_remove_rounded)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            );
          } else {
            return const Text(" wrong");
          }
        },
      ),
    );
  }
}

// class CardWidget extends StatelessWidget {
//   final List<Product> product;
//   // final Function increment;
//   // final Function decrement;
//   const CardWidget({
//     Key? key,
//     required this.product,
//     // required this.increment,
//     // required this.decrement
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: 100,
//           child: Card(
//             color: Colors.lightBlueAccent,
//             elevation: 12,
//             child: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(12),
//               child:
//                   Text("Total Products in cart: ${product.length.toString()}"),
//             ),
//           ),
//         ),
//         SingleChildScrollView(
//           child: SizedBox(
//             height: MediaQuery.of(context).size.height * 0.6,
//             child: ListView.builder(
//                 itemCount: product.length,
//                 itemBuilder: (BuildContext context, index) {
//                   return SizedBox(
//                     height: 100,
//                     child: Card(
//                       margin: const EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 10),
//                       elevation: 0.9,
//                       color: const Color(0xffF9F9F9),
//                       child: Padding(
//                         padding: const EdgeInsets.only(right: 10),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 product[index].productsIsSale
//                                     ? Container(
//                                         height: double.infinity,
//                                         width: 5,
//                                         color: Colors.red,
//                                       )
//                                     : Container(
//                                         height: double.infinity,
//                                         width: 5,
//                                         color: Colors.green,
//                                       ),
//                                 SizedBox(
//                                   height: 50,
//                                   width: 50,
//                                   child: FittedBox(
//                                     child: Text(
//                                       product[index].productName,
//                                       style: const TextStyle(
//                                         fontSize: 15,
//                                         height: 2,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                       textAlign: TextAlign.start,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 IconButton(
//                                     onPressed: () {
//                                       BlocProvider.of<MycardCubit>(context)
//                                           .increment(
//                                               product[index].cardNumberItem);
//                                     },
//                                     icon: const Icon(Icons.add)),
//                                 Text(product[index].cardNumberItem.toString()),
//                                 IconButton(
//                                     onPressed: () {
//                                       BlocProvider.of<MycardCubit>(context)
//                                           .decrement(
//                                               product[index].cardNumberItem);
//                                     },
//                                     icon: const Icon(Icons.remove)),
//                                 IconButton(
//                                     onPressed: () {
//                                       BlocProvider.of<MycardCubit>(context)
//                                           .removeItemFromList(product[index]);
//                                     },
//                                     icon: const Icon(
//                                         Icons.highlight_remove_rounded)),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//           ),
//         ),
//       ],
//     );
//   }
// }


   // else if (state is Decrement) {
          //   return CardWidget(
          //     product: state.product,
          //   );
          // }

/*
 // increment: () {
          //   BlocProvider.of<MycardCubit>(context).increment(state.product[]);
          // },
          // decrement: () {
          //   BlocProvider.of<MycardCubit>(context).decrement();
          // },
          // else if (state is Increment) {
          //   return CardWidget(
          //     product: state.product,
          //   );
          // }
*/
