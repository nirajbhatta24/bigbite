import 'package:artsy/model/products.dart';
import 'package:artsy/model/user.dart';

class Constant {
  // static const String baseURL = "http://10.0.2.2:3000/";
  static const String baseURL = "http://192.168.0.115:3000/";

  // ----------------User URL----------------
  static const String userLoginURL = "users/login";
  static const String userURL = "users";

  static const String categoryURL = "category";
  static const String productURL = "products";
  static const String searchProductByCategoryURL =
      "product/searchProductByCategory/";
  static const String searchProductByIDURL = "product/searchProductByCategory/";
  static const String userprofileURL = "users/profile";

  static const String cartURL = "cart/";
  static const String addressURL = "address/";
  static const String orderURL = "order/";

  static User user = User();
  // static const String searchStudentByBatchURL = "searchStudentByBatch";
  // static const String searchStudentByCourseURL = "searchStudentByCourse";

  static const String imageURL = "http://192.168.0.115:3000";

  // ----------------Course URL----------------
  // static const String courseURL = "course";

  // For storing token or you can store token in shared preferences
  static String token = "";
}

class OrderPlacement {
  static int? amount;
  static String? status;
  static List<Product>? products;
  static List<int>? quantity;
}
