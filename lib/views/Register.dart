import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> register() async {
    final email = _email.text.trim();
    final password = _password.text.trim();

    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      print("User created: $userCredential");

      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      print("Register error: ${e.code}");

      if (e.code == 'weak-password') {
        print('Password is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('Account already exists.');
      } else if (e.code == 'invalid-email') {
        print('Invalid email address.');
      } else {
        print(e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _email,
              decoration: const InputDecoration(hintText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _password,
              decoration: const InputDecoration(hintText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),

            TextButton(onPressed: register, child: const Text('Register')),

            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Already have an account? Click here to login'),
            ),
          ],
        ),
      ),
    );
  }
}
