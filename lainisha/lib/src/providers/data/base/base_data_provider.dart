abstract class DataProvider {
  Future<List<T>> fetchList<T>(
    String resource, {
    int page = 1,
    int limit = 20,
  });
  Future<T> fetchOne<T>(String resource, String id);
  Future<T> create<T>(String resource, Map<String, dynamic> data);
  Future<T> update<T>(String resource, String id, Map<String, dynamic> data);
  Future<void> delete(String resource, String id);
}
