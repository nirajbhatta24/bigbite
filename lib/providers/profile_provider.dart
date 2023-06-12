import 'package:artsy/model/user.dart';
import 'package:artsy/repository/user_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'profile_provider.g.dart';

@riverpod
Future<User> fetchProfile(FetchProfileRef ref) async {
  final UserRepository userRepository = ref.watch(userRepositoryProvider);

  var getUser = await userRepository.getProfile();
  return getUser;
}
