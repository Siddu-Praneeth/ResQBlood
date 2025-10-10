import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Global Key to validate the entire form
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // State
  bool _detailsConfirmed = false;
  String? errorMessage;
  bool isLoading = false;
  
  // State for Password Visibility
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    setState(() {
      isLoading = true;
      errorMessage = null; // Clear previous Firebase errors
    });

    // --- Client-Side Validation using Form Key ---
    // This triggers the validator functions in all TextFormField widgets
    if (!_formKey.currentState!.validate()) {
      setState(() {
        isLoading = false;
        // Check the only remaining custom validation (the checkbox)
        if (!_detailsConfirmed) {
            errorMessage = "Please confirm that all details are correct.";
        }
      });
      return;
    }

    // --- Checkbox Validation (Must be done manually outside TextFormField) ---
    if (!_detailsConfirmed) {
      setState(() {
        isLoading = false;
        errorMessage = "Please confirm that all details are correct.";
      });
      return;
    }
    // --- End Validation ---

    try {
      // 1. Create account with Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // 2. Update the user's display name
      await userCredential.user?.updateDisplayName(
        "${_firstNameController.text.trim()} ${_lastNameController.text.trim()}",
      );

      // 3. Navigate only upon successful registration
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login'); 
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        // Handle specific Firebase authentication errors
        if (e.code == 'weak-password') {
          errorMessage = 'The password provided is too weak (min 6 characters).';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'An account already exists for that email.';
        } else {
          errorMessage = e.message ?? "An unknown error occurred.";
        }
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Helper function to validate email format
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Email Address.';
    }
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email format.'; // <-- Your requested message
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text("Create New Account"),
            backgroundColor: Colors.red,
            automaticallyImplyLeading: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Form( // ⭐ Wrapped content in a Form widget
                key: _formKey, // ⭐ Assigned GlobalKey
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.volunteer_activism, size: 100, color: Colors.red),
                    const SizedBox(height: 10),
                    const Text(
                      "Register as a new donor",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 40),

                    // --- First Name Field (NOW TextFormField) ---
                    TextFormField(
                      controller: _firstNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "First Name (Required)",
                        prefixIcon: const Icon(Icons.person, color: Colors.red),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your First Name.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // --- Last Name Field (NOW TextFormField) ---
                    TextFormField(
                      controller: _lastNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Last Name (Required)",
                        prefixIcon: const Icon(Icons.person_outline, color: Colors.red),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Last Name.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // --- Email Field (NOW TextFormField with Validator) ---
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email (Required)",
                        prefixIcon: const Icon(Icons.email, color: Colors.red),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: _validateEmail, // ⭐ Applied Email Validator
                    ),
                    const SizedBox(height: 20),

                    // --- Create Password Field (NOW TextFormField) ---
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: "Create Password (Min 6 chars)",
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
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please create a Password.';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // --- Confirm Password Field (NOW TextFormField) ---
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: !_isConfirmPasswordVisible,
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        prefixIcon: const Icon(Icons.lock_open, color: Colors.red),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your Password.';
                        }
                        if (value != _passwordController.text) {
                          return 'Password and Confirm Password must match.'; // Handles mismatch error
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),

                    // Confirmation Checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: _detailsConfirmed,
                          onChanged: (bool? newValue) {
                            setState(() {
                              _detailsConfirmed = newValue ?? false;
                              // Clear confirmation error message when checked
                              if (errorMessage == "Please confirm that all details are correct.") {
                                  errorMessage = null;
                              }
                            });
                          },
                          activeColor: Colors.red,
                        ),
                        const Flexible(
                          child: Text(
                            "I confirm that all the above details are correct.",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    
                    // Error Message (Now mainly for Firebase/Checkbox errors)
                    if (errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          errorMessage!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                        ),
                      ),

                    // Sign Up Button/Loading Indicator
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
                            onPressed: _signUp,
                            child: const Text("CREATE ACCOUNT", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ),

                    const SizedBox(height: 20),

                    // Login Link
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: const Text(
                        "Already have an account? Login",
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}