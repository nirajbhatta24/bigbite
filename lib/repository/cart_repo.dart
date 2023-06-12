import 'package:artsy/model/cart.dart';
import 'package:artsy/model/products.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data_source/remote_data_source/cart_remote_datasource.dart';
part 'cart_repo.g.dart';

@riverpod
CartRepository cartRepository(CartRepositoryRef ref) => CartRepositoryImpl();

final cartProvider = StateNotifierProvider<CartNotifier, List<Cart>>(
  (ref) => CartNotifier(),
);

class CartNotifier extends StateNotifier<List<Cart>> {
  CartNotifier() : super([]);

  void removeFromCart(Cart cart) {
    state = state.where((cartItem) => cartItem != cart).toList();
    CartRepositoryImpl().deleteProductFromCart(cart.cId);
  }
}

abstract class CartRepository {
  Future<bool> addProductToCart(Product product, int quantity, int amount);
  Future<List<Cart>?> getAllCart();
  Future<bool?> deleteProductFromCart(int cartId);
}

class CartRepositoryImpl extends CartRepository {
  @override
  Future<bool> addProductToCart(Product product, int quantity, int amount) {
    return CartRemoteDataSource().addProductToCart(product, quantity, amount);
  }

  @override
  Future<bool?> deleteProductFromCart(int cartId) {
    return CartRemoteDataSource().deleteProductFromCart(cartId);
  }

  @override
  Future<List<Cart>?> getAllCart() {
    return CartRemoteDataSource().getAllCart();
  }
}
