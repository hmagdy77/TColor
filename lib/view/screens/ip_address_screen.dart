import '../../controllers/ip/ip_controller.dart';
import '../../libraries.dart';
import '../widgets/menus/upper_widget.dart';

class IpAddressScreen extends StatelessWidget {
  IpAddressScreen({super.key});
  final IpAddressControllerImp ipController =
      Get.find<IpAddressControllerImp>();
  final MyService myService = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: ipController.ipAddressGlobalKey,
        child: Column(
          children: [
            UpperWidget(isAdminScreen: false, onPressed: () {}),
            Expanded(
              child: MyContainer(
                content: Column(
                  children: [
                    Text(
                      AppStrings.ipAddress,
                      style: context.textTheme.titleSmall,
                    ),
                    SizedBox(
                      height: AppSizes.h05,
                    ),
                    MyTextField(
                      controller: ipController.ipTextField,
                      validate: (val) {
                        return validInput(
                          max: 255,
                          min: 0,
                          type: AppStrings.validateAdmin,
                          val: val,
                        );
                      },
                      label: AppStrings.ipAddress,
                      hidePassword: false,
                    ),
                    SizedBox(
                      height: AppSizes.h05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MyButton(
                          text: AppStrings.edit,
                          onPressed: () {
                            ipController.changeIpAddress();
                          },
                        ),
                        MyButton(
                          text: 'Deactivate',
                          onPressed: () {
                            myService.sharedPreferences.clear();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
