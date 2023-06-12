import 'package:artsy/model/shipping.dart';
import 'package:artsy/model/products.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data_source/remote_data_source/address_remote_datasource.dart';



final addressRepositoryProvider = Provider<AddressRepository>((ref) {
  return AddressRepositoryImpl();
});

abstract class AddressRepository {
  Future<bool> addAddress(String address, String city, String state);
  Future<List<Address>?> getAddress();
}

class AddressRepositoryImpl extends AddressRepository {
  @override
  Future<bool> addAddress(String address, String city, String state) {
    return AddressRemoteDataSource().addAddress(address, city, state);
  }

  @override
  Future<List<Address>?> getAddress() {
    return AddressRemoteDataSource().getAddress();
  }
}

 