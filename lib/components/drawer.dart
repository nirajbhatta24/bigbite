import 'package:artsy/providers/profile_provider.dart';
import 'package:artsy/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artsy/model/user.dart';
import 'package:artsy/app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigatingDrawer extends ConsumerWidget {
  const NavigatingDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(fetchProfileProvider);
    return data.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (data) => Drawer(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    buildHeader(context, data),
                    buildMenuItems(context),
                  ],
                ),
              ),
            ),
        error: (Object error, StackTrace stackTrace) {
          return const Center(child: Text('Something went wrong'));
        });
  }

  Widget buildHeader(BuildContext context, User data) {
    return Material(
      color: Theme.of(context).primaryColor,
      child: InkWell(
        onTap: () {},
        child: Container(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 52,
                  backgroundImage:
                      NetworkImage(Constant.imageURL + data.image!),
                ),
                const SizedBox(height: 10),
                Text(
                  '${data.fname!} ${data.lname!}'.toUpperCase(),
                  style: const TextStyle(
                      color: COLOR_SECONDARY,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
                const SizedBox(height: 5),
              ],
            )),
      ),
    );
  }
}

Widget buildMenuItems(BuildContext context) => Container(
      padding: const EdgeInsets.all(20.0),
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pushNamed(context, '');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('token');
              Constant.token = '';
              Constant.user = User();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false);
            },
          ),
        ],
      ),
    );
