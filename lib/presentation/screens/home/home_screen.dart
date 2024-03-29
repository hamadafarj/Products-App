import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayers_application/constants/my_string.dart';
import 'package:prayers_application/data/model/product_model.dart';
import 'package:prayers_application/presentation/screens/home/cubit/home_cubit.dart';
import 'package:prayers_application/presentation/screens/my_card/cubit/mycard_cubit.dart';
import 'cubit/home_state.dart';

class HomeScreen extends StatefulWidget {
  //final User user;
  const HomeScreen({
    Key? key,
    //required this.user,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late List<Product> allProducts;
  late List<Product> searchedForProduct = [];
  bool _isSearching = false;
  final _searchTextController = TextEditingController();
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
    tabController.index = 0;
    tabController.addListener(_handleTabSelection);
    BlocProvider.of<HomeCubit>(context).getAllProduct();
  }

  void _handleTabSelection() {
    if (tabController.indexIsChanging) {
      switch (tabController.index) {
        case 0:
          BlocProvider.of<HomeCubit>(context).getAllProduct();
          break;
        case 1:
          BlocProvider.of<HomeCubit>(context)
              .geSpecificProduct(productsCategory: "A");
          break;
        case 2:
          BlocProvider.of<HomeCubit>(context)
              .geSpecificProduct(productsCategory: "B");
          break;
        case 3:
          BlocProvider.of<HomeCubit>(context)
              .geSpecificProduct(productsCategory: "C");
          break;
        case 4:
          BlocProvider.of<HomeCubit>(context)
              .geSpecificProduct(productsCategory: "D");
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.green),
          backgroundColor: Colors.white,
          title: _isSearching
              ? buildSearchField()
              : const Text(
                  'Products',
                  style: TextStyle(color: Colors.black),
                ),
          actions: buildAppBarAction(),
        ),
        drawer: const MyDrawer(
            // user: widget.user,
            ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, right: 10, left: 10),
              child: SizedBox(
                height: 80,
                child: Column(
                  children: [
                    TabBar(
                        isScrollable: true,
                        controller: tabController,
                        labelColor: Colors.green,
                        indicatorColor: Colors.transparent,
                        labelStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        unselectedLabelStyle: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.w700,
                        ),
                        onTap: (index) => _handleTabSelection(),
                        tabs: tabs),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          maxRadius: 10,
                        ),
                        Text("Products is Sale"),
                        CircleAvatar(
                          backgroundColor: Colors.green,
                          maxRadius: 10,
                        ),
                        Text("Products is still available"),
                        // Text("Click the item to watsh Products details"),
                      ],
                    )
                  ],
                ),
              ),
            ),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoadingState) {
                  return const ContainerDesign(
                    widget: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (state is HomeLoadedState) {
                  allProducts = (state).product;
                  return Expanded(
                    child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: tabController,
                        children: [
                          AllProductsTab(
                            allProducts: allProducts,
                            searchTextController: _searchTextController,
                            searchedForProduct: searchedForProduct,
                          ),
                          AllProductsTab(
                            allProducts: allProducts,
                            searchTextController: _searchTextController,
                            searchedForProduct: searchedForProduct,
                          ),
                          AllProductsTab(
                            allProducts: allProducts,
                            searchTextController: _searchTextController,
                            searchedForProduct: searchedForProduct,
                          ),
                          AllProductsTab(
                            allProducts: allProducts,
                            searchTextController: _searchTextController,
                            searchedForProduct: searchedForProduct,
                          ),
                          AllProductsTab(
                            allProducts: allProducts,
                            searchTextController: _searchTextController,
                            searchedForProduct: searchedForProduct,
                          ),
                        ]),
                  );
                } else {
                  return const Center(child: Text('error_message'));
                }
              },
            ),
            PageFoter(
              tabController: tabController,
            )
          ],
        ));
  }

  List<Widget> buildAppBarAction() {
    if (_isSearching == true) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.clear, color: Colors.black),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(Icons.search, color: Colors.black),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    _searchTextController.clear();
  }

  Widget buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: Colors.black,
      onChanged: (searchedCharacter) {
        addSearchedFOrItemsToSearchedList(searchedCharacter);
      },
      decoration: const InputDecoration(
        hintText: 'Find a specific product...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.black, fontSize: 18),
      ),
      style: const TextStyle(color: Colors.black, fontSize: 18),
    );
  }

  void addSearchedFOrItemsToSearchedList(String searchedProducts) {
    searchedForProduct = allProducts
        .where((character) =>
            character.productName.toLowerCase().startsWith(searchedProducts))
        .toList();
    setState(() {});
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showProductsDetails(context: context, product: product),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        elevation: 0.9,
        color: const Color(0xffF9F9F9),
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  product.productsIsSale
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
                        product.productName,
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
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, editProduct,
                        arguments: product.productDocsId);
                  },
                  child: const Text("edit")),
              InkWell(
                  onTap: () async {
                    bool checkItem =
                        BlocProvider.of<MycardCubit>(context).additemToList(
                      product,
                    );
                    if (checkItem) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Your Product in Card now"),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "Product number in Card ${product.cardNumberItem}"),
                        ),
                      );
                    }
                    product.cardNumberItem = product.cardNumberItem + 1;
                  },
                  child: const Text("add to Card")),
              InkWell(
                  onTap: () {
                    BlocProvider.of<HomeCubit>(context)
                        .deleteProduct(product.productDocsId);
                    Navigator.pushReplacementNamed(context, homeScrren);
                  },
                  child: const Text(
                    "delete",
                    style: TextStyle(color: Colors.red),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class AllProductsTab extends StatelessWidget {
  final List<Product> allProducts;
  final List<Product> searchedForProduct;
  final TextEditingController searchTextController;
  const AllProductsTab(
      {Key? key,
      required this.allProducts,
      required this.searchedForProduct,
      required this.searchTextController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return BlocProvider.of<HomeCubit>(context).refreshHomePage();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            ContainerDesign(
              widget: allProducts.isEmpty
                  ? const Center(
                      child: Text("In this Categary there not any item"))
                  : ListView.builder(
                      itemCount: searchTextController.text.isEmpty
                          ? allProducts.length
                          : searchedForProduct.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 100,
                            child: ProductItem(
                              product: searchTextController.text.isEmpty
                                  ? allProducts[index]
                                  : searchedForProduct[index],
                            ),
                          ),
                        );
                      }),
            ),
          ],
        ),
      ),
    );
  }
}

