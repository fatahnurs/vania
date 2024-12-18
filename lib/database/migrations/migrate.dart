import 'dart:io';
import 'package:paml_serve/database/migrations/create_loginuser_table.dart';
import 'package:vania/vania.dart';
import 'create_users_table.dart';
import 'create_personal_access_tokens_table.dart';
import 'create_todos_table.dart';

void main(List<String> args) async {
  await MigrationConnection().setup();
  if (args.isNotEmpty && args.first.toLowerCase() == "migrate:fresh") {
    await Migrate().dropTables();
  } else {
    await Migrate().registry();
  }
  await MigrationConnection().closeConnection();
  exit(0);
}

class Migrate {
  registry() async {
		 await CreateUserTable().up();
		 await CreateLoginuserTable().up();
		 await CreatePersonalAccessTokensTable().up();
		 await CreateTodosTable().up();
	}

  dropTables() async {
		 await CreateTodosTable().down();
		 await CreatePersonalAccessTokensTable().down();
		 await CreateUserTable().down();
		 await CreateUserTable().down();
	 }
}
