import 'package:calc_tutor/components/my_button.dart';
import 'package:calc_tutor/components/my_textfield.dart';
import 'package:calc_tutor/components/square_tile.dart';
import 'package:calc_tutor/services/auth_services.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();


  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50,),
            //logo
            const Icon(
              Icons.lock,
              size: 100,
              ),

              const SizedBox(height: 50,),
               //welcome back
               Text(
                'Welcome back',
                style: TextStyle(
                  color: Colors.grey[200],
                  fontSize: 16,
                  ),
                ),

          //username textfield
          MyTextField(
            controller: usernameController,
            hintText: 'Username',
            obscureText: false,
          ),

          const SizedBox(height: 8.5),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.grey[600]),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          //sign in button
          MyButton(
            onTap: signUserIn,
          ),

          const SizedBox(height: 50),

          //or continue with


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.grey[400],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'or Continue with',
                    style: TextStyle(color: Colors.grey[700]),
                    ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 50),


          //google + canvas sign in buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //google button
              SquareTile(
                onTap: () => AuthService().SignInWithGoogle(),
                imagePath: 'lib/images/kisspng-g-suite-pearl-river-middle-school-google-software-sign-up-button-5ad4e1aa2b9049.9016727515239008421785 (1).png'
                ),

              SizedBox(width: 25),
              //canvas button
              SquareTile(
                onTap: () {},
                imagePath: 'lib/images/png-transparent-iphone-learning-management-system-canvas-lms-canvas-electronics-canvas-mobile-phones-thumbnail.png'
                ),
            ],
          ),


          const SizedBox(height: 50),

          //not a member then register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Not a member?',
                style: TextStyle(color: Colors.grey[700]),
                ),
              const SizedBox(width: 4),
              const Text(
                'Register now',
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
            ],
          ),

          //password textfield
          MyTextField(
            controller: passwordController,
            hintText: 'Password',
            obscureText: true,
          ),

          ]),
        ),
      ),
    );
  }
}
