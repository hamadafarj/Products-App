import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prayers_application/data/model/product_model.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository() : _firebaseAuth = FirebaseAuth.instance;
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  CollectionReference user = FirebaseFirestore.instance.collection('Users');

  Future<User?> signInWithCredentials(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  Future<UserCredential> signUp(
      {required String email,
      required String password,
      required String name,
      required String phone}) async {
    UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    addUserData(name, phone, email);
    return user;
  }

  addDateProduct(
      String productsDetails,
      String productsName,
      String productsImage,
      String productscategory,
      bool productsIsSally) async {
    await products.doc().set({
      'products_details': productsDetails,
      'products_image': productsName,
      'products_name': productsImage,
      'products_category': productscategory,
      'products_isSally': productsIsSally,
    });
    return products;
  }

  upDateProduct(String productsName, String productsDetails,
      String productsImage, String productDocsId, bool productsIsSale) async {
    await products
        .doc(productDocsId)
        .update({
          'products_name': productsName,
          'products_image': productsImage,
          'products_details': productsDetails,
          'products_isSally': productsIsSale
        })
        .then((_) => print('Success'))
        .catchError((error) => print('Failed: $error'));
    return products;
  }

  deleteDateProduct(String productDocsId) async {
    await products
        .doc(productDocsId)
        .delete()
        .then((_) => print('Success'))
        .catchError((error) => print('Failed: $error'));
    return products;
  }

  addUserData(String displayName, String phone, String email) async {
    await user.doc().set({
      'name': displayName,
      'phone_number': phone,
      'email': email,
    });
    return products;
  }

  Future<List<Product>> getData() async {
    List<Product> product = [];
    await FirebaseFirestore.instance
        .collection("products")
        .get()
        .then((querySnapshot) {
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        var a = querySnapshot.docs[i];
        var pro = Product.fromJson(a);
        pro.productDocsId = querySnapshot.docs[i].id;
        print("object ${pro.productDocsId}");
        product.add(pro);
      }
    });
    return product;
  }

  Future<List<Product>> getProductData(String productDocsId) async {
    List<Product> product = [];
    await FirebaseFirestore.instance
        .collection("products")
        .where('products_name', isEqualTo: productDocsId)
        .get()
        .then((querySnapshot) {
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        var a = querySnapshot.docs[i];
        var pro = Product.fromJson(a);
        pro.productDocsId = querySnapshot.docs[i].id;
        print("object ${pro.productDocsId}");
        product.add(pro);
      }
    });

    return product;
  }

  Future<List<Product>> getProductCategory(String productsCategory) async {
    List<Product> product = [];
    await FirebaseFirestore.instance
        .collection("products")
        .where('products_category', isEqualTo: productsCategory)
        .get()
        .then((querySnapshot) {
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        var a = querySnapshot.docs[i];
        var pro = Product.fromJson(a);
        product.add(pro);
      }
    });

    return product;
  }
}




// Future<void> signOut() async {
//     await FirebaseAuth.instance.signOut();
//   }

//   Future<bool> isSignedIn() async {
//     final currentUser = _firebaseAuth.currentUser;
//     return currentUser != null;
//   }

//   Future<dynamic> getUser() async {
//     final User? user = FirebaseAuth.instance.currentUser;
//     return user;
//   }

  //addData(email, email, email);
    //await userSetup(name, phone, user);
    //user.credential!.token

 // Future<Product> getProductData(String productId) async {
  //   List<Product> product = [];
  //   await FirebaseFirestore.instance
  //       .collection("products")
  //       .get()
  //       .then((querySnapshot) {
  //     for (int i = 0; i < querySnapshot.docs.length; i++) {
  //       var a = querySnapshot.docs[i];
  //       product.add(Product.fromJson(a));
  //     }
  //   });
  //   return product;
  // }

 // addUserData(String displayName, String phone, String email) async {
  //   CollectionReference user = FirebaseFirestore.instance.collection('Users');
  //   await products.doc().set({
  //     'name': displayName,
  //     'phone_number': phone,
  //     'email': email,
  //     //'user_id': uid
  //     // dynamic uid,
  //   });
  //   return user;
  // }

 // await FirebaseFirestore.instance
    //     .collection("products")
    //     .where('products_name', isEqualTo: productDocsId)
    //await products.doc(productDocsId).get();
    // .then((querySnapshot) {
    //    for (final doc in querySnapshot) {
    //       product.add(Product.fromJson(doc));
    //   }
    // }
    //     {
    //   // for (int i = 0; i < querySnapshot.length; i++) {
    //   //   var a = querySnapshot.docs[i];
    //   //   product.add(Product.fromJson(a));
    //   // }
    // }
    //);

  //   userSetup(String displayName, int phone, UserCredential uid) async {
  //   CollectionReference users = FirebaseFirestore.instance.collection('test');
  //   await users.add({'displayName': displayName, 'uid': uid, 'phone': phone});
  //   return users;
  // }