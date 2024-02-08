import 'package:get_storage/get_storage.dart';

import '../core/services/cache_service.dart';

class GetStorageCacheService implements CacheService {
  @override
  Future<void> init() async => await GetStorage.init();

  @override
  Future<T?> getKey<T>(String key) async => GetStorage().read<T>(key);

  @override
  Future<T?> setKey<T>(String key, T? value) async {
    await GetStorage().write(key, value);
    return await getKey(key);
  }
}
