import 'package:hive/hive.dart';

class User {
  String name;

  User(this.name);

  @override
  String toString() => name; // Just for print()
}
// Can be generated automatically
class UserAdapter extends TypeAdapter<User> {
  @override
  final typeId = 0;

  @override
  User read(BinaryReader reader) {
    return User(reader.read());
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer.write(obj.name);
  }}