import '../../../controllers/users/users_controller.dart';
import '../../../data/models/users/user_model.dart';
import '../../../libraries.dart';
import '../../widgets/admin/dialouge.dart';
import '../../widgets/menus/upper_widget.dart';

class EditUserScreen extends StatelessWidget {
  EditUserScreen({super.key});

  final User user = Get.arguments[0];

  final UsersControllerImp editUserController = Get.find<UsersControllerImp>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: editUserController.editUserKey,
      child: Obx(() {
        if (editUserController.isLoading.value) {
          return const Center(
            child: MyLottieLoading(),
          );
        } else {
          return Column(
            children: [
              UpperWidget(
                isAdminScreen: true,
                onPressed: () {
                  Get.offAllNamed(AppRoutes.searchUserScreen);
                },
              ),
              Expanded(
                child: MyContainer(
                  content: ListView(
                    children: [
                      //edit users label
                      Text(
                        AppStrings.editUsers,
                        style: context.textTheme.titleSmall,
                      ),
                      //for height
                      SizedBox(
                        height: AppSizes.h05,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            '${AppStrings.idNumber} : ${user.userId}',
                            style: context.textTheme.bodyLarge,
                          ),
                          user.userKind == 1
                              ? Text(
                                  '${AppStrings.primison} : ${AppStrings.manger}',
                                  style: context.textTheme.bodyLarge,
                                )
                              : user.userKind == 1
                                  ? Text(
                                      '${AppStrings.primison} : ${AppStrings.supManger}',
                                      style: context.textTheme.bodyLarge,
                                    )
                                  : Text(
                                      '${AppStrings.primison} : ${AppStrings.employ}',
                                      style: context.textTheme.bodyLarge,
                                    ),
                        ],
                      ),
                      //for height
                      SizedBox(
                        height: AppSizes.h05,
                      ),

                      //textfields
                      Row(
                        children: [
                          Expanded(
                            child: MyTextField(
                              controller: editUserController.userName,
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
                              controller: editUserController.password,
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
                      //for height
                      SizedBox(
                        height: AppSizes.h05,
                      ),
                      MyTextField(
                        controller: editUserController.name,
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MyButton(
                            text: AppStrings.edit,
                            onPressed: () async {
                              await editUserController.editUser(
                                  userId: user.userId.toString());
                            },
                          ),
                          MyButton(
                            // minWidth: true,
                            text: AppStrings.delete,
                            onPressed: () {
                              myDialuge(
                                  cancel: () {
                                    Get.back();
                                  },
                                  confirm: () async {
                                    await editUserController.deleteUser(
                                        userId: user.userId.toString());
                                  },
                                  title: AppStrings.deleteUser,
                                  middleText: '');
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      }),
    ));
  }
}
