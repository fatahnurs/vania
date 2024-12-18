import 'package:mysql1/mysql1.dart';
import 'package:vania/vania.dart';

class Todo extends Model{
    
  Todo(){
    MySqlConnection.connect;
    super.table('todos');
  }

}
