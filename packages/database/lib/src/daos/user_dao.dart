import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/users_table.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [Users])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(super.db);

  Future<List<UserData>> getAllUsers() => select(users).get();

  Stream<List<UserData>> watchAllUsers() => select(users).watch();

  Future<UserData?> getUserById(int id) =>
      (select(users)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  Future<UserData?> getUserByUsername(String username) =>
      (select(users)..where((tbl) => tbl.username.equals(username))).getSingleOrNull();

  Future<UserData?> getUserByEmail(String email) =>
      (select(users)..where((tbl) => tbl.email.equals(email))).getSingleOrNull();

  Future<int> insertUser(UsersCompanion user) => into(users).insert(user);

  Future<bool> updateUser(UserData user) => update(users).replace(user);

  Future<int> deleteUser(int id) =>
      (delete(users)..where((tbl) => tbl.id.equals(id))).go();

  Future<int> countUsers() async {
    final countExp = users.id.count();
    final query = selectOnly(users)..addColumns([countExp]);
    return await query.map((row) => row.read(countExp)).getSingle() ?? 0;
  }
}
