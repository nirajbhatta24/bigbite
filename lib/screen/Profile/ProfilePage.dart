import 'package:artsy/theme/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/constants.dart';
import '../../model/user.dart';
import '../../providers/profile_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePageScreen extends ConsumerWidget {
  const ProfilePageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(fetchProfileProvider);
    return data.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (data) => Scaffold(
              appBar: AppBar(
                title: const Text('Profile'),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: buildImage(data)),
                  buildName(data),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.pushNamed(context, '/updateprofile');
                    },
                    child: const Text('Change Password'),
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.history),
                    title: const Text('Order History'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.lock),
                    title: const Text('Change Shipping Details'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.remove('token');
                      Constant.token = '';
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                ],
              ),
            ),
        error: (Object error, StackTrace stackTrace) {
          return const Center(child: Text('Something went wrong'));
        });
  }
}

Widget buildImage(User user) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: CircleAvatar(
            radius: 52,
            backgroundImage: NetworkImage(Constant.imageURL + user.image!),
          ),
        ),
      ],
    );

Widget buildName(User user) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${user.fname!} ${user.lname!}'.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          user.email!,
          style: const TextStyle(color: Colors.grey),
        ),
        Text(
            '${user.address!.address}, ${user.address!.city}, ${user.address!.state}')
      ],
    );
