import '../../../libraries.dart';
import '../widgets/login/snackbar.dart';
import '../widgets/text_fields/old_text_field.dart';

class SerialNumberScreen extends GetView<ConfigController> {
  SerialNumberScreen({Key? key}) : super(key: key);
  final ConfigController serialNumberController = Get.put(ConfigController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          const Spacer(),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Container(
                  padding: EdgeInsets.all(AppSizes.h1),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: AppColorManger.black,
                    ),
                  ),
                  child: Column(
                    children: [
                      OldTextField(
                        label: '',
                        hint: 'serial number...',
                        hidePassword: false,
                        validate: (v) {},
                        onSubmite: (v) {
                          controller.checkSerial();
                        },
                        controller: serialNumberController.serial,
                      ),
                      SizedBox(
                        height: AppSizes.h05,
                      ),
                      MyButton(
                        minWidth: AppSizes.w3,
                        text: AppStrings.confirm,
                        onPressed: () async {
                          if (serialNumberController.ip.text.isEmpty) {
                            MySnackBar.snack(AppStrings.ipAddress, '');
                          } else {
                            await controller.checkSerial();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
