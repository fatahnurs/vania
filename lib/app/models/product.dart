import 'package:vania/vania.dart';
import 'package:mysql1/mysql1.dart';

class Product extends Model{
    
  Product(){
    MySqlConnection.connect;
    super.table('products');
  }

}
