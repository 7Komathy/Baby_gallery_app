import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For parsing JSON response

import 'package:provider/provider.dart'; // Import Provider
import 'providers/app_state.dart'; // Import AppState

// NetworkService class to handle the network request
class NetworkService {
  // Method to fetch data from an API
  Future<Map<String, dynamic>> fetchData() async {
    final url = Uri.parse(
        'https://jsonplaceholder.typicode.com/posts'); // Sample API endpoint

    try {
      // Send a GET request to the API endpoint
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Parse the response body as JSON
        var data = json.decode(response.body);
        return data; // Return the fetched data
      } else {
        // Handle error if the status code is not 200
        print('Failed to load data: ${response.statusCode}');
        return {}; // Return an empty map in case of error
      }
    } catch (e) {
      // Catch and handle any exceptions
      print('Error: $e');
      return {}; // Return an empty map in case of error
    }
  }
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _fetchedData = 'No data yet';

  final NetworkService _networkService = NetworkService();

  @override
  void initState() {
    super.initState();
    // Fetch data when the screen is loaded
    _fetchData();
  }

  void _fetchData() async {
    // Call the fetchData method to get the data from the API
    var data = await _networkService.fetchData();

    // Update the state with the fetched data
    setState(() {
      _fetchedData = data.toString(); // Convert data to string for display
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text('$_counter',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 20),
            const Text('Fetched Data from API:'),
            Text(
              _fetchedData,
              style: const TextStyle(fontSize: 16, color: Colors.green),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
