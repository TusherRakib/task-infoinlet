import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task/getters/Boxes.dart';
import 'package:task/models/profile_model.dart';
import 'package:task/screens/SignIn_Screen.dart';

class Signup_Screen extends StatefulWidget {
  const Signup_Screen({Key? key}) : super(key: key);

  @override
  _Signup_ScreenState createState() => _Signup_ScreenState();
}

class _Signup_ScreenState extends State<Signup_Screen> {


  final List<Person> person_list = [];

  @override
  void dispose(){
    Hive.close();
    super.dispose();
  }

  var username;
  var email;
  var password;

  TextEditingController usernameEditingController = new TextEditingController();
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  signUp() async {
    if(formKey.currentState!.validate()){
      final person = Person()
        ..Username = usernameEditingController.text
        ..Email = emailEditingController.text.toLowerCase()
        ..password = passwordEditingController.text;

      setState(() {
        person_list.add(person);
      });
      final box = Boxes.getPersons();
      box.add(person);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );

      print(box.path);
      box.values.forEach((element) {
        print(element.Email.toString());
        print(element.Username.toString());
        print(element.password.toString());
      });
      print(box.values.lastWhere((element) => element.Email.isNotEmpty || element.Email.isEmpty).toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  validator:  (val){
                    return val!.isEmpty? "Enter a username" : null;
                  },
                  controller: usernameEditingController,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black45, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black45, width: 1.0),
                      ),
                      labelText: 'Username',labelStyle: TextStyle(color: Colors.black45)),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  validator: (val){
                    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!) ?
                    null : "Enter an email";
                  },
                  controller: emailEditingController,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black45, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black45, width: 1.0),
                      ),
                      labelText: 'Email',labelStyle: TextStyle(color: Colors.black45)),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  validator:  (val){
                    return val!.isEmpty? "Enter a Password" : null;
                  },
                  controller: passwordEditingController,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black45, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black45, width: 1.0),
                      ),
                      labelText: 'Password',labelStyle: TextStyle(color: Colors.black45)),
                ),
                SizedBox(
                  height: 15.0,
                ),
                ElevatedButton(
                    onPressed: () {
                      signUp();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xff206bc4),
                        fixedSize: Size(MediaQuery.of(context).size.width,MediaQuery.of(context).size.height/16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text('Sign Up',style: TextStyle(),)
                ),
                SizedBox(height: 25.0,),
                Container(
                  child: Text('Already have an account?'),
                ),
                SizedBox(height: 10.0,),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignInScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xff206bc4),
                        fixedSize: Size(MediaQuery.of(context).size.width,MediaQuery.of(context).size.height/16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text('Sign In')
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
