import '../../../controllers/factory/bill_factory_cart.dart';
import '../../../controllers/factory/bill_factory_controller.dart';
import '../../../controllers/factory/bill_factory_item_controller.dart';
import '../../../libraries.dart';
import '../../widgets/bills_factory/bill_factory_item.dart';
import '../../widgets/lottie/empty.dart';
import '../../widgets/menus/upper_widget.dart';

class SearchBillFactoryScreen extends StatelessWidget {
  SearchBillFactoryScreen({super.key});
  final BillFactoryControllerImp billFactoryController =
      Get.find<BillFactoryControllerImp>();
  final BillFactoryItemControllerImp billFactoryitemsController =
      Get.find<BillFactoryItemControllerImp>();
  final BillFactoryCartControllerImp cartController =
      Get.find<BillFactoryCartControllerImp>();
  @override
  Widget build(BuildContext context) {
    // billFactoryController.billsFactorySearchList.clear();
    return Scaffold(
      body: Obx(
        () {
          if (billFactoryController.isLoading.value ||
              billFactoryitemsController.isLoading.value ||
              cartController.isLoading.value) {
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
                        Center(
                          child: Text(
                            '${AppStrings.bills} ${AppStrings.theFactory}',
                            style: context.textTheme.titleSmall,
                          ),
                        ),
                        SizedBox(
                          height: AppSizes.h05,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: MyTextField(
                                controller: billFactoryController
                                    .billFactorySearchController,
                                validate: (val) {},
                                label: AppStrings.search,
                                hint: '2000-01-01',
                                onChanged: (val) {
                                  billFactoryController.search(searchName: val);
                                },
                                onSubmite: (val) {
                                  billFactoryController.search(searchName: val);
                                },
                                hidePassword: false,
                              ),
                            ),
                            // for width
                            SizedBox(
                              width: AppSizes.w02,
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        Expanded(
                          child: Obx(
                            () {
                              if (billFactoryController.isLoading.value) {
                                return const MyLottieLoading();
                              } else {
                                if (billFactoryController
                                        .billsFactorySearchList.isEmpty &&
                                    billFactoryController
                                        .billFactorySearchController
                                        .text
                                        .isNotEmpty) {
                                  return const MyLottieEmpty();
                                } else {
                                  return ListView.separated(
                                    itemCount: billFactoryController
                                        .billsFactorySearchList.length,
                                    separatorBuilder: (context, index) {
                                      return const Divider(
                                        thickness: 2,
                                      );
                                    },
                                    itemBuilder: (context, index) {
                                      var billFactory = billFactoryController
                                          .billsFactorySearchList[index];
                                      if (billFactory.billItems == '0.0') {
                                        return Container();
                                      } else {
                                        return GestureDetector(
                                          onTap: () async {
                                            await billFactoryitemsController
                                                .getItemsByIndex(
                                              billId:
                                                  billFactory.billId.toString(),
                                            );
                                            Get.toNamed(
                                                AppRoutes.viewBillFactoryScreen,
                                                arguments: [billFactory]);
                                          },
                                          child: BillFactoryItem(
                                              bill: billFactory),
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
                )
              ],
            );
          }
        },
      ),
    );
  }
}
