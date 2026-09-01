// ignore_for_file: library_private_types_in_public_api
import 'package:mobx/mobx.dart';
import 'package:core/core.dart';
import 'package:database/database.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final UserDao _userDao;
  final SecureStorageService _secureStorage;

  _AuthStore({
    required UserDao userDao,
    required SecureStorageService secureStorage,
  })  : _userDao = userDao,
        _secureStorage = secureStorage;

  @observable
  UserData? currentUser;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  bool isInitialized = false;

  @computed
  bool get isAuthenticated => currentUser != null;

  @computed
  bool get isOwner => currentUser?.role == 'owner';

  @action
  Future<void> initAuth() async {
    isLoading = true;
    errorMessage = null;
    try {
      final isLoggedIn = await _secureStorage.isLoggedIn();
      if (isLoggedIn) {
        final userId = await _secureStorage.getActiveUserId();
        if (userId != null) {
          currentUser = await _userDao.getUserById(userId);
        }
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      isInitialized = true;
    }
  }

  @action
  Future<bool> login(String usernameOrEmail, String password) async {
    isLoading = true;
    errorMessage = null;
    try {
      final user = await _userDao.getUserByUsername(usernameOrEmail) ??
          await _userDao.getUserByEmail(usernameOrEmail);

      if (user == null) {
        errorMessage = 'Pengguna tidak ditemukan';
        return false;
      }

      final isPasswordValid = PasswordHasher.verifyPassword(
        password,
        user.passwordHash,
        user.salt,
      );

      if (!isPasswordValid) {
        errorMessage = 'Password yang dimasukkan salah';
        return false;
      }

      currentUser = user;
      await _secureStorage.saveUserSession(
        userId: user.id,
        username: user.username,
        email: user.email,
        role: user.role,
      );
      return true;
    } catch (e) {
      errorMessage = 'Gagal masuk: ${e.toString()}';
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> register({
    required String username,
    required String email,
    required String password,
    required String fullname,
    required String role,
  }) async {
    isLoading = true;
    errorMessage = null;
    try {
      final existingUser = await _userDao.getUserByUsername(username);
      if (existingUser != null) {
        errorMessage = 'Username sudah digunakan';
        return false;
      }

      final existingEmail = await _userDao.getUserByEmail(email);
      if (existingEmail != null) {
        errorMessage = 'Email sudah terdaftar';
        return false;
      }

      final salt = PasswordHasher.generateSalt();
      final passwordHash = PasswordHasher.hashPassword(password, salt);

      final newUserId = await _userDao.insertUser(
        UsersCompanion(
          username: Value(username),
          email: Value(email),
          passwordHash: Value(passwordHash),
          salt: Value(salt),
          fullname: Value(fullname),
          role: Value(role),
        ),
      );

      final createdUser = await _userDao.getUserById(newUserId);
      currentUser = createdUser;

      await _secureStorage.saveUserSession(
        userId: newUserId,
        username: username,
        email: email,
        role: role,
      );
      return true;
    } catch (e) {
      errorMessage = 'Gagal mendaftar: ${e.toString()}';
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> logout() async {
    await _secureStorage.clearSession();
    currentUser = null;
  }

  @action
  Future<bool> hasAnyUsers() async {
    final count = await _userDao.countUsers();
    return count > 0;
  }
}
