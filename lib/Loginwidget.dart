import 'package:cmsapp/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Loginwidget extends StatefulWidget {
  const Loginwidget({Key? key}) : super(key: key);

  @override
  State<Loginwidget> createState() => _LoginwidgetState();
}

class _LoginwidgetState extends State<Loginwidget> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Logged In"),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                    provider.Logout();
              },
              child: const Text("Logout",
                  style: TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 15, 15, 15))))
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Profile"),
              const SizedBox(
                height: 20,
              ),
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(user.photoURL!),
              ),
              Text(
                "Name:" + user.displayName!,
                style: const TextStyle(fontSize: 20, color: Colors.red),
              ),
              Text(
                "Email:" + user.email!,
                style: const TextStyle(fontSize: 20, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
