
typedef ResultSet = List<Map<String, dynamic>>;

abstract class Database {
  Future<bool> open({required String username, required String password});
  Future<void> close();
  Future<void> init();
}
