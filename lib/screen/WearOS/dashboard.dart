import 'package:artsy/providers/filteredProducts_provider.dart';
import 'package:artsy/theme/size_config.dart';
import 'package:artsy/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wear/wear.dart';

import '../../components/productcard.dart';

class DashboardWearOSScreen extends StatefulWidget {
  const DashboardWearOSScreen({super.key});

  @override
  State<DashboardWearOSScreen> createState() => _DashboardWearOSScreenState();
}

class _DashboardWearOSScreenState extends State<DashboardWearOSScreen> {
  @override
  Widget build(BuildContext context) {
    return WatchShape(
      builder: (BuildContext context, WearShape shape, Widget? child) {
        return AmbientMode(builder: ((context, mode, child) {
          SizeConfig.init(context);
          double w = MediaQuery.of(context).size.width;
          double h = MediaQuery.of(context).size.height;
          return Scaffold(
              backgroundColor: COLOR_SECONDARY,
              body: SafeArea(
                child: Column(children: const [_CardGrid()]),
              ));
        }));
      },
    );
  }
}

class _CardGrid extends ConsumerWidget {
  const _CardGrid();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(filteredProductsProvider);
    return products.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (products) => Expanded(
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: products?.length,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
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

