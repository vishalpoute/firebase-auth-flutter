import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/Register.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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

  Future<void> login() async {
    print("LOGIN BUTTON PRESSED");

    final email = _email.text.trim();
    final password = _password.text.trim();

    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      print("LOGIN SUCCESSFUL");
      print("User Credential: $userCredential");
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException occurred");
      print("Error Code: ${e.code}");
      print("Error Message: ${e.message}");
    } catch (e) {
      print(e.runtimeType);
      print("Unknown error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("LoginView BUILD RUNNING");

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
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

            TextButton(onPressed: login, child: const Text('Login')),

            TextButton(
              onPressed: () {
                print("Navigating to Register Page");

                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const RegisterView()),
                );
              },
              child: const Text('Not registered yet? Register here'),
            ),
          ],
        ),
      ),
    );
  }
}
