import 'package:mvvm_provider/commum_utils/podos/users.dart';

// Sebuah kelas Abstrak di Dart didefinisikan untuk kelas-kelas yang mengandung satu
// atau lebih dari satu metode abstrak (metode tanpa implementasi) di dalamnya.
// Sedangkan untuk mendeklarasikan kelas abstrak kita menggunakan kata kunci abstrak .
// Jadi, harus dicatat bahwa kelas yang dideklarasikan abstrak mungkin atau
// mungkin tidak menyertakan metode abstrak tetapi jika itu menyertakan metode
// abstrak maka itu harus kelas abstrak. Fitur Kelas Abstrak:

abstract class UserRepository {
  Future<List<User>> getData({bool start = true});
  Future<User> getDataByID(String idUser);
  Future<String> save(User user);
  Future<String> delete(String id);
}
