import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import '../../app/constants.dart';
import '../../repository/user_repo.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final key = GlobalKey<FormState>();

  final passwordController = TextEditingController();
  final cpasswordController = TextEditingController();

  _showMessage(status) {
    if (status == true) {
      Constant.token = '';
      Navigator.pushNamed(context, '/login');
      MotionToast.success(
        description: const Text('Password Changed Successfully'),
      ).show(context);
    } else {
      MotionToast.error(
        description: const Text('Error'),
      ).show(context);
    }
  }

  _saveUser() async {
    bool status = await UserRepositoryImpl().updateUser(
      passwordController.text,
    );
    _showMessage(status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Update your password',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'New Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: cpasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirm New Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != passwordController.text) {
                      return 'Password does not match';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (key.currentState!.validate()) {
                    _saveUser();
                  }
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
