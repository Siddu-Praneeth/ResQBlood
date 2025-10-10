import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
const LoginPage({super.key});

@override
State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
final _emailController = TextEditingController();
final _passwordController = TextEditingController();
String? errorMessage;
bool isLoading = false;
bool _isPasswordVisible = false; // State for Password Visibility

@override
void dispose() {
_emailController.dispose();
_passwordController.dispose();
super.dispose();
}

Future<void> _login() async {
setState(() {
isLoading = true;
errorMessage = null;
});

// Basic Input Validation
if (_emailController.text.trim().isEmpty || _passwordController.text.trim().isEmpty) {
  setState(() {
    isLoading = false;
    errorMessage = "Please enter your email and password.";
  });
  return;
}

try {
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: _emailController.text.trim(),
    password: _passwordController.text.trim(),
  );

  if (mounted) {
    Navigator.pushReplacementNamed(context, '/home');
  }
} on FirebaseAuthException catch (e) {
  setState(() {
    if (e.code == 'user-not-found') {
      errorMessage = 'Account not found. Please create your account first.';
    } else if (e.code == 'wrong-password') {
      errorMessage = 'Invalid password. Please try again.';
    } else if (e.code == 'invalid-email') {
      errorMessage = 'The email address is not valid.';
    } else {
      errorMessage = e.message;
    }
  });
} finally {
  setState(() {
    isLoading = false;
  });
}
}

void _forgotPassword() {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Password reset email functionality coming soon!"),
      backgroundColor: Colors.red,
    ),
  );
}
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text("User Login"),
          backgroundColor: Colors.red,
          automaticallyImplyLeading: true,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.bloodtype, size: 100, color: Colors.red),
                const SizedBox(height: 10),
                const Text(
                  "Welcome Back Donor",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),

                // --- Email Field ---
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Your Email Address",
                    hintText: "example@email.com",
                    prefixIcon: const Icon(Icons.email, color: Colors.red),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.red, width: 2)),
                  ),
                ),
                const SizedBox(height: 20),

                // --- Password Field ---
                TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: "Your Password",
                    prefixIcon: const Icon(Icons.lock, color: Colors.red),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.red, width: 2)),
                  ),
                ),
                const SizedBox(height: 10),

                // Forgot Password Button
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _forgotPassword,
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // --- Login Button / Loading Indicator ---
                isLoading
                    ? const CircularProgressIndicator(color: Colors.red)
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        onPressed: _login,
                        child: const Text("LOGIN TO ACCOUNT",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),

                const SizedBox(height: 20),

                // --- Error Message ---
                if (errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                    ),
                  ),

                // Sign Up Link
                TextButton(
                  onPressed: () {
                    // Navigate to the signup screen
                    Navigator.pushReplacementNamed(context, '/signup');
                  },
                  child: const Text(
                    "Don't have an account? Sign Up Now",
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
}