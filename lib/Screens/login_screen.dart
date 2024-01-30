import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wac/auth/controler/auth_controller.dart';

  String Phonenumber ="";
class login_screen extends ConsumerStatefulWidget {

  const login_screen({super.key});

  @override
  ConsumerState<login_screen> createState() => _login_screenState();
}

class _login_screenState extends ConsumerState<login_screen> {

  void phonenumber(String number){
    setState(() {
      Phonenumber = number;
    });
  }
  void sendPhoneNumber(){
    String phonenumber= Phonenumber.trim();
    if (phonenumber.isNotEmpty){
      ref.read(AuthcontrollerProvider).signinwithphone(context, '+91$phonenumber');
    };
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Enter Your Mobile Number"),
        leading:const Drawer(
          child: Icon(Icons.call)
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 30,),
            const Text("Whatsapp will need to verify your phone number",style: TextStyle(
              fontSize: 17,
              fontStyle: FontStyle.italic
            ),),
            const SizedBox(height: 50,),
            Container(
              padding: const EdgeInsets.only(left: 50,right: 50),
              child: TextField(
                onChanged: phonenumber,
                autofocus: true,
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Phone Number",
                  counterText: " ",
                  icon: IconButton(
                    icon: const Icon(Icons.call),
                    onPressed: (){},
                  )
                ),
              ),
            ),
            const SizedBox(height: 50,),
            ElevatedButton(
              onPressed: sendPhoneNumber,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              ),
              child: const Text("Next",style: TextStyle(color: Colors.black,fontSize: 15),),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
