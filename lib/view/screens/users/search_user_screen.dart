import '../../../controllers/users/users_controller.dart';
import '../../../libraries.dart';
import '../../widgets/lottie/empty.dart';
import '../../widgets/menus/upper_widget.dart';
import '../../widgets/users/user_widget.dart';

class SearchUserScreen extends StatelessWidget {
  SearchUserScreen({super.key});
  final UsersControllerImp editUserController = Get.put(UsersControllerImp());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UpperWidget(isAdminScreen: false, onPressed: () {}),
          Expanded(
            child: MyContainer(
              content: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: MyTextField(
                          controller: editUserController.searchController,
                          validate: (val) {},
                          label: AppStrings.search,
                          onChanged: (val) {
                            editUserController.search(val);
                          },
                          onSubmite: (val) {
                            editUserController.search(val);
                          },
                          hidePassword: false,
                        ),
                      ),
                      MyButton(
                        text: AppStrings.add,
                        onPressed: () {
                          Get.offAllNamed(AppRoutes.addUserScreen);
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: AppSizes.h05,
                  ),
                  Expanded(
                    child: Obx(
                      () {
                        if (editUserController.isLoading.value) {
                          return const MyLottieLoading();
                        } else {
                          if (editUserController.searchUsersList.isEmpty &&
                              editUserController
                                  .searchController.text.isNotEmpty) {
                            return const MyLottieEmpty();
                          } else {
                            return ListView.separated(
                              itemCount:
                                  editUserController.searchUsersList.length,
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  thickness: 2,
                                );
                              },
                              itemBuilder: (context, index) {
                                var user =
                                    editUserController.searchUsersList[index];
                                return GestureDetector(
                                  onTap: () {
                                    editUserController.userName.text =
                                        user.userName;
                                    editUserController.password.text =
                                        user.userPassword;
                                    editUserController.name.text = user.name;
                                    Get.offAndToNamed(
                                      AppRoutes.editUserScreen,
                                      arguments: [user],
                                    );
                                  },
                                  child: UserWidget(
                                    user: user,
                                  ),
                                );
                              },
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
