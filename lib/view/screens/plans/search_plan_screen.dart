import '../../../controllers/plans/plan_controller.dart';
import '../../../controllers/plans/plan_item_controller.dart';
import '../../../libraries.dart';
import '../../widgets/lottie/empty.dart';
import '../../widgets/menus/upper_widget.dart';
import '../../widgets/plans/plan_item_widget.dart';

class SearchPlanScreen extends StatelessWidget {
  SearchPlanScreen({super.key});
  //Plan
  final PlanControllerImp planController = Get.find<PlanControllerImp>();
  final PlanItemControllerImp planItemController =
      Get.find<PlanItemControllerImp>();

  @override
  Widget build(BuildContext context) {
    // planController.billsFactorySearchList.clear();
    return Scaffold(
      body: Obx(
        () {
          if (planController.isLoading.value ||
              planItemController.isLoading.value) {
            return const MyLottieLoading();
          } else {
            return Column(
              children: [
                UpperWidget(
                  isAdminScreen: false,
                  onPressed: () {},
                ),
                Expanded(
                  child: MyContainer(
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyTextField(
                          controller: planController.planSearchController,
                          validate: (val) {},
                          label: AppStrings.search,
                          hint: '2000-01-01',
                          onChanged: (val) {
                            planController.search(searchName: val);
                          },
                          onSubmite: (val) {
                            planController.search(searchName: val);
                          },
                          hidePassword: false,
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        Expanded(
                          child: Obx(
                            () {
                              if (planController.isLoading.value) {
                                return const MyLottieLoading();
                              } else {
                                if (planController.plansSearchList.isEmpty &&
                                    planController
                                        .planSearchController.text.isNotEmpty) {
                                  return const MyLottieEmpty();
                                } else {
                                  return ListView.separated(
                                    itemCount: planController.plansSearchList
                                        .toList()
                                        .length,
                                    separatorBuilder: (context, index) {
                                      return const Divider(
                                        thickness: 2,
                                      );
                                    },
                                    itemBuilder: (context, index) {
                                      var plan = planController
                                          .plansSearchList.reversed
                                          .toList()[index];
                                      if (plan.components == '0.0') {
                                        return const SizedBox();
                                      } else {
                                        return GestureDetector(
                                          onTap: () async {
                                            planItemController.getItemsByIndex(
                                              planId: plan.id.toString(),
                                            );
                                            Get.toNamed(
                                              AppRoutes.planDetailsScreen,
                                              arguments: [plan],
                                            );
                                          },
                                          child: PlanItemWidget(plan: plan),
                                        );
                                      }
                                    },
                                  );
                                }
                              }
                            },
                          ),
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
    );
  }
}
