import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'LoginPage.dart';


class RegisterPage extends StatefulWidget {
   RegisterPage({Key? key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
   //for firebase auth
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  User? user;

  @override
  Widget build(BuildContext context){
    //var mediaquery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical:30, horizontal: 30),
                child: Row(
                  children: [
                    Text(
                      "Register",
                      style: TextStyle(
                        color: Color(0xff074159),
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 9),

              // this is for blue area
              SingleChildScrollView(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(72),
                    topRight: Radius.circular(72),
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight : MediaQuery.of(context).size.height * 0.9,
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(30),
                      color: Theme.of(context).colorScheme.tertiary,
                      child: Column(
                        children: [
                        SizedBox(height: 30),


                        // Full Name Text Field
                        SizedBox(
                          width: 350,
                          height: 60,
                          child: TextField(
                            controller: _nameController,
                            style: const TextStyle(fontSize: 15 , height: 1,
                                color: Colors.black),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.lightBlue),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              hintText: "Full Name",
                              hintStyle: TextStyle(color: Colors.black12,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              fillColor: Theme.of(context).colorScheme.inversePrimary,
                              filled: true,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),

                        // Email Text Field
                        SizedBox(
                          width: 350,
                          height: 60,
                          child: TextField(
                            controller: _emailController,
                            style: const TextStyle(fontSize: 15 , height: 1,
                                color: Colors.black),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.lightBlue),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.black12,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              fillColor: Theme.of(context).colorScheme.inversePrimary,
                              filled: true,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),


                        //Password Text field
                        SizedBox(
                          width: 350,
                          height: 60,
                          child: TextField(
                            controller: _passwordController,
                            style: TextStyle(fontSize: 15 , height: 1,
                                color: Colors.black),
                            obscureText: true,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.lightBlue),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.black12,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              fillColor: Theme.of(context).colorScheme.inversePrimary,
                              filled: true,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),

                        //Confirm Password Text field
                        SizedBox(
                          width: 350,
                          height: 60,
                          child: TextField(
                            controller: _confirmPasswordController,
                            style: TextStyle(fontSize: 15 , height: 1,
                                color: Colors.black),
                            obscureText: true,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.lightBlue),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(color: Colors.black12,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              fillColor: Theme.of(context).colorScheme.inversePrimary,
                              filled: true,
                            ),
                          ),
                        ),
                        const SizedBox(height: 17),


                        //Register with fingerprint
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("register with Fingerprint!",
                              style: TextStyle(
                                color: Color(0xff4270B5),
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Register Button
                          ElevatedButton(
                            onPressed: () async {
                              // Validate password strength before attempting registration
                              if (_passwordController.text.length < 6) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Password must be at least 6 characters long'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return; // Exit the button press function if password is weak
                              }

                              // Display a progress indicator while registration is in progress
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return const Center(child: CircularProgressIndicator());
                                },
                              );

                              try {
                                UserCredential userCredential = await auth.createUserWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                                user = userCredential.user;
                                await user!.updateDisplayName(_nameController.text);
                                await user!.reload();
                                user = auth.currentUser;

                                if (user != null) {
                                  Navigator.pop(context); // Dismiss progress dialog
                                  Navigator.pushNamed(context, "profile"); // Replace with your profile page name
                                }
                              } on FirebaseAuthException catch (e) {
                                Navigator.pop(context); // Dismiss progress dialog
                                String message = '';
                                if (e.code == 'weak-password') {
                                  message = 'The password provided is too weak.';
                                } else if (e.code == 'email-already-in-use') {
                                  message = 'The account already exists for that email.';
                                } else {
                                  message = 'Registration failed: ${e.message}';
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(message),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              } catch (e) {
                                Navigator.pop(context); // Dismiss progress dialog
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('An unexpected error occurred: ${e.toString()}'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  'Register',
                                  style: TextStyle(fontSize: 24, color: Colors.white),
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              backgroundColor: Theme.of(context).colorScheme.background,
                            ),
                          ),

                          SizedBox(height: 15),

                        // Move to Login Page
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an Account?" ,
                              style: TextStyle(
                                  color: Color(0x6b4270b5),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return LoginPage();
                                    },
                                  ),
                                );
                              },
                              child: Text("  Login" ,
                                style: TextStyle(
                                    color: Color(0xff4270B5),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ],
                        ),

                        // "for leader "to send for admin email to access the app
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                //Navigator.push(
                                //context,
                                //MaterialPageRoute(
                                //builder: (context) {
                                // return Email();
                                //},
                                //),
                                //);
                              },
                              child: const Text("  Or Ask for a certified volunteer Account" ,
                                style: TextStyle(
                                    color: Color(0x6b4270b5),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ],
                        )


                      ],),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}