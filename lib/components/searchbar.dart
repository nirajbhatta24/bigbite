import 'package:artsy/providers/search_query_provider.dart';
import 'package:artsy/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Searchbar extends ConsumerWidget {
  const Searchbar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      decoration: const InputDecoration(
        fillColor: COLOR_GREY,
        hintText: "Search",
        icon: Icon(Icons.search),
        iconColor: COLOR_WHITE,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
      ),
      onChanged: ref.read(searchQueryProvider.notifier).onChange,
    );
  }
}
