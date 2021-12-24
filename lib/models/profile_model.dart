import 'package:hive/hive.dart';

part 'profile_model.g.dart';


@HiveType(typeId: 0)

class Person extends HiveObject  {
  @HiveField(0)
  late String Username;
  @HiveField(1)
  late String Email;
  @HiveField(2)
  late String password;
}