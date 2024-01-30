import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wac/User_modules/User_models.dart';
import 'package:wac/auth/repository/authentication.dart';

final AuthcontrollerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return Authcontroller(authrepository: authRepository, ref: ref);
});

final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(AuthcontrollerProvider);
  return authController.getUserdata();
});

class Authcontroller {
  final AuthRepository authrepository;
  final ProviderRef ref;

  Authcontroller({required this.authrepository, required this.ref});

  Future<Usermodel?> getUserdata() async {
    Usermodel? user = await authrepository.getCurrentUserData();
    return user;
  }

  void signinwithphone(BuildContext context, String number) {
    authrepository.signInviaphone(context, number);
  }

  void verifyOTP(BuildContext context, String verificationID, String UserOtp) {
    authrepository.verifyOTP(
        context: context, verificationID: verificationID, UserOTP: UserOtp);
  }

  void saveUserDataToFirebase(
      BuildContext context, String name, File? profilepic) {
    authrepository.saveUserDataToFirebase(
        username: name, profilepic: profilepic, ref: ref, context: context);
  }
}
