import 'dart:math';

import '../../data/repo/users/users_repo.dart';
import '../../libraries.dart';
import '../../view/widgets/login/snackbar.dart';

class ConfigController extends GetxController {
  int serialGetnrated = 0;
  TextEditingController serial = TextEditingController();
  TextEditingController ip =
      TextEditingController(text: 'http://localhost/stock');

  MyService myService = Get.find();

  @override
  onInit() {
    super.onInit();
    saveGeratedSerial();
  }

  genrateSerialNumber() {
    Random random = Random();
    int fNumber = random.nextInt(1000000);
    int sNumber = random.nextInt(1000000);
    int tNumber = random.nextInt(1000000);
    serialGetnrated = fNumber + sNumber + tNumber;
  }

  saveGeratedSerial() async {
    myService.sharedPreferences.clear();
    var serial = myService.sharedPreferences.getInt(
      AppStrings.keySerialGenrate,
    );
    if (serial == null) {
      genrateSerialNumber();
      myService.sharedPreferences.setInt(
        AppStrings.keySerialGenrate,
        serialGetnrated,
      );
      await UsersRepo.serial(
        number: serialGetnrated.toString(),
      );
    }
  }

  checkSerial() {
    if (serial.text == serialGetnrated.toString()) {
      myService.sharedPreferences.setInt(
        AppStrings.keySerialEnterd,
        int.parse(serial.text),
      );
      setIpAdress();
      Get.offAllNamed(AppRoutes.splashScreen);
    } else {
      MySnackBar.snack(
        AppStrings.problem,
        '',
      );
    }
  }

  setIpAdress() {
    myService.sharedPreferences.setString(AppStrings.keyIpAddress, ip.text);
  }
}
