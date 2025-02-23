// //Yousef Yasser Gui & Yousef Mohamed firebase integration
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../Screens/HomePage.dart';
// import '../reset_password/forget_screen.dart';
// import 'SignUp.dart';
//
// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: const LoginScreen(),
//     );
//   }
// }
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _isLoading = false;
//
//   Future<void> _login() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (_formKey.currentState!.validate()) {
//       setState(() => _isLoading = true);
//       String? result = await signInWithEmailAndPassword(
//         _emailController.text.trim(),
//         _passwordController.text.trim(),
//       );
//       setState(() => _isLoading = false);
//
//       if (result == null && user!.emailVerified ) {
//         if (!mounted) return;
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => Homepage()),
//         );
//       } else {
//         if(user!.emailVerified==false){
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                   "Email Is Not Verified , Please Cheak it "),
//               backgroundColor: Colors.redAccent));
//         }
//         else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                   "Email Or Password Is Incorrect , Please Cheak it "),
//               backgroundColor: Colors.redAccent,
//               duration: const Duration(seconds: 3),
//             ),
//           );
//         }
//       }
//     }
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(32, 33, 100, 100),
//       body: Column(
//         children: [
//           SizedBox(height: size.height * 0.1),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
//             child: const Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 "Login",
//                 style: TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
//             child: const Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 "Welcome to MediBot app",
//                 style: TextStyle(fontSize: 16, color: Colors.white70),
//               ),
//             ),
//           ),
//           SizedBox(height: size.height * 0.05),
//           Expanded(
//             child: Container(
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(30),
//                   topRight: Radius.circular(30),
//                 ),
//               ),
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: size.width * 0.06,
//                   vertical: size.height * 0.04,
//                 ),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       TextFormField(
//                         controller: _emailController,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "Please enter your email";
//                           } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
//                               .hasMatch(value)) {
//                             return "Enter a valid email address";
//                           }
//                           return null;
//                         },
//                         decoration: InputDecoration(
//                           labelText: "Email",
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                         ),
//                         keyboardType: TextInputType.emailAddress,
//                       ),
//                       SizedBox(height: size.height * 0.02),
//                       TextFormField(
//                         controller: _passwordController,
//                         validator: (value) => value == null || value.isEmpty ? 'Please enter your password' : null,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           labelText: "Password",
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                         ),
//                       ),
//                       SizedBox(height: size.height * 0.02),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: TextButton(
//                           onPressed: () => Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (_) =>  ForgotPasswordScreen()),
//                           ),
//                           child: const Text("Forgot password?", style: TextStyle(color: Colors.grey)),
//                         ),
//                       ),
//                       SizedBox(height: size.height * 0.03),
//                       ElevatedButton(
//                         onPressed: _isLoading ? null : _login,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color.fromRGBO(54, 106, 166, 100),
//                           padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                         ),
//                         child: _isLoading
//                             ? const CircularProgressIndicator(color: Colors.white)
//                             : const Text("Log In", style: TextStyle(fontSize: 18, color: Colors.white)),
//                       ),
//                       SizedBox(height: size.height * 0.03),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text("Don't have an account?"),
//                           TextButton(
//                             onPressed: () => Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (_) => const SignUpPage()),
//                             ),
//                             child: const Text(
//                               "Sign Up",
//                               style: TextStyle(
//                                 color: Color.fromRGBO(54, 106, 166, 100),
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: size.height * 0.05),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// Future<String?> signInWithEmailAndPassword(String email, String password) async {
//   try {
//     await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
//     return null; // Success
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'user-not-found') {
//       return 'No user found for that email.';
//     } else if (e.code == 'wrong-password') {
//       return 'Wrong password provided.';
//     } else {
//       return 'Login failed: ${e.message}';
//     }
//   } catch (_) {
//     return 'An unexpected error occurred.';
//   }
// }
//
// Yousef Yasser Gui & Yousef Mohamed - Firebase integration
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Screens/HomePage.dart';
import '../reset_password/forget_screen.dart';
import 'SignUp.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      String? result = await signInWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      setState(() => _isLoading = false);
      User? user = FirebaseAuth.instance.currentUser;

      if (result == null && user != null && user.emailVerified) {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        );
      } else {
        String message = user != null && !user.emailVerified
            ? "Email is not verified. Please check your inbox."
            : "Email or password is incorrect. Please check it.";

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.redAccent,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(32, 33, 100, 1),
      body: Column(
        children: [
          SizedBox(height: size.height * 0.1),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Welcome to MediBot app",
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.05),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.06,
                  vertical: size.height * 0.04,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Email Field
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your email";
                          } else if (!RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                          ).hasMatch(value)) {
                            return "Enter a valid email address";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: size.height * 0.02),

                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter your password'
                            : null,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>  ForgotPasswordScreen(),
                            ),
                          ),
                          child: const Text(
                            "Forgot password?",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),

                      // Login Button
                      ElevatedButton(
                        onPressed: _isLoading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(54, 106, 166, 1),
                          padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.02,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                          "Log In",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),

                      // Sign Up Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SignUpPage(),
                              ),
                            ),
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Color.fromRGBO(54, 106, 166, 1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.05),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Firebase Authentication Function
Future<String?> signInWithEmailAndPassword(String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return null; // Successful sign-in
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      return 'Wrong password provided.';
    } else {
      return 'Login failed: ${e.message}';
    }
  } catch (_) {
    return 'An unexpected error occurred.';
  }
}

