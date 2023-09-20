abstract class IApiService<T> {
  Future<T> fetchDataFromApi();
}
