import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wac/Screens/MobileLayoutScreen.dart';
import 'package:wac/Screens/UserScreen.dart';
import 'package:wac/Screens/otp_screen.dart';
import 'package:wac/User_modules/User_models.dart';
import 'package:wac/firestorage%20auth/common_class_for_firebase_storage.dart';
import 'package:wac/utils/utils.dart';
import 'dart:io';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepository({required this.auth, required this.firestore});

  Future<Usermodel?>getCurrentUserData() async{
    var userData = await firestore.collection('users').doc(auth.currentUser?.uid).get();
    Usermodel? user;
    if (userData.data() !=null){
      user = Usermodel.fromMap(userData.data()!);
    }
    return user;
  }

  void signInviaphone(BuildContext context, String number) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          throw Exception(e.message!);
        },
        codeSent: ((String verificationId, int? recentToken) async {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => os(
              verificationID: verificationId,
            ),
          ));
        }),
        codeAutoRetrievalTimeout: (String verificationID) {},
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }

  void verifyOTP({
    required BuildContext context,
    required String verificationID,
    required String UserOTP,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID,
        smsCode: UserOTP,
      );
      await auth.signInWithCredential(credential);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const us()));
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }

  void saveUserDataToFirebase({
    required username,
    required File? profilepic,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      String uid = auth.currentUser!.uid;
      String photourl = "https://cdn-icons-png.flaticon.com/512/149/149071.png";
      if (profilepic != null) {
        photourl = await ref
            .read(commonFirebaseStorageRepositorProvider)
            .storeFiletoFirebase('profilePic$uid', profilepic);
      }

      var user = Usermodel(
          name: username,
          uid: uid,
          profilepic: photourl,
          isonline: true,
          phonenumber: auth.currentUser!.uid,
          groupId: []);
      await firestore.collection('users').doc(uid).set(user.toMap());

      Navigator.pushNamedAndRemoveUntil(context, "mls", (route) => false);
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
