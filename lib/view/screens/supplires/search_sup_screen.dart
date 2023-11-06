import '../../../controllers/supplires/sup_controller.dart';
import '../../../libraries.dart';
import '../../widgets/lottie/empty.dart';
import '../../widgets/menus/upper_widget.dart';
import '../../widgets/sup/sup_widget.dart';

class SearchSupScreen extends StatelessWidget {
  SearchSupScreen({super.key});
  final SupControllerImp supController = Get.find<SupControllerImp>();
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
                          onChanged: (val) {
                            supController.search(val);
                          },
                          onSubmite: (val) {
                            supController.search(val);
                          },
                          hidePassword: false,
                        ),
                      ),
                      SizedBox(
                        width: AppSizes.w05,
                      ),
                      MyButton(
                        text: AppStrings.addSup,
                        onPressed: () {
                          Get.offAllNamed(AppRoutes.addSupScreen);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppSizes.h05,
                  ),
                  Expanded(
                    child: Obx(
                      () {
                        if (supController.isLoading.value) {
                          return const MyLottieLoading();
                        } else {
                          if (supController.searchSupList.isEmpty &&
                              supController.name.text.isNotEmpty) {
                            return const MyLottieEmpty();
                          } else {
                            return ListView.separated(
                              itemCount: supController.searchSupList.length,
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  thickness: 2,
                                );
                              },
                              itemBuilder: (context, index) {
                                var sup = supController.searchSupList[index];
                                return GestureDetector(
                                  onTap: () {
                                    supController.name.text = sup.supName;
                                    supController.tel.text = sup.supTel;
                                    Get.offAndToNamed(
                                      AppRoutes.editSupScreen,
                                      arguments: [sup],
                                    );
                                  },
                                  child: MySupWidget(
                                    sup: sup,
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
