import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For parsing JSON response

import 'package:provider/provider.dart'; // Import Provider
import 'providers/app_state.dart'; // Import AppState
import 'providers/auth_provider.dart'; // Import AuthProvider
import 'screens/login_screen.dart'; // Import LoginScreen

// NetworkService class to handle the network request
class NetworkService {
  Future<List<dynamic>> fetchData() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body); // Return list of data
      } else {
        print('Failed to load data: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        ChangeNotifierProvider(
            create: (_) => AuthProvider()), // Add AuthProvider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/', // Start with LoginScreen
      routes: {
        '/': (context) => LoginScreen(), // Login Screen
        '/users': (context) =>
            const UsersScreen(), // Placeholder for Users page
      },
    );
  }
}

// UsersScreen as a placeholder for the next page after login
class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: Center(
        child: const Text(
          'Welcome to the Users Page!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
