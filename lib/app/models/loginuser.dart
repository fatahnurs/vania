import 'package:mysql1/mysql1.dart';
import 'package:vania/vania.dart';

class Loginuser extends Model{
    
  Loginuser(){
    MySqlConnection.connect;
    super.table('loginuser');
  }

}
