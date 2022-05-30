import 'package:mbvv/models/user_profile.dart';
import 'package:mobx/mobx.dart';
part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  @observable
  bool showLoginLoader = false;
  @observable
  bool showViewProfileLoader = false;
  @observable
  UserProfile userProfile = UserProfile();

  @action
  void updateProfile(var data) {
    userProfile = UserProfile.fromJson(data);
  }
}
