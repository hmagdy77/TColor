import '../../../controllers/bill_in/bill_in_cart.dart';
import '../../../controllers/bill_in/bill_in_controller.dart';
import '../../../controllers/bill_in/bill_in_item_controller.dart';
import '../../../controllers/supplires/sup_controller.dart';
import '../../../libraries.dart';
import '../../widgets/bills_in/bills_item.dart';
import '../../widgets/drop_menu/drop_menu.dart';
import '../../widgets/lottie/empty.dart';
import '../../widgets/menus/upper_widget.dart';

class SearchBillInScreen extends StatelessWidget {
  SearchBillInScreen({super.key});

  final BillInControllerImp billInController = Get.find<BillInControllerImp>();
  final SupControllerImp supController = Get.find<SupControllerImp>();
  final BillInItemControllerImp billInitemsController =
      Get.find<BillInItemControllerImp>();
  final BillInCartControllerImp cartController =
      Get.find<BillInCartControllerImp>();
  @override
  Widget build(BuildContext context) {
    billInController.billsInSearchList.clear();
    return Scaffold(
      body: Obx(
        () {
          if (billInController.isLoading.value ||
              supController.isLoading.value ||
              billInitemsController.isLoading.value ||
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
                            '${AppStrings.bills} ${AppStrings.billIn}',
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
                                    billInController.billInSearchController,
                                validate: (val) {},
                                label: AppStrings.search,
                                hint: '2000-01-01',
                                onChanged: (val) {
                                  billInController.search(searchName: val);
                                },
                                onSubmite: (val) {
                                  billInController.search(searchName: val);
                                },
                                hidePassword: false,
                              ),
                            ),
                            // for width
                            SizedBox(
                              width: AppSizes.w02,
                            ),
                            Text(
                              ' ${AppStrings.supName} : ',
                              style: context.textTheme.displayMedium,
                            ),
                            Expanded(
                              child: MyDropMenu(
                                bodyItems: supController.supListNames,
                                label: supController.selectedSup.value,
                                onChanged: (value) {
                                  billInController.search(
                                      searchName: value.toString());
                                  supController.selectedSup.value =
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
                              if (billInController.isLoading.value) {
                                return const MyLottieLoading();
                              } else {
                                if (billInController
                                        .billsInSearchList.isEmpty &&
                                    billInController.billInSearchController.text
                                        .isNotEmpty) {
                                  return const MyLottieEmpty();
                                } else {
                                  return ListView.separated(
                                    itemCount: billInController
                                        .billsInSearchList.length,
                                    separatorBuilder: (context, index) {
                                      return const Divider(
                                        thickness: 2,
                                      );
                                    },
                                    itemBuilder: (context, index) {
                                      var billIn = billInController
                                          .billsInSearchList.reversed
                                          .toList()[index];
                                      if (billIn.billItems == '0.0') {
                                        return Container();
                                      } else {
                                        return GestureDetector(
                                          onTap: () async {
                                            await billInitemsController
                                                .getItemsByIndex(
                                                    billIn.billId.toString());
                                            await cartController.addAllToCarts(
                                              items: billInitemsController
                                                  .billsInItemsList,
                                            );
                                            // billInController.billPayment.text =
                                            //     billIn.billPayment.toString();
                                            // billInController.billNotes.text =
                                            //     billIn.billNotes.toString();
                                            Get.toNamed(
                                                AppRoutes.editBillInScreen,
                                                arguments: [billIn]);
                                          },
                                          child: BillItem(
                                            bill: billIn,
                                            isBillIn: true,
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
