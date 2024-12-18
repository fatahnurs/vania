import 'package:mysql1/mysql1.dart';
import 'package:vania/vania.dart';

class PersonalAccessToken extends Model{
    
  PersonalAccessToken(){
    MySqlConnection.connect;
    super.table('personal_access_token');
  }

}
