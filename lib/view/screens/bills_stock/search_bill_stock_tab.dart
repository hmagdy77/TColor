import '../../../controllers/bill_stock/bill_stock_cart.dart';
import '../../../controllers/bill_stock/bill_stock_controller.dart';
import '../../../controllers/bill_stock/bill_stock_items_controller.dart';
import '../../../libraries.dart';
import '../../widgets/bills_stock/bills_stock.dart';
import '../../widgets/drop_menu/drop_menu.dart';
import '../../widgets/lottie/empty.dart';

class SearchBillStockTab extends StatelessWidget {
  SearchBillStockTab({super.key});

  final BillStockControllerImp billStockController =
      Get.find<BillStockControllerImp>();
  final BillStockItemControllerImp billStockitemsController =
      Get.find<BillStockItemControllerImp>();
  final BillStockCartControllerImp cartController =
      Get.find<BillStockCartControllerImp>();
  @override
  Widget build(BuildContext context) {
    billStockController.billsStockSearchList.clear();
    return Obx(
      () {
        if (billStockController.isLoading.value ||
                cartController.isLoading.value ||
                billStockitemsController.isLoading.value
            // ||
            // cartController.isLoading.value
            ) {
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
                              controller:
                                  billStockController.billStockSearchController,
                              validate: (val) {},
                              label: AppStrings.search,
                              hint: '2000-01-01',
                              onChanged: (val) {
                                billStockController.search(searchName: val);
                              },
                              onSubmite: (val) {
                                billStockController.search(searchName: val);
                              },
                              hidePassword: false,
                            ),
                          ),
                          // for width
                          SizedBox(
                            width: AppSizes.w02,
                          ),
                          Text(
                            ' ${AppStrings.billStockKind} : ',
                            style: context.textTheme.displayMedium,
                          ),
                          Expanded(
                            child: MyDropMenu(
                              bodyItems: const [
                                AppStrings.exChange,
                                AppStrings.exChangeBack
                              ],
                              label: billStockController.selectedKind.value,
                              onChanged: (value) {
                                switch (value) {
                                  case AppStrings.exChange:
                                    billStockController.searchKind(kind: 1);
                                    break;
                                  case AppStrings.exChangeBack:
                                    billStockController.searchKind(kind: 2);
                                    break;
                                }
                                billStockController.selectedKind.value =
                                    value as String;
                                // print(supController.selectedSup.value.isNotEmpty);
                              },
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      Expanded(
                        child: Obx(
                          () {
                            if (billStockController.isLoading.value) {
                              return const MyLottieLoading();
                            } else {
                              if (billStockController
                                      .billsStockSearchList.isEmpty &&
                                  billStockController.billStockSearchController
                                      .text.isNotEmpty) {
                                return const MyLottieEmpty();
                              } else {
                                return ListView.separated(
                                  itemCount: billStockController
                                      .billsStockSearchList.length,
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                      thickness: 2,
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    var bill = billStockController
                                        .billsStockSearchList.reversed
                                        .toList()[index];
                                    if (bill.billItems == '0.0' ||
                                        bill.billItems == '0') {
                                      return Container();
                                    } else {
                                      return GestureDetector(
                                        onTap: () async {
                                          await billStockitemsController
                                              .getItemsByIndex(
                                                  bill.billId.toString());
                                          await cartController.addAllToCarts(
                                              items: billStockitemsController
                                                  .billsStockItemsList);
                                          Get.toNamed(
                                            AppRoutes.editBillStockScreen,
                                            arguments: [bill],
                                          );
                                        },
                                        child: BillStockItem(bill: bill),
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
