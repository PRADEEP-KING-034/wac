import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wac/auth/controler/auth_controller.dart';
import 'package:wac/utils/utils.dart';

class us extends ConsumerStatefulWidget {
  const us({super.key});

  @override
  ConsumerState<us> createState() => _usState();
}

class _usState extends ConsumerState<us> {
  final TextEditingController namecontroller = TextEditingController();
  File? image;

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void storeUserData() async {
    String name = namecontroller.toString().trim();
    if (name.isNotEmpty) {
      ref
          .read(AuthcontrollerProvider)
          .saveUserDataToFirebase(context, name, image);
    }
  }

  @override
  void dispose() {
    super.dispose();
    namecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  image == null
                      ? const CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://cdn-icons-png.flaticon.com/512/149/149071.png"),
                          radius: 100,
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(
                            image!,
                          ),
                          radius: 100,
                        ),
                  Positioned(
                      bottom: 0,
                      right: 30,
                      child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(Icons.add_a_photo_outlined))),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: size.width * 0.85,
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: namecontroller,
                      decoration: const InputDecoration(
                        hintText: "Enter Your Username",
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: storeUserData,
                    icon: const Icon(Icons.done_all_outlined),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
