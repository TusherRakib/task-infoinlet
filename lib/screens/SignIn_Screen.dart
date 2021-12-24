import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/getters/Boxes.dart';
import 'package:task/models/profile_model.dart';
import 'package:task/screens/Profile_Screen.dart';
import 'package:task/screens/SignUp_Screen.dart';

class SignInScreen extends ConsumerStatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  signIn() async {
    if (formKey.currentState!.validate()) {
      //final scaffold = Scaffold.of(context);
      final box = Boxes.getPersons();
      final person = box.values.toList().cast<Person>();

      final email = person.fold(0, (previousValue, person) => person.Email);
      final userName =
      person.fold(0, (previousValue, person) => person.Username);
      final password =
      person.fold(0, (previousValue, person) => person.password);

      final Provider<String> valueProvider =Provider<String>((ref) {
        return userName.toString();
      });
      email == emailEditingController.text.toLowerCase()
          ? password == passwordEditingController.text
          ? {
        ref.read(valueProvider),
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ProfileScreen())),

      }
          : ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Enter a valid Password")))
          : ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Enter a valid Email")));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Column(
              children: [
                Container(
                    color: Colors.transparent,
                    height: 210,
                    width: 200,
                    child: Image(
                        image: AssetImage('assets/images/signIn_image.png'))),
                SizedBox(height: 70),
                Text(
                  'Welcome back',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val!)
                              ? null
                              : "Enter Correct email";
                        },
                        controller: emailEditingController,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black45, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black45, width: 1.0),
                            ),
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.black45)),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        validator: (val) {
                          return val!.isEmpty ? "Enter Correct Password" : null;
                        },
                        controller: passwordEditingController,
                        obscureText: true,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black45, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black45, width: 1.0),
                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.black45)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    signIn();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.blueGrey,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: Text(
                      "Log In",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                  ),
                ),
                SizedBox(height: 10.0),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dont Have an Account?',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signup_Screen()));
                        },
                        child: Text(
                          '  Register now!',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
