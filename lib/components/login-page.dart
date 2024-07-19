import 'package:flutter/material.dart';
import 'package:music_player_master/components/sign-up-page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_player_master/functionality/playlist_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SimpleLoginScreen extends StatefulWidget {
  /// Callback for when this form is submitted successfully. Parameters are (email, password)
  final Function(String? email, String? password)? onSubmitted;

  const SimpleLoginScreen({this.onSubmitted, Key? key}) : super(key: key);
  @override
  State<SimpleLoginScreen> createState() => _SimpleLoginScreenState();
}

class _SimpleLoginScreenState extends State<SimpleLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late String email, password;
  String? emailError, passwordError;
  Function(String? email, String? password)? get onSubmitted =>
      widget.onSubmitted;

  @override
  void initState() {
    super.initState();
    email = '';
    password = '';

    emailError = null;
    passwordError = null;
  }

  void resetErrorText() {
    setState(() {
      emailError = null;
      passwordError = null;
    });
  }

  bool validate() {
    resetErrorText();

    RegExp emailExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    bool isValid = true;
    if (email.isEmpty || !emailExp.hasMatch(email)) {
      setState(() {
        emailError = 'Email is invalid';
      });
      isValid = false;
    }

    if (password.isEmpty) {
      setState(() {
        passwordError = 'Please enter a password';
      });
      isValid = false;
    }

    return isValid;
  }

  void submit() async {
    try
    {
      await Supabase.instance.client.auth.signInWithPassword(
                  email: email,
                  password: password,
                );

                showDialog(
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
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PlaylistPage(),
                            ),
                          );
                        },
                        );
                      
    } catch(e)
    {
        print('Signup failed');
                    
    }
        
    //  }
   // }
    
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Material( 
    child : SingleChildScrollView(
   child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
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
            SizedBox(height: screenHeight * .12),
            InputField(
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
              
              labelText: 'Email',
              errorText: emailError,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autoFocus: true,
            ),
            SizedBox(height: screenHeight * .025),
            InputField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              onSubmitted: (val) => submit(),
              labelText: 'Password',
              errorText: passwordError,
              obscureText: true,
              textInputAction: TextInputAction.next,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * .075,
            ),
            FormButton(
              text: 'Log In',
              onPressed: submit,
            ),
            SizedBox(
              height: screenHeight * .15,
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SimpleRegisterScreen(),
                ),
              ),
              child: RichText(
                text: const TextSpan(
                  text: "I'm a new user,",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
   
      
    );
  }
  }

