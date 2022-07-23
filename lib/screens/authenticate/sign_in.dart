import 'package:brew_crew/services/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  // TextFied state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0,
        title: const Text('Sign in to Brew Crew'),
        actions: [
          TextButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: const Text(
              'Register',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 50.0,
        ),
        child: Form(
          child: Column(
            children: [
              // Spacing
              const SizedBox(height: 20),

              // Email field
              TextFormField(
                // Everytime a user types something into the form field
                // val represents what is currently in the form field
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),

              // Spacing
              const SizedBox(height: 20),

              // Password Field
              TextFormField(
                obscureText: true,
                // Everytime a user types something into the form field
                // val represents what is currently in the form field
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),

              // Spacing
              const SizedBox(height: 20),

              // Sign in button
              ElevatedButton(
                onPressed: () async {
                  print(email);
                  print(password);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink[400],
                ),
                child: const Text('Sign in'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
