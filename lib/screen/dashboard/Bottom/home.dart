import 'dart:async';
import 'package:artsy/components/cardgrid.dart';
import 'package:artsy/components/searchbar.dart';
import 'package:artsy/model/category.dart';
import 'package:artsy/providers/selected_category_provider.dart';
import 'package:artsy/repository/category_repo.dart';
import 'package:flutter/material.dart';
import 'package:artsy/theme/theme_data.dart';
import '../../../components/categorychip.dart';
import '../../../theme/size_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artsy/components/drawer.dart';
import 'package:all_sensors2/all_sensors2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AccelerometerEvent _accelerometerEvent;
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

  @override
  void initState() {
    super.initState();

    _accelerometerSubscription =
        accelerometerEvents!.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerEvent = event;
      });
      if (_accelerometerEvent.z < -8.0) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _accelerometerSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'BigBite',
            style: TextStyle(
                color: COLOR_PRIMARY,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat'),
          ),
        ),
        drawer: const NavigatingDrawer(),
        body: SafeArea(
          child: Column(children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                  color: COLOR_GREY, borderRadius: BorderRadius.circular(25)),
              child: Column(
                children: const [
                  Searchbar(),
                  SizedBox(height: 10),
                ],
              ),
            ),
            const _CategoryFilter(),
            const SizedBox(height: 10),
            const CardGrid()
          ]),
        ));
  }
}

class _CategoryFilter extends ConsumerWidget {
  const _CategoryFilter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    return SizedBox(
      height: getProportionateScreenHeight(50),
      child: FutureBuilder(
        future: CategoryRepositoryImpl().getAllCategory(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final categories = snapshot.data as List<Category>;
            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CustomCategoryChip(
                    category: categories[index],
                    isSelected:
                        (selectedCategory == categories[index]) ? true : false,
                    onTap: () {
                      ref
                          .read(selectedCategoryProvider.notifier)
                          .setSelectedCategory(categories[index]);
                    },
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
