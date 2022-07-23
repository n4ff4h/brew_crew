import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  const Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>(); // Identify register form

  // TextFied state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0,
        title: const Text('Register in to Brew Crew'),
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
              'Sign in',
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
                // used by validate() function in sign in button
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
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
                // used by validate() function in sign in button
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
                  // `_formKey.currentState.validate()` evaluates to 'true' of 'false'
                  // Goes to each field and runs their respective `validator:` functions
                  if (_formKey.currentState!.validate()) {
                    // Create user
                    dynamic result = await _auth.registerWithEmailAndPassword(
                        email, password);

                    // If there is an error when creating user
                    if (result == null) {
                      setState(() {
                        error = 'Error when creating user';
                      });
                    }

                    /*
                      If user is successfully created, 
                      user is automatically signed in(Firebase handles) and taken to the home page
                      Note: Auth change stream is actively listening to user objects,
                            and register function above returns a user object.
                    */
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink[400],
                ),
                child: const Text('Register'),
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
