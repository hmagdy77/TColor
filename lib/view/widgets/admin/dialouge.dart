import '../../../libraries.dart';

myDialuge({
  required Function confirm,
  required Function cancel,
  required String title,
  required String middleText,
  Widget? content,
}) {
  return Get.defaultDialog(
    title: title,
    middleText: middleText,
    backgroundColor: Get.theme.primaryColor,
    buttonColor: Get.theme.scaffoldBackgroundColor,
    titleStyle: Get.textTheme.displayLarge,
    middleTextStyle: Get.textTheme.bodySmall,
    radius: 10,
    cancelTextColor: Get.theme.primaryColorLight,
    confirmTextColor: Get.theme.primaryColorLight,
    textConfirm: AppStrings.yes,
    textCancel: AppStrings.no,
    onConfirm: () {
      confirm();
    },
    onCancel: () {},
    content: content ?? Container(),
  );
}
