abstract class CacheService {
  Future<void> init();
  Future<T?> getKey<T>(String key);
  Future<T?> setKey<T>(String key, T? value);
}
