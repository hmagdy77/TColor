import '../../libraries.dart';

class ThemeController {
  final key = 'isDark';
  MyService myService = Get.find();

  void saveDataToBox(bool isDark) {
    myService.sharedPreferences.setBool(key, isDark);
  }

  bool getDataFromBox() => myService.sharedPreferences.getBool(key) ?? false;

  ThemeMode get getThemeMode =>
      getDataFromBox() ? ThemeMode.dark : ThemeMode.light;

  void changeTheme() {
    Get.changeThemeMode(getDataFromBox() ? ThemeMode.light : ThemeMode.dark);
    saveDataToBox(!getDataFromBox());
  }
}
