import '../../../controllers/supplires/sup_controller.dart';
import '../../../libraries.dart';
import '../../widgets/menus/upper_widget.dart';

class AddSupScreen extends StatelessWidget {
  AddSupScreen({super.key});

  final SupControllerImp supController = Get.find<SupControllerImp>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: supController.addSupKey,
        child: Obx(
          () {
            if (supController.isLoading.value) {
              return const MyLottieLoading();
            } else {
              return Column(
                children: [
                  UpperWidget(isAdminScreen: false, onPressed: () {}),
                  Expanded(
                    child: MyContainer(
                      content: Column(
                        children: [
                          Text(
                            AppStrings.addSup,
                            style: context.textTheme.titleSmall,
                          ),
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: MyTextField(
                                  controller: supController.name,
                                  validate: (val) {
                                    return validInput(
                                      max: 50,
                                      min: 0,
                                      type: AppStrings.validateAdmin,
                                      val: val,
                                    );
                                  },
                                  label: AppStrings.supName,
                                  hidePassword: false,
                                ),
                              ),
                              SizedBox(
                                width: AppSizes.w1,
                              ),
                              Expanded(
                                child: MyTextField(
                                  controller: supController.tel,
                                  validate: (val) {
                                    return validInput(
                                      max: 50,
                                      min: 0,
                                      type: AppStrings.validateAdminNum,
                                      val: val,
                                    );
                                  },
                                  label: AppStrings.supTel,
                                  hidePassword: false,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          MyButton(
                            // minWidth: true,
                            text: AppStrings.addSup,
                            onPressed: () async {
                              await supController.addSup();
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
