import 'package:intl/intl.dart';

import '../../data/models/bills/bill_model.dart';
import '../../data/repo/bill_in/bill_in_repo.dart';
import '../../libraries.dart';
import '../../view/widgets/login/snackbar.dart';

abstract class BillInController extends GetxController {
  addBillIn();
  saveBillIn({
    required String sup,
    required String id,
    required String total,
    required String numberOfItems,
    required String kind,
  });
  setBillDate({required context});
  getDate({required context, required bool start, required bool end});
  editBillIn(
      {required String sup,
      required String id,
      required String total,
      required String numberOfItems});
  getBillsIn();
  search({required String searchName});
  deleteBill({required String billId});
  // getBillsInSum({required int kind});
  // getBillsInPaymentSum({required int kind});
}

class BillInControllerImp extends BillInController {
  late TextEditingController billInSearchController;
  late TextEditingController billPayment;
  late TextEditingController billNotes;
  bool isShown = true;
  var isLoading = false.obs;
  List<Bill> billsInList = <Bill>[].obs;
  List<Bill> billsInSearchList = <Bill>[].obs;
  List<Bill> billsInListReversed = <Bill>[].obs;
  List<Bill> billsInDateList = <Bill>[].obs;
  MyService myService = Get.find();
  var now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');
  var startDate = ''.obs;
  var endDate = ''.obs;
  var billDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  var date = DateTime.now().obs;
  var billsStockTotal = 0.obs;
  var billsbackTotal = 0.obs;
  var billsStockPayment = 0.obs;
  var billsbackPayment = 0.obs;

  @override
  void onInit() {
    billInSearchController = TextEditingController();
    billPayment = TextEditingController();
    billNotes = TextEditingController();
    getBillsIn();
    super.onInit();
  }

  @override
  void dispose() {
    billInSearchController.dispose();
    billPayment.dispose();
    billNotes.dispose();
    super.dispose();
  }

