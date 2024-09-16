/// An abstract class defining the contract for data providers.
/// 
/// Data providers are responsible for fetching, creating, updating, and
/// deleting resources from a data source.
abstract class DataProvider {
  /// Fetches a list of items from the specified resource.
  ///
  /// [T] represents the type of the items in the list.
  /// [resource] is the name of the resource to fetch from.
  /// [page] specifies the page number for pagination, defaults to 1.
  /// [limit] specifies the number of items per page, defaults to 20.
  Future<List<T>> fetchList<T>(
    String resource, {
    int page = 1,
    int limit = 20,
  });

  /// Fetches a single item from the specified resource.
  ///
  /// [T] represents the type of the item.
  /// [resource] is the name of the resource to fetch from.
  /// [id] is the identifier of the item to fetch.
  Future<T> fetchOne<T>(String resource, String id);

  /// Creates a new item in the specified resource.
  ///
  /// [T] represents the type of the newly created item.
  /// [resource] is the name of the resource to create the item in.
  /// [data] is a map of the item properties to be created.
  Future<T> create<T>(String resource, Map<String, dynamic> data);

  /// Updates an existing item in the specified resource.
  ///
  /// [T] represents the type of the updated item.
  /// [resource] is the name of the resource to update the item in.
  /// [id] is the identifier of the item to update.
  /// [data] is a map of the properties to update.
  Future<T> update<T>(String resource, String id, Map<String, dynamic> data);

  /// Deletes an item from the specified resource.
  ///
  /// [resource] is the name of the resource to delete the item from.
  /// [id] is the identifier of the item to delete.
  Future<void> delete(String resource, String id);
}
