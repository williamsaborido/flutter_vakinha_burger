import 'package:dotenv/dotenv.dart';
import 'package:mysql1/mysql1.dart';

class Database {
  Future<MySqlConnection> openConnection() async {
    return await MySqlConnection.connect(
      ConnectionSettings(
        host: env['DATABASE_HOST'] ?? env['databaseHost'] ?? '',
        db: env['DATABASE_NAME'] ?? env['databaseName'] ?? '',
        password: env['DATABASE_PASSWORD'] ?? env['databasePassword'] ?? '',
        port: int.tryParse(env['DATABASE_PORT'] ?? env['databasePort'] ?? '') ??
            3306,
        user: env['DATABASE_USER'] ?? env['databaseUser'] ?? '',
      ),
    );
  }
}
