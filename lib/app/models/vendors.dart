import 'package:mysql1/mysql1.dart';
import 'package:vania/vania.dart';


class Vendors extends Model{
  Vendors(){
    MySqlConnection.connect;
    super.table('vendors');
  }

}
