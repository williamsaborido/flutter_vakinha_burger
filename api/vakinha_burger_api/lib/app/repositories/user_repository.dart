import 'package:mysql1/mysql1.dart';
import 'package:vakinha_burger_api/app/core/exceptions/user_not_found.dart';
import 'package:vakinha_burger_api/app/core/helpers/crypt_helper.dart';
import '../core/database/database.dart';
import '../core/exceptions/email_already_registered.dart';
import '../entities/user.dart';

class UserRepository {
  Future<User> login(String user, String password) async {
    MySqlConnection? conn;
    try {
      conn = await Database().openConnection();
      final result = await conn.query(
        'SELECT * FROM usuario WHERE email = ? AND senha = ?',
        [
          user,
          CryptHelper.generatedSHA256Hash(password),
        ],
      );

      if (result.isEmpty) {
        throw UserNotFound();
      }

      final userData = result.first;

      return User(
        id: userData['id'],
        name: userData['nome'],
        email: userData['email'],
        password: userData['senha'],
      );
    } finally {
      await conn?.close();
    }
  }

  Future save(User user) async {
    MySqlConnection? conn;
    try {
      conn = await Database().openConnection();

      final isUserRegistered = await conn
          .query('SELECT * FROM usuario WHERE email = ?', [user.email]);

      if (isUserRegistered.isEmpty) {
        await conn.query('INSERT INTO usuario VALUES(?,?,?,?)', [
          null,
          user.name,
          user.email,
          CryptHelper.generatedSHA256Hash(user.password),
        ]);
      } else {
        throw EmailAlreadyRegistered();
      }
    } finally {
      await conn?.close();
    }
  }
}
