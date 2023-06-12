import 'package:artsy/model/cart.dart';
import 'package:artsy/model/user.dart';
import 'package:artsy/repository/cart_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data_source/remote_data_source/response/cart_response.dart';
part 'cart_provider.g.dart';

@riverpod
Future<List<Cart>?> fetchCart(FetchCartRef ref) async {
  final CartRepository cartRepository = ref.watch(cartRepositoryProvider);

  var getCart = await cartRepository.getAllCart();
  return getCart;

  

}
