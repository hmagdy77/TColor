import '../../../controllers/users/users_controller.dart';
import '../../../libraries.dart';
import '../../widgets/drop_menu/drop_menu.dart';
import '../../widgets/login/snackbar.dart';
import '../../widgets/menus/upper_widget.dart';

class AddUserScreen extends StatelessWidget {
  AddUserScreen({super.key});
  final UsersControllerImp userController = Get.find<UsersControllerImp>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: userController.addUserKey,
        child: Obx(
          () {
            if (userController.isLoading.value) {
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
                            AppStrings.addUser,
                            style: context.textTheme.titleSmall,
                          ),
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: MyTextField(
                                  controller: userController.userName,
                                  validate: (val) {
                                    return validInput(
                                      max: 50,
                                      min: 0,
                                      type: AppStrings.validateAdmin,
                                      val: val,
                                    );
                                  },
                                  label: AppStrings.userName,
                                  hidePassword: false,
                                ),
                              ),
                              SizedBox(
                                width: AppSizes.w1,
                              ),
                              Expanded(
                                child: MyTextField(
                                  controller: userController.password,
                                  validate: (val) {
                                    return validInput(
                                      max: 50,
                                      min: 0,
                                      type: AppStrings.validateAdmin,
                                      val: val,
                                    );
                                  },
                                  label: AppStrings.password,
                                  hidePassword: false,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: MyTextField(
                                  controller: userController.name,
                                  validate: (val) {
                                    return validInput(
                                      max: 50,
                                      min: 0,
                                      type: AppStrings.validateAdmin,
                                      val: val,
                                    );
                                  },
                                  label: AppStrings.name,
                                  hidePassword: false,
                                ),
                              ),
                              SizedBox(
                                width: AppSizes.w1,
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      AppStrings.primison,
                                      style: context.textTheme.displayLarge,
                                    ),
                                    Expanded(
                                      child: MyDropMenu(
                                        bodyItems: const [
                                          AppStrings.allPrimisons,
                                          AppStrings.billIn,
                                          AppStrings.theFactory,
                                          AppStrings.stock,
                                        ],
                                        label: userController
                                            .selectedPrimison.value,
                                        onChanged: (value) {
                                          userController
                                              .selectedPrimison.value = value!;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          MyButton(
                            // minWidth: true,
                            text: AppStrings.add,
                            onPressed: () async {
                              if (userController.selectedPrimison.isEmpty) {
                                MySnackBar.snack(
                                    AppStrings.mustChoseprimison, '');
                              } else {
                                switch (userController.selectedPrimison.value) {
                                  case AppStrings.allPrimisons:
                                    await userController.addUser(kind: '1');
                                    break;
                                  case AppStrings.billIn:
                                    await userController.addUser(kind: '2');
                                    break;
                                  case AppStrings.theFactory:
                                    await userController.addUser(kind: '3');
                                    break;
                                  case AppStrings.stock:
                                    await userController.addUser(kind: '4');
                                    break;
                                }
                              }
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
