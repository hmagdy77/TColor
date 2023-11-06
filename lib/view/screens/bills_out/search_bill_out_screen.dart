import '../../../controllers/bill_out/bill_out_cart.dart';
import '../../../controllers/bill_out/bill_out_controller.dart';
import '../../../controllers/bill_out/bill_out_item_controller.dart';
import '../../../libraries.dart';
import '../../widgets/bills_in/bills_item.dart';
import '../../widgets/lottie/empty.dart';
import '../../widgets/menus/upper_widget.dart';

class SearchBillOutScreen extends StatelessWidget {
  SearchBillOutScreen({super.key});

  final BillOutControllerImp billOutController =
      Get.find<BillOutControllerImp>();
  final BillOutItemControllerImp billOutitemsController =
      Get.find<BillOutItemControllerImp>();
  final BillOutCartControllerImp cartController =
      Get.find<BillOutCartControllerImp>();
  @override
  Widget build(BuildContext context) {
    billOutController.billsOutSearchList.clear();
    return Scaffold(
      body: Obx(
        () {
          if (billOutController.isLoading.value ||
              billOutitemsController.isLoading.value ||
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
                            '${AppStrings.bills} ${AppStrings.billOut}',
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
                                controller:
                                    billOutController.billOutSearchController,
                                validate: (val) {},
                                label: AppStrings.search,
                                hint: '2000-01-01',
                                onChanged: (val) {
                                  billOutController.search(searchName: val);
                                },
                                onSubmite: (val) {
                                  billOutController.search(searchName: val);
                                },
                                hidePassword: false,
                              ),
                            ),
                            // for width
                          ],
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        Expanded(
                          child: Obx(
                            () {
                              if (billOutController.isLoading.value) {
                                return const MyLottieLoading();
                              } else {
                                if (billOutController
                                        .billsOutSearchList.isEmpty &&
                                    billOutController.billOutSearchController
                                        .text.isNotEmpty) {
                                  return const MyLottieEmpty();
                                } else {
                                  return ListView.separated(
                                    itemCount: billOutController
                                        .billsOutSearchList.length,
                                    separatorBuilder: (context, index) {
                                      return const Divider(
                                        thickness: 2,
                                      );
                                    },
                                    itemBuilder: (context, index) {
                                      var billOut = billOutController
                                          .billsOutSearchList.reversed
                                          .toList()[index];
                                      if (billOut.billItems == '0.0') {
                                        return Container();
                                      } else {
                                        return GestureDetector(
                                          onTap: () async {
                                            await billOutitemsController
                                                .getItemsByIndex(
                                              billId: billOut.billId.toString(),
                                            );
                                            await cartController.addAllToCarts(
                                              items: billOutitemsController
                                                  .billsOutItemsList,
                                            );
                                            // billOutController.billPayment.text =
                                            //     billOut.billPayment.toString();
                                            // billOutController.billNotes.text =
                                            //     billOut.billNotes.toString();
                                            Get.toNamed(
                                                AppRoutes.editBillOutScreen,
                                                arguments: [billOut]);
                                          },
                                          child: BillItem(
                                            bill: billOut,
                                            isBillIn: false,
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
      ),
    );
  }
}
