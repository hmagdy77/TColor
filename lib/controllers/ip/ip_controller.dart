import '../../libraries.dart';
import '../../view/widgets/login/snackbar.dart';

class IpAddressControllerImp extends GetxController {
  late TextEditingController ipTextField;
  MyService myService = Get.find();
  GlobalKey<FormState> ipAddressGlobalKey = GlobalKey<FormState>();
  String ipAddress = '';
  @override
  void onInit() {
    ipTextField = TextEditingController();
    getIpAdress();
    super.onInit();
  }

  @override
  void dispose() {
    ipTextField.dispose();
    super.dispose();
  }

  getIpAdress() {
    // ipAddress = myService.sharedPreferences.getString(AppStrings.keyIpAddress)!;
    String? ip = myService.sharedPreferences.getString(AppStrings.keyIpAddress);
    if (ip == null) {
      // Get.offAllNamed(AppRoutes.ipAddressScreen);
      ipTextField.text = ipAddress = 'http://192.168.1.100/stock';
    } else {
      ipTextField.text = ipAddress = ip;
    }
  }

  changeIpAddress() {
    myService.sharedPreferences.setString(
      AppStrings.keyIpAddress,
      ipTextField.text,
    );
    MySnackBar.snack(AppStrings.done, ' ');
  }
}
