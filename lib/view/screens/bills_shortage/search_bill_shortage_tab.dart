import '../../../controllers/bill_shortage/bill_shortage_cart.dart';
import '../../../controllers/bill_shortage/bill_shortage_controller.dart';
import '../../../controllers/bill_shortage/bill_shortage_item_controller.dart';
import '../../../libraries.dart';
import '../../widgets/bills_shortage/bill_shortage_item.dart';
import '../../widgets/drop_menu/drop_menu.dart';
import '../../widgets/lottie/empty.dart';

class SearchBillShortageTab extends StatelessWidget {
  SearchBillShortageTab({super.key});

  final BillShortageControllerImp billShortageController =
      Get.find<BillShortageControllerImp>();
  final BillShortageItemControllerImp billShortageitemsController =
      Get.find<BillShortageItemControllerImp>();
  final BillShortageCartControllerImp cartController =
      Get.find<BillShortageCartControllerImp>();
  @override
  Widget build(BuildContext context) {
    billShortageController.billsShortageSearchList.clear();
    return Obx(
      () {
        if (billShortageController.isLoading.value ||
            billShortageitemsController.isLoading.value ||
            cartController.isLoading.value) {
          return const MyLottieLoading();
        } else {
          return Column(
            children: [
              Expanded(
                child: MyContainer(
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: MyTextField(
                              controller: billShortageController
                                  .billShortageSearchController,
                              validate: (val) {},
                              label: AppStrings.search,
                              hint: '2000-01-01',
                              onChanged: (val) {
                                billShortageController.search(searchName: val);
                              },
                              onSubmite: (val) {
                                billShortageController.search(searchName: val);
                              },
                              hidePassword: false,
                            ),
                          ),
                          SizedBox(
                            width: AppSizes.h02,
                          ),
                          Text(
                            ' ${AppStrings.billKind} : ',
                            style: context.textTheme.displayMedium,
                          ),
                          Expanded(
                            child: MyDropMenu(
                              bodyItems: const [
                                AppStrings.billShortagePlus,
                                AppStrings.billShortageMinus
                              ],
                              label: billShortageController.kindLabel.value,
                              onChanged: (value) {
                                switch (value) {
                                  case AppStrings.billShortagePlus:
                                    billShortageController.searchKind(kind: 1);
                                    break;
                                  case AppStrings.billShortageMinus:
                                    billShortageController.searchKind(kind: 2);
                                    break;
                                }
                                billShortageController.kindLabel.value =
                                    value as String;
                                // print(supController.selectedSup.value.isNotEmpty);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AppSizes.h02,
                      ),
                      Expanded(
                        child: Obx(
                          () {
                            if (billShortageController.isLoading.value) {
                              return const MyLottieLoading();
                            } else {
                              if (billShortageController
                                      .billsShortageSearchList.isEmpty &&
                                  billShortageController
                                      .billShortageSearchController
                                      .text
                                      .isNotEmpty) {
                                return const MyLottieEmpty();
                              } else {
                                return ListView.separated(
                                  itemCount: billShortageController
                                      .billsShortageSearchList.length,
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                      thickness: 2,
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    var billShortage = billShortageController
                                        .billsShortageSearchList.reversed
                                        .toList()[index];
                                    if (billShortage.billItems == '0.0') {
                                      return Container();
                                    } else {
                                      return GestureDetector(
                                        onTap: () async {
                                          await billShortageitemsController
                                              .getItemsByIndex(
                                            billId:
                                                billShortage.billId.toString(),
                                          );
                                          await cartController.addAllToCarts(
                                            items: billShortageitemsController
                                                .billShortageItemsList,
                                          );
                                          Get.toNamed(
                                              AppRoutes.editBillShortageScreen,
                                              arguments: [billShortage]);
                                        },
                                        child: BillShortageItem(
                                          bill: billShortage,
                                        ),
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
    );
  }
}
