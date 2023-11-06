import '../../libraries.dart';

class MiddleWare extends GetMiddleware {
  MyService myService = Get.find();

  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    var gen = myService.sharedPreferences.getInt(AppStrings.keySerialGenrate);
    var enterd = myService.sharedPreferences.getInt(AppStrings.keySerialEnterd);
    if (gen != null && enterd != null && gen == enterd) {
      return const RouteSettings(
        name: AppRoutes.splashScreen,
      );
    }
    return null;
  }
}