void showProductsDetails(
    {required Product product, required BuildContext context}) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: 300,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShowDiolgWidget(
                      title: "Product Name",
                      product: product.productName,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ShowDiolgWidget(
                      title: "Product Details",
                      product: product.productDetails,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ShowDiolgWidget(
                      title: "Product Image Url",
                      product: product.productImage,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ShowDiolgWidget(
                      title: "Product Category",
                      product: product.productCategory,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ShowDiolgWidget(
                      title: "Product isSale",
                      product: product.productsIsSale.toString(),
                    )
                  ],
                ),
              ),
            ),
          ));
}

class ShowDiolgWidget extends StatelessWidget {
  final String title;
  final String product;
  const ShowDiolgWidget({Key? key, required this.title, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, height: 2),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Text(product),
        ),
      ],
    );
  }
}

class PageFoter extends StatelessWidget {
  final TabController tabController;
  const PageFoter({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () {
              if (tabController.index > 0) {
                tabController.animateTo((tabController.index - 1));
              }
            },
            child: const Icon(Icons.west_outlined),
          ),
          FloatingActionButton(
            heroTag: "btn 2",
            onPressed: () {
              Navigator.pushNamed(context, addProduct);
            },
            child: const Icon(Icons.add),
          ),
          ElevatedButton(
            onPressed: () {
              if (tabController.index < 4) {
                tabController.animateTo((tabController.index + 1));
              }
            },
            child: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}

List<Widget> tabs = const [
  Tab(
      icon: Text(
    "All Product ",
    style: TextStyle(color: Colors.black),
  )),
  Tab(
      icon: Text(
    "Product A",
    style: TextStyle(color: Colors.black),
  )),
  Tab(
      icon: Text(
    "Product B",
    style: TextStyle(color: Colors.black),
  )),
  Tab(
      icon: Text(
    "Product C",
    style: TextStyle(color: Colors.black),
  )),
  Tab(
      icon: Text(
    "Product D",
    style: TextStyle(color: Colors.black),
  )),
];

class ContainerDesign extends StatelessWidget {
  final Widget widget;
  const ContainerDesign({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.67,
            child: widget));
  }
}
