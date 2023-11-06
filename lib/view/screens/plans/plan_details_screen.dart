import 'package:intl/intl.dart';

import '../../../controllers/plans/plan_controller.dart';
import '../../../controllers/plans/plan_item_controller.dart';
import '../../../core/print/pdf_plan.dart';
import '../../../data/models/plans/plan_model.dart';
import '../../../libraries.dart';
import '../../widgets/admin/dialouge.dart';
import '../../widgets/menus/upper_widget.dart';
import '../../widgets/plans/plan_details.dart';
import '../../widgets/plans/wanted_item_widget.dart';

class PlanDetailsScreen extends StatelessWidget {
  PlanDetailsScreen({super.key});

  final PlanControllerImp planController = Get.find<PlanControllerImp>();
  final PlanItemControllerImp planItemController =
      Get.find<PlanItemControllerImp>();

  final Plans plan = Get.arguments[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (planItemController.isLoading.value ||
              planController.isLoading.value) {
            return const Center(
              child: MyLottieLoading(),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UpperWidget(isAdminScreen: false, onPressed: () {}),
                Expanded(
                  child: MyContainer(
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //plan id and date and numberOfitems
                        PlanDetails(plan: plan),
                        SizedBox(
                          height: AppSizes.h04,
                        ),
                        // middle Area
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Proudcts(
                                  planItemController: planItemController,
                                ),
                              ),
                              VerticalDivider(
                                thickness: 2,
                                color: AppColorManger.greyLight,
                              ),
                              Expanded(
                                child: Components(
                                  planItemController: planItemController,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            MyButton(
                              text: AppStrings.print,
                              minWidth: AppSizes.w3,
                              onPressed: printFunction,
                            ),
                            MyButton(
                              text: AppStrings.deletePlan,
                              minWidth: AppSizes.w3,
                              onPressed: () {
                                myDialuge(
                                    cancel: () {
                                      Get.back();
                                    },
                                    confirm: () async {
                                      await planController.deletePlan(
                                          id: plan.id.toString());
                                      await planItemController
                                          .deleteAllPlanItems(
                                        planId: plan.id.toString(),
                                      );
                                    },
                                    title: AppStrings.deletePlan,
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
        },
      ),
    );
  }

  void printFunction() {
    planController.itemsProd.clear();
    planController.itemsCom.clear();
    List itemsF = planItemController.planItemsProuducts;
    List itemsS = planItemController.planItemsWanted;
    for (int i = 0; i < itemsF.length; i++) {
      planController.itemsProd.add(
        [
          double.parse(itemsF[i].itemQuantWight).toStringAsFixed(2),
          double.parse(itemsF[i].itemDone).toStringAsFixed(2),
          double.parse(itemsF[i].itemCount).toStringAsFixed(2),
          itemsF[i].itemNum,
          itemsF[i].itemName,
        ],
      );
    }
    for (int i = 0; i < itemsS.length; i++) {
      planController.itemsCom.add(
        [
          double.parse(itemsS[i].itemUsed).toStringAsFixed(3),
          double.parse(itemsS[i].itemExchange).toStringAsFixed(3),
          double.parse(itemsS[i].itemCount).toStringAsFixed(3),
          itemsS[i].itemNum,
          itemsS[i].itemName,
        ],
      );
    }
    printPlan(
      billDate: DateFormat.yMMMMEEEEd('ar').format(plan.date),
      billNumber: '0',
      itemsF: planController.itemsProd,
      columsF: [
        AppStrings.wight,
        AppStrings.doneFactory,
        AppStrings.wanted,
        AppStrings.itemNum,
        AppStrings.itemName,
      ],
      columsS: [
        AppStrings.usedFactory,
        AppStrings.doneExchange,
        AppStrings.wanted,
        AppStrings.itemNum,
        AppStrings.itemName,
      ],
      itemsS: planController.itemsCom,
      label: '${AppStrings.planNumper} ${plan.id}',
      kind: '2',
      total: '0',
    );
  }
}

class Components extends StatelessWidget {
  const Components({super.key, required this.planItemController});
  final PlanItemControllerImp planItemController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.components,
          style: context.textTheme.titleSmall,
        ),
        WantedItemWidget(
          isHeader: true,
          isProudct: false,
          index: 0,
          inView: true,
        ),
        planItemController.planItemsWanted.isEmpty
            ? Text(
                AppStrings.emptyList,
                style: context.textTheme.titleSmall,
              )
            : Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return WantedItemWidget(
                      item: planItemController.planItemsWanted[index],
                      isHeader: false,
                      isProudct: false,
                      index: index,
                      inView: true,
                    );
                  },
                  itemCount: planItemController.planItemsWanted.length,
                ),
              ),
      ],
    );
  }
}

class Proudcts extends StatelessWidget {
  const Proudcts({super.key, required this.planItemController});
  final PlanItemControllerImp planItemController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.products,
          style: context.textTheme.titleSmall,
        ),
        WantedItemWidget(
          isHeader: true,
          isProudct: true,
          index: 0,
          inView: true,
        ),
        planItemController.planItemsProuducts.isEmpty
            ? Text(
                AppStrings.emptyList,
                style: context.textTheme.titleSmall,
              )
            : Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return WantedItemWidget(
                      item: planItemController.planItemsProuducts[index],
                      isHeader: false,
                      isProudct: true,
                      index: index,
                      inView: true,
                    );
                  },
                  itemCount: planItemController.planItemsProuducts.length,
                ),
              ),
      ],
    );
  }
}
