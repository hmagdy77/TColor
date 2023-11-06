import '../../../libraries.dart';

class MySnackBar {
  static SnackbarController snack(String title, String message) {
    return Get.rawSnackbar(
      margin: EdgeInsets.all(AppSizes.h2),
      titleText: Center(
        child: Text(
          message,
        ),
      ),
      messageText: Center(
        child: Text(
          title,
        ),
      ),
      backgroundColor: Get.theme.primaryColor,
      duration: const Duration(seconds: 2),
      borderRadius: 10,
    );
  }
}
