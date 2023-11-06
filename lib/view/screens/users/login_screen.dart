import '../../../controllers/users/users_controller.dart';
import '../../../libraries.dart';
import '../../widgets/text_fields/old_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final UsersControllerImp loginController = Get.find<UsersControllerImp>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: loginController.loginKey,
        child: Obx(
          () {
            if (loginController.isLoading.value) {
              return const Center(child: MyLottieLoading());
            } else {
              return Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                  horizontal: AppSizes.w4,
                  vertical: AppSizes.w15,
                ),
                padding: EdgeInsets.all(
                  AppSizes.w05,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.h03),
                  border: Border.all(
                    color: AppColorManger.black,
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Text(AppStrings.logIn, style: context.textTheme.titleSmall),
                    SizedBox(
                      height: AppSizes.h05,
                    ),
                    OldTextField(
                      controller: loginController.userName,
                      sufIcon:
                          Icon(Icons.email, color: context.theme.primaryColor),
                      keyboard: TextInputType.emailAddress,
                      label: AppStrings.userName,
                      validate: (val) {
                        return validInput(
                          max: 80,
                          min: 3,
                          type: AppStrings.validateAdmin,
                          val: val,
                        );
                      },
                      hidePassword: false,
                      onSubmite: (value) async {
                        await loginController.login();
                      },
                    ),
                    SizedBox(
                      height: AppSizes.h03,
                    ),
                    GetBuilder<UsersControllerImp>(
                      builder: (_) {
                        return OldTextField(
                          controller: loginController.password,
                          label: AppStrings.password.tr,
                          hidePassword: loginController.isShown,
                          sufIcon: Icon(Icons.lock,
                              color: context.theme.primaryColor),
                          keyboard: TextInputType.emailAddress,
                          preIcon: IconButton(
                            onPressed: () {
                              loginController.showPassword();
                            },
                            icon: loginController.isShown
                                ? const Icon(
                                    Icons.visibility,
                                    color: AppColorManger.primary,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: AppColorManger.primary,
                                  ),
                          ),
                          validate: (val) {
                            return validInput(
                              max: 80,
                              min: 3,
                              type: AppStrings.validateAdmin,
                              val: val,
                            );
                          },
                          onSubmite: (value) async {
                            await loginController.login();
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: AppSizes.h05,
                    ),
                    MyButton(
                      text: AppStrings.logIn,
                      onPressed: () async {
                        await loginController.login();
                      },
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
