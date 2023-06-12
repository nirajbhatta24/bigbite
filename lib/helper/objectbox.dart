import 'package:artsy/model/category.dart';
import 'package:artsy/model/products.dart';
import 'package:artsy/objectbox.g.dart';
import '../model/user.dart';
import 'package:path_provider/path_provider.dart';

class ObjectBoxInstance {
  late final Store _store;
  late final Box<User> _user;
  late final Box<Product> _product;
  late final Box<Category> _category;

  ObjectBoxInstance(this._store) {
    _user = Box<User>(_store);
    _category = Box<Category>(_store);
    _product = Box<Product>(_store);

  }
  // static Future<void> deleteDatabase() async {
  //   var dir = await getApplicationDocumentsDirectory();
  //   Directory('${dir.path}/artsy').deleteSync(recursive: true);
  // }

//initialization of objectBox
  static Future<ObjectBoxInstance> init() async {
    var dir = await getApplicationDocumentsDirectory();
    final store = Store(
      getObjectBoxModel(),
      directory: '${dir.path}/artstore',
    );

    return ObjectBoxInstance(store);
  }

  int addUser(User user) {
    return _user.put(user);
  }

  List<User> getAllUser() {
    return _user.getAll();
  }

  User? loginUser(String username, String password) {
    return _user
        .query(
            User_.username.equals(username) & User_.password.equals(password))
        .build()
        .findFirst();
  }

  int addCategory(Category category) {
    return _category.put(category);
  }

  addAllCategory(List<Category> lstCategory) {
    for (var item in lstCategory) {
      if (_category
              .query(Category_.categoryId.equals(item.categoryId!))
              .build()
              .findFirst() ==
          null) {
        _category.put(item);
      }
    }
  }

 

  List<Category> getAllCategory() {
    return _category.getAll();
  }

  //Search Product by CategoryName
  // List<Product> getProductByCategoryName(String categoryName) {
  //   return _category
  //       .query(Category_.categoryName.equals(categoryName))
  //       .build()
  //       .findFirst()!
  //       .
  // }

  //---------------- Product Queries ----------------
  int addProduct(Product product) {
    return _product.put(product);
  }

  addAllProduct(List<Product> lstProduct) {
    for (var item in lstProduct) {
      if (_product
              .query(Product_.productId.equals(item.productId!))
              .build()
              .findFirst() ==
          null) {
        _product.put(item);
      }
    }
  }

  List<Product> getAllProduct() {
    return _product.getAll();
  }
}
