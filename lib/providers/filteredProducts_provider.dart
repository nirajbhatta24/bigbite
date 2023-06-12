import 'package:artsy/model/products.dart';
import 'package:artsy/providers/search_query_provider.dart';
import 'package:artsy/providers/selected_category_provider.dart';
import 'package:artsy/repository/product_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'filteredProducts_provider.g.dart';

@riverpod
Future<List<Product>?> filteredProducts(FilteredProductsRef ref) async {
  final ProductRepository productRepository =
      ref.watch(productRepositoryProvider);
  final selectedCategory = ref.watch(selectedCategoryProvider);
  final searchQuery = ref.watch(searchQueryProvider);
  var getProducts = await productRepository.getProducts();

  if (selectedCategory != null) {
    return getProducts.where((product) {
      return product.category!.categoryName==selectedCategory.categoryName;
    }).toList();
  }
  if (searchQuery.trim().isNotEmpty) {
    return getProducts.where((product) {
      return product.name!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  return getProducts;
}

