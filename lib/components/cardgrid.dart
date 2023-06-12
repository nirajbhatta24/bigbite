import 'package:artsy/components/productcard.dart';
import 'package:artsy/providers/filteredProducts_provider.dart';
import 'package:artsy/theme/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class CardGrid extends ConsumerWidget {
  const CardGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig.init(context);
    final isMobile = MediaQuery.of(context).size.width < 500;
    final products = ref.watch(filteredProductsProvider);
    return products.when(loading: () => const Center(child: CircularProgressIndicator()),
        
        data: (products) => Expanded(
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: products?.length,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isMobile ? 2 : 3,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 24),
                  itemBuilder: (context, index) {
                    return ProductCard(
                      product: products![index],
                    );
                  }),
            ),
        error: (Object error, StackTrace stackTrace) {
          return const Center(child: Text('Something went wrong'));
        });
  }
}
