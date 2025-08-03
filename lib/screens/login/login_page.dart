import 'package:admin_qurban_mart/components/textfield/textfield_component.dart';
import 'package:admin_qurban_mart/components/textfield/textfield_password_component.dart';
import 'package:admin_qurban_mart/constants.dart';
import 'package:admin_qurban_mart/values/screen_utils.dart';
import 'package:flutter/material.dart';

import 'logic.dart';

class LoginPage extends StatefulWidget {
  final void Function(dynamic isLogin)? onClickLogin;
  const LoginPage({Key? key, this.onClickLogin}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFf5f5f5),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 8,
            vertical: MediaQuery.of(context).size.height / 8),
        children: [Body()],
      ),
    );
  }
}

// ignore: must_be_immutable
class Body extends StatelessWidget {
  final l = Logic();

  Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          // width: 0.3.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Login Admin',
                style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: headingColor),
              ),
              // SizedBox(
              //   height: 30,
              // ),
              // Image.asset(
              //   'images/illustration-2.png',
              //   width: 300,
              // ),
            ],
          ),
        ),

        // Image.asset(
        //   'images/illustration-1.png',
        //   width: 0.2.w,
        // ),
        // MediaQuery.of(context).size.width >= 1300 //Responsive
        //     ? Image.asset(
        //         'images/illustration-1.png',
        //         width: 300,
        //       )
        //     : SizedBox(),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 7),
          child: Container(
            width: 0.24.w,
            child: _formLogin(context),
          ),
        )
      ],
    );
  }

  Widget _formLogin(BuildContext context) {
    return Column(
      children: [
        TextfieldComponent(
          controller: l.username,
          hintText: "Username",
        ),
        SizedBox(height: 30),

        TextfieldPasswordComponent(
          controller: l.password,
          hintText: "Password",
        ),
        SizedBox(height: 40),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: ElevatedButton(
            child: Container(
                width: double.infinity,
                height: 50,
                child: Center(child: Text("Login"))),
            onPressed: () {
              l.onLogin();
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        // SizedBox(height: 40),
        // Row(children: [
        //   Expanded(
        //     child: Divider(
        //       color: Colors.grey[300],
        //       height: 50,
        //     ),
        //   ),
        // ]),
      ],
    );
  }
}
