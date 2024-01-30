import 'package:flutter/material.dart';
import 'package:wac/Screens/login_screen.dart';

class ls extends StatelessWidget {
  const ls({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white24,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 50,),
                const Text("Welcome to Whatsapp!",style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),),
          
                const SizedBox(height: 50,),
                Container(
                  height: 300,
                  width: 300,
                  child: const Image(
                    image: AssetImage('assets/images/bg.png'),
                    color: Colors.green,
                  ),
                ),
          
                const SizedBox(height: 200,),
          
                const Text("Read our privacy policy. Tap \"Agree and Proceed\" to",style: TextStyle(
                  color: Colors.white,
                  fontSize: 14
                ),),
          
                const Text("accept the terms and conditions",style: TextStyle(
                    color: Colors.white,
                    fontSize: 14
                ),),
                const SizedBox(height: 10,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    fixedSize: const Size(300,50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    )
                  ),
                  child: const Text("AGREE AND CONTINUE",style: TextStyle(color: Colors.white,fontSize: 15),),
                  onPressed: (){Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context)=> const login_screen()
                    )
                  );},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
