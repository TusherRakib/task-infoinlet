import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/models/profile_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task/getters/Boxes.dart';
import 'package:task/screens/SignIn_Screen.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {

  void deletePerson(Person person) {

    final box = Boxes.getPersons();
    box.delete(person.key);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignInScreen()));
  }

  Widget buildButtons(BuildContext context, Person person) => Expanded(
    child: TextButton.icon(
      label: Text('Sign Out'),
      icon: Icon(Icons.delete),
      onPressed: () => deletePerson(person),
    ),
  );

  Widget buildContent(List<Person> persons) {

    final username = persons.length == 0?  'null':
    persons.fold(0, (previousValue, person) => person.Username);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'UserName: $username',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        buildButtons(context, persons.last),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(automaticallyImplyLeading: false, title: Text("My Profile")),
      body: ValueListenableBuilder<Box<Person>>(
        valueListenable: Boxes.getPersons().listenable(),
        builder: (context, box, _) {
          final person = box.values.toList().cast<Person>();
          return Center(child: buildContent(person));
        },
      ),
    );
  }
}
