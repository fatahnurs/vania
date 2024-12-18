import 'package:mysql1/mysql1.dart';
import 'package:vania/vania.dart';


class User extends Model {
  User() {
    MySqlConnection.connect;
    super.table('customer');
  }
}

