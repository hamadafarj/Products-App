part of 'mycard_cubit.dart';

abstract class MycardState extends Equatable {
  const MycardState();

  @override
  List<Object> get props => [];
}

class MycardInitial extends MycardState {}

class ChangeState extends MycardState {}

class MyCardLoaded extends MycardState {
  final List<Product> product;
  const MyCardLoaded({required this.product});
  @override
  List<Object> get props => [product];
}

// class Increment extends MycardState {
//   final List<Product> product;
//   int count;
//   Increment({required this.product, required this.count});
//   @override
//   List<Object> get props => [product, count++];
// }

// class Decrement extends MycardState {
//   final List<Product> product;
//   int count;
//   Decrement({required this.product, required this.count});
//   @override
//   List<Object> get props => [product, count--];
// }
