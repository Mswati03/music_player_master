import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_player_master/functionality/playlist_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  bool _loading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      double screenHeight = MediaQuery.of(context).size.height;
    return _loading
        ? const Center(child: CircularProgressIndicator())
        : Material( 
        child : Scaffold(
        body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            children: [
              ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
          children: [
            SizedBox(height: screenHeight * .12),
            const Text(
              'Welcome to MusicMatrix',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * .01),
            Text(
              'Sign in to continue!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black.withOpacity(.6),
              ),
            ),
          ],
          
            
        ),
            SizedBox(height: screenHeight * .12),
            
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: const InputDecoration(label: Text('Email')),
              ),
              const SizedBox(height: 16),
              TextFormField(
                obscureText: true,
                controller: _passwordController,
                decoration: const InputDecoration(label: Text('Password')),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                 
                  try {
                     final response = await Supabase.instance.client.auth.signInWithPassword(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      ); print("ENtered");
                     Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PlaylistPage(),
                            ),
                          );
                     /*showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return  LoadingAnimationWidget.inkDrop(
                              color: Colors.blueAccent,
                              size: 50,



                            );
                          },
                        );
                        new Future.delayed(new Duration(seconds: 1), () {
                         
                        },
                        );*/
                  } catch (e) {
                    print("Not ENtered");
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Login failed'),
                      backgroundColor: Colors.red,
                    ));
                    setState(() {
                      _loading = false;
                    });
                  }
                   setState(() {
                    _loading = true;
                  });
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () async {
                  setState(() {
                    _loading = true;
                  });
                  try {
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    await Supabase.instance.client.auth.signUp(
                      email: email,
                      password: password,
                    );
                    print("Registered");
                    Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PlaylistPage(),
                            ),
                          );
                    
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Signup failed'),
                      backgroundColor: Colors.red,
                    ));
                    setState(() {
                      _loading = false;
                    });
                  }
                },
                child: const Text('Sign Up'),
              ),
            ],
        ),
        ),
          );
  }
}