  @override
  addBillIn() async {
    isLoading.value = true;
    var addBillIn = await BillsInRepo.addBillIn();
    try {
      if (addBillIn.status == "suc") {
        isLoading(false);
        update();
      } else if (addBillIn.status == "fail") {
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  saveBillIn({
    required String sup,
    required String id,
    required String total,
    required String numberOfItems,
    required String kind,
  }) async {
    isLoading.value = true;
    try {
      var saveBillIn = await BillsInRepo.saveBillIn(
        sup: sup,
        kind: kind,
        id: id,
        billNotes: billNotes.text,
        billTotal: double.parse(total).toString(),
        numberOfItems: numberOfItems,
        billDate: billDate.value.isEmpty
            ? '${formatter.format(now)} ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}'
            : '${billDate.value.toString()} ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}',
      );
      if (saveBillIn.status == "suc") {
        if (kind == '1') {
          Get.offNamed(
            AppRoutes.loadingScreen,
            arguments: [
              AppRoutes.addBillInScreen,
              () {
                getBillsIn();
              },
            ],
          );
        } else {
          Get.offNamed(
            AppRoutes.loadingScreen,
            arguments: [
              AppRoutes.addBackBillInScreen,
              () {
                getBillsIn();
              },
            ],
          );
        }
        isLoading(false);
        update();
      } else if (saveBillIn.status == "fail") {
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  setBillDate({required context}) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      // locale: const Locale('ar'),
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        } else {
          billDate.value = formatter.format(pickedDate);
          date.value = pickedDate;
        }
      },
    );
  }

  @override
  getDate({required context, required bool start, required bool end}) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      locale: const Locale('ar'),
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        if (start) {
          startDate.value = formatter.format(pickedDate);
        } else if (end) {
          endDate.value = formatter.format(pickedDate);
        }
      },
    );
  }

  @override
  editBillIn({
    required String sup,
    required String id,
    required String total,
    required String numberOfItems,
  }) async {
    try {
      isLoading.value = true;
      var editBillIn = await BillsInRepo.editBillIn(
        id: id,
        sup: sup,
        billTotal: double.parse(total).toString(),
        billNotes: billNotes.text,
        billPayment: billPayment.text.toString(),
        numberOfItems: numberOfItems,
      );

      if (editBillIn.status == "suc") {
        Get.offNamed(
          AppRoutes.loadingScreen,
          arguments: [
            AppRoutes.searchBillInScreen,
            () {},
          ],
        );
        isLoading(false);
        update();
      } else if (editBillIn.status == "fail") {
        Get.offNamed(
          AppRoutes.loadingScreen,
          arguments: [
            AppRoutes.searchBillInScreen,
            () {},
          ],
        );
        MySnackBar.snack(AppStrings.noitemsEdited, '');
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  getBillsIn() async {
    billsInList.clear();
    billsInListReversed.clear();
    isLoading(true);
    var billIn = await BillsInRepo.getBillsIn();
    try {
      if (billIn.status == 'fail') {
        isLoading(false);
        update();
      } else if (billIn.status == 'suc') {
        isLoading(false);
        billsInList.addAll(billIn.data);
        billsInListReversed = billsInList.reversed.toList();
        update();
      }
    } catch (_) {}
  }

  @override
  void search({required String searchName}) {
    isLoading(true);
    searchName = searchName.toLowerCase();
    billsInSearchList = billsInList.where(
      (bill) {
        var supName = bill.billSup;
        var billId = bill.billId.toString();
        var billTotal = bill.billTotal.toString();
        var date = bill.billTimestamp.toString();
        var notes = bill.billNotes.toString();
        return supName.contains(searchName) ||
            billId.contains(searchName) ||
            billTotal.contains(searchName) ||
            date.contains(searchName) ||
            notes.contains(searchName);
      },
    ).toList();
    isLoading(false);
    update();
  }

  @override
  deleteBill({required String billId}) async {
    isLoading(true);
    var item = await BillsInRepo.deleteBillIn(billId: billId);
    if (item.status == 'suc') {
      isLoading(false);
      Get.offAndToNamed(
        AppRoutes.loadingScreen,
        arguments: [
          AppRoutes.searchBillInScreen,
          () {},
        ],
      );
      update();
    } else if (item.status == 'fail') {
      MySnackBar.snack(AppStrings.problem, '');
      isLoading(false);
      update();
    }
  }

  // @override
  // getBillsInSum({required int kind}) async {
  //   try {
  //     var getSum = await Crud.postRequest(
  //       Api.apiGetBillsInDate,
  //       {
  //         'start_date': '${startDate.value.toString()} 00:00:00',
  //         'end_date': '${endDate.value.toString()} 23:59:00',
  //         'is_back': kind.toString(),
  //       },
  //       sumBillTotalModelFromJson,
  //     );
  //     if (getSum.status == 'fail') {
  //       isLoading(false);
  //       update();
  //     } else if (getSum.status == 'suc') {
  //       if (getSum.data[0].sumBillTotal == null) {
  //         switch (kind) {
  //           case 0:
  //             billsStockTotal.value = 0;
  //             break;
  //           case 1:
  //             billsbackTotal.value = 0;
  //             break;
  //         }
  //         isLoading(false);
  //         update();
  //       } else {
  //         switch (kind) {
  //           case 0:
  //             billsStockTotal.value = getSum.data[0].sumBillTotal;
  //             break;
  //           case 1:
  //             billsbackTotal.value = getSum.data[0].sumBillTotal;
  //             break;
  //         }

  //         isLoading(false);
  //         update();
  //       }
  //     }
  //   } catch (_) {}
  // }

  // @override
  // getBillsInPaymentSum({required int kind}) async {
  //   try {
  //     var getSum = await Crud.postRequest(
  //       Api.apiGetBillsInPaymentDate,
  //       {
  //         'start_date': '${startDate.value.toString()} 00:00:00',
  //         'end_date': '${endDate.value.toString()} 23:59:00',
  //         'is_back': kind.toString(),
  //       },
  //       sumBillPaymentModelFromJson,
  //     );
  //     if (getSum.status == 'fail') {
  //       isLoading(false);
  //       update();
  //     } else if (getSum.status == 'suc') {
  //       if (getSum.data[0].sumBillPayment == null) {
  //         switch (kind) {
  //           case 0:
  //             billsStockPayment.value = 0;
  //             break;
  //           case 1:
  //             billsbackPayment.value = 0;
  //             break;
  //         }
  //         isLoading(false);
  //         update();
  //       } else {
  //         switch (kind) {
  //           case 0:
  //             billsStockPayment.value = getSum.data[0].sumBillPayment;
  //             break;
  //           case 1:
  //             billsbackPayment.value = getSum.data[0].sumBillPayment;
  //             break;
  //         }
  //         isLoading(false);
  //         update();
  //       }
  //     }
  //   } catch (_) {}
  // }
}
