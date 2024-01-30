import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wac/Loader.dart';
import 'package:wac/Screens/MobileLayoutScreen.dart';
import 'package:wac/Screens/UserScreen.dart';
import 'package:wac/Screens/landing_screen.dart';
import 'package:wac/auth/controler/auth_controller.dart';
import 'package:wac/firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(const ProviderScope(child: Myapp()));
}

class Myapp extends ConsumerWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: ref.watch(userDataAuthProvider).when(
          data: (user){
            if(user == null){
              return const ls();
            }
            return const MobileLayoutScreen();
          },
          error: (err, trace){
            return ErrorWidget(err);
          },
          loading: ()=> const loader(),
      ),
      routes: {
        "myhomepage": (context) => const us(),
        "mls":(context) => const MobileLayoutScreen(),
      },
    );
  }
}
