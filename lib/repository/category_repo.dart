import 'package:artsy/app/network_connectivity.dart';
import 'package:artsy/data_source/local_data_source/category_data_source.dart';
import 'package:artsy/data_source/remote_data_source/category_remote_data_source.dart';
import 'package:artsy/model/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getAllCategory();
  Future<int> addCategory(Category category);
  // Future<List<Product>> getProductByCategoryName(String name);
}

class CategoryRepositoryImpl extends CategoryRepository {
  @override
  Future<int> addCategory(Category category) {
    return CategoryDataSource().addCategory(category);
  }

  @override
  Future<List<Category>> getAllCategory() async {
    bool status = await NetworkConnectivity.isOnline();
    List<Category> lstCategory = [];
    if (status) {
      lstCategory = await CategoryRemoteDataSource().getAllCategory();
      await CategoryDataSource().addAllCategory(lstCategory);
      return lstCategory;
    } else {
      return CategoryDataSource().getAllCategory();
    }
  }

//   @override
//   Future<List<Product>> getProductByCategoryName(String name) {
//     return CategoryDataSource().getProductByCategoryName(name);
//   }
}
