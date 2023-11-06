import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../libraries.dart';

class MyService extends GetxService {
  late SharedPreferences sharedPreferences;

  Future<MyService> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }
}

initialService() async {
  await Get.putAsync(() => MyService().init());
  initializeDateFormatting();
}
