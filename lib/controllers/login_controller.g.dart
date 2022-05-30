// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginControllerBase, Store {
  final _$showLoginLoaderAtom =
      Atom(name: '_LoginControllerBase.showLoginLoader');

  @override
  bool get showLoginLoader {
    _$showLoginLoaderAtom.reportRead();
    return super.showLoginLoader;
  }

  @override
  set showLoginLoader(bool value) {
    _$showLoginLoaderAtom.reportWrite(value, super.showLoginLoader, () {
      super.showLoginLoader = value;
    });
  }

  final _$showViewProfileLoaderAtom =
      Atom(name: '_LoginControllerBase.showViewProfileLoader');

  @override
  bool get showViewProfileLoader {
    _$showViewProfileLoaderAtom.reportRead();
    return super.showViewProfileLoader;
  }

  @override
  set showViewProfileLoader(bool value) {
    _$showViewProfileLoaderAtom.reportWrite(value, super.showViewProfileLoader,
        () {
      super.showViewProfileLoader = value;
    });
  }

  final _$userProfileAtom = Atom(name: '_LoginControllerBase.userProfile');

  @override
  UserProfile get userProfile {
    _$userProfileAtom.reportRead();
    return super.userProfile;
  }

  @override
  set userProfile(UserProfile value) {
    _$userProfileAtom.reportWrite(value, super.userProfile, () {
      super.userProfile = value;
    });
  }

  final _$_LoginControllerBaseActionController =
      ActionController(name: '_LoginControllerBase');

  @override
  void updateProfile(dynamic data) {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction(
        name: '_LoginControllerBase.updateProfile');
    try {
      return super.updateProfile(data);
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
showLoginLoader: ${showLoginLoader},
showViewProfileLoader: ${showViewProfileLoader},
userProfile: ${userProfile}
    ''';
  }
}
