// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../Animation/fade_Animation.dart';
import '../admin/admin_screen.dart';
import '../user_view_model/user_model.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void loginToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 65, 113, 153),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 30,
              width: 80,
              height: 200,
              child: FadeAnimation(
                  1,
                  Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/light-1.png'))),
                  )),
            ),
            Positioned(
              right: 70,
              width: 80,
              height: 150,
              child: FadeAnimation(
                  1.3,
                  Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/light-2.png'))),
                  )),
            ),
            Positioned(
              right: 7,
              top: 10,
              width: 80,
              height: 150,
              child: FadeAnimation(
                  1.5,
                  Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/clock.png'))),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0)
                  .add(const EdgeInsets.only(top: 200)),
              child: Column(
                children: <Widget>[
                  FadeAnimation(
                      1.8,
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10))
                            ]),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 50,
                                padding: const EdgeInsets.all(8.0),
                                decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey)),
                                ),
                                child: TextFormField(
                                  controller: email,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Enter Email ",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Email is required.';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                height: 50,
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: password,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Enter Password",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password is required.';
                                    }
                                    return null;
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 30,
                  ),

                  // FadeAnimation(
                  //   2,

                  InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        final isLoggedIn = await context
                            .read<UserModel>()
                            .userData(email.text.toString().trim(),
                                password.text.toString().trim());
                        // ignore: use_build_context_synchronously
                        final model = context.read<UserModel>();
                        if (isLoggedIn) {
                          loginToast(model.loginUser.message);
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminPage()),
                          );
                        } else {
                          loginToast(model.loginUser.message);
                        }
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(colors: [
                            Color.fromRGBO(143, 148, 251, 1),
                            Color.fromRGBO(143, 148, 251, .6),
                          ])
                          // color: Theme.of(context).canvasColor,
                          ),
                      child: const Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  //  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const FadeAnimation(
                      1.5,
                      Text(
                        "Forgot Password?",
                        style:
                            TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
