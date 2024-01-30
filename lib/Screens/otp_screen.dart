import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wac/auth/controler/auth_controller.dart';

class os extends ConsumerWidget {
  final String verificationID;
  const os({super.key,required this.verificationID});


  void verifyOTP(BuildContext context, String UserOtp, WidgetRef ref){
    ref.read(AuthcontrollerProvider).verifyOTP(context, verificationID, UserOtp);
  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Verify Your Number"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 100,),
              Text("We send a otp to your number"),
              Container(
                height: 200,
                width: 200,
                child: TextField(
                  onChanged: (value) => {
                    if (value.length==6){
                      print(value.toString().trim()),
                      //verifyOTP(context, value, ref)
                    }else{
                      print("no")
                    }
                  },
                  onSubmitted: (value) => verifyOTP(context, value.toString().trim(), ref),
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Enter OTP",
                    counterText: "",
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}