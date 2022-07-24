import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
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
  final _formKey = GlobalKey<FormState>(); // Identify register form
  bool loading = false;

  // TextFied state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
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
                key: _formKey,
                child: Column(
                  children: [
                    // Spacing
                    const SizedBox(height: 20),

                    // Email field
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
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
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      validator: (val) => val!.length < 6
                          ? 'Enter a password 6 plus chars long'
                          : null,
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
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });

                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);

                          // If there is an error when signing in user
                          if (result == null) {
                            setState(() {
                              error =
                                  'Could not sign in with those credentials!';
                              loading = false;
                            });
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pink[400],
                      ),
                      child: const Text('Sign in'),
                    ),

                    // Spacing
                    const SizedBox(height: 12.0),

                    // Error message
                    Text(
                      error,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
