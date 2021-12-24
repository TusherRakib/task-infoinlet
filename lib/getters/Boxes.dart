import 'package:hive/hive.dart';
import 'package:task/models/profile_model.dart';

class Boxes{
  static Box<Person> getPersons() =>
      Hive.box<Person>('PersonDetails');
}