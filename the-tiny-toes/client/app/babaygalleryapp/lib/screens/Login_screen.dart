import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        // Center the content in the middle of the screen
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .center, // Align the children in the center vertically
            children: [
              // Add the text "The Tiny Toes" above the username field
              Text(
                'The Tiny Toes',
                style: TextStyle(
                  fontSize: 24.0, // Set the font size for the title
                  fontWeight: FontWeight.bold, // Make the text bold
                  color: Colors.black, // Set the text color
                ),
              ),
              SizedBox(
                  height:
                      20), // Add some space between the title and the username field

              Container(
                width: 300.0, // Set the desired width
                child: TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
              SizedBox(height: 10), // Add some space between the fields
              Container(
                width: 300.0, // Set the desired width
                child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final authProvider =
                      Provider.of<AuthProvider>(context, listen: false);
                  final isLoggedIn = authProvider.login(
                    usernameController.text,
                    passwordController.text,
                  );

                  if (isLoggedIn) {
                    Navigator.pushReplacementNamed(context, '/users');
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text('Invalid username or password'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
