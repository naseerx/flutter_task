import 'package:get_it/get_it.dart';
import 'package:task/api_resources/api_services/api_services.dart';


GetIt getIt = GetIt.instance;

class DI {
  static Future<void> initDI() async {
    getIt.registerLazySingleton<ApiServices>(() => ApiServices());

    await getIt.allReady();
  }
}
