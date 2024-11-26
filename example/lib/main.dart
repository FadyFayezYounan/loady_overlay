import 'package:flutter/material.dart';
import 'package:loady_overlay/loady_overlay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPageExample(),
      //  home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class LoginPageExample extends StatefulWidget {
  const LoginPageExample({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageExampleState();
}

class _LoginPageExampleState extends State<LoginPageExample> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Optional: Listen to loading status changes
    LoadyOverlay.onStatusChanged((status) {
      debugPrint('Current loading status: $status');
    });
  }

  Future<void> _performLogin() async {
    try {
      // Show loading overlay immediately
      LoadyOverlay.show(
        context,
        config: LoadyOverlayConfig(
          backgroundColor:
              Colors.black54, // Optional: Semi-transparent background
          builder: (context) => const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                'Logging in...',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );

      // Simulate network request
      await Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          LoadyOverlay.hide(context); // Hide the overlay
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login successful')),
          );
        }
      });
    } catch (e) {
      // Handle any errors
      if (mounted) {
        LoadyOverlay.hide(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _performLogin,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
