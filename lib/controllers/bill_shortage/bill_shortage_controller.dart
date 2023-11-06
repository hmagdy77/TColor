import 'package:intl/intl.dart';

import '../../data/models/bills/bill_model.dart';
import '../../data/repo/bill_shortage/bill_shortage_repo.dart';
import '../../libraries.dart';
import '../../view/widgets/login/snackbar.dart';

abstract class BillShortageController extends GetxController {
  addBillShortage();
  saveBillShortage({
    required String sup,
    required String id,
    required String total,
    required String numberOfItems,
    required String kind,
    required String planId,
  });
  setBillDate({required context});
  getDate({required context, required bool start, required bool end});
  editBillShortage(
      {required String sup,
      required String id,
      required String total,
      required String numberOfItems});
  getBillShortage();
  search({required String searchName});
  deleteBill({required String billId});
  // getBillShortageSum({required int kind});
  // getBillShortagePaymentSum({required int kind});
}

class BillShortageControllerImp extends BillShortageController {
  late TextEditingController billShortageSearchController;
  late TextEditingController billPayment;
  late TextEditingController billNotes;
  late TextEditingController agentName;
  late TextEditingController agentPhone;

  bool isShown = true;
  var isLoading = false.obs;
  List<Bill> billsShortageList = <Bill>[].obs;
  List<Bill> billsShortageSearchList = <Bill>[].obs;
  List<Bill> billsShortageListReversed = <Bill>[].obs;
  List<Bill> billsShortageDateList = <Bill>[].obs;
  MyService myService = Get.find();
  var now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');
  var startDate = ''.obs;
  var endDate = ''.obs;
  var kind = 1.obs;
  var kindLabel = ''.obs;
  var billDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  var date = DateTime.now().obs;
  var billsStockTotal = 0.obs;
  var billsbackTotal = 0.obs;
  var billsStockPayment = 0.obs;
  var billsbackPayment = 0.obs;

  @override
  void onInit() {
    billShortageSearchController = TextEditingController();
    billPayment = TextEditingController();
    billNotes = TextEditingController();
    agentName = TextEditingController();
    agentPhone = TextEditingController();
    getBillShortage();
    super.onInit();
  }

  @override
  void dispose() {
    billShortageSearchController.dispose();
    billPayment.dispose();
    billNotes.dispose();
    agentName.dispose();
    agentPhone.dispose();
    super.dispose();
  }

  @override
  addBillShortage() async {
    isLoading.value = true;
    var addBillShortage = await BillShortageRepo.addBillShortage();
    try {
      if (addBillShortage.status == "suc") {
        isLoading(false);
        update();
      } else if (addBillShortage.status == "fail") {
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  saveBillShortage({
    required String sup,
    required String id,
    required String total,
    required String numberOfItems,
    required String kind,
    required String planId,
  }) async {
    isLoading.value = true;
    try {
      var saveBillShortage = await BillShortageRepo.saveBillShortage(
        sup: sup,
        kind: kind,
        id: id,
        billNotes: billNotes.text,
        billTotal: double.parse(total).toString(),
        numberOfItems: numberOfItems,
        billDate: billDate.value.isEmpty
            ? '${formatter.format(now)} ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}'
            : '${billDate.value.toString()} ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}',
        planId: planId,
        agentName: agentName.text,
        agentPhone: agentPhone.text,
      );
      if (saveBillShortage.status == "suc") {
        if (kind == '1') {
          Get.offNamed(
            AppRoutes.loadingScreen,
            arguments: [
              AppRoutes.addPlusBillShortageScreen,
              () {
                getBillShortage();
              },
            ],
          );
        } else {
          Get.offNamed(
            AppRoutes.loadingScreen,
            arguments: [
              AppRoutes.addMinusBillShortageScreen,
              () {
                getBillShortage();
              },
            ],
          );
        }

        isLoading(false);
        update();
      } else if (saveBillShortage.status == "fail") {
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
          date.value = (pickedDate);
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
  editBillShortage({
    required String sup,
    required String id,
    required String total,
    required String numberOfItems,
  }) async {
    try {
      isLoading.value = true;
      var editBillShortage = await BillShortageRepo.editBillShortage(
        id: id,
        sup: sup,
        billTotal: double.parse(total).toString(),
        billNotes: billNotes.text,
        billPayment: billPayment.text.toString(),
        numberOfItems: numberOfItems,
      );

      if (editBillShortage.status == "suc") {
        Get.offNamed(
          AppRoutes.loadingScreen,
          // arguments: [AppRoutes.searchBillShortageScreen],
        );
        isLoading(false);
        update();
      } else if (editBillShortage.status == "fail") {
        Get.offNamed(
          AppRoutes.loadingScreen,
          // arguments: [AppRoutes.searchBillShortageScreen],
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
  getBillShortage() async {
    billsShortageList.clear();
    billsShortageListReversed.clear();
    isLoading(true);
    var billShortage = await BillShortageRepo.getBillShortage();
    try {
      if (billShortage.status == 'fail') {
        isLoading(false);
        update();
      } else if (billShortage.status == 'suc') {
        isLoading(false);
        billsShortageList.addAll(billShortage.data);
        billsShortageListReversed = billsShortageList.reversed.toList();
        update();
      }
    } catch (_) {}
  }

  @override
  void search({required String searchName}) {
    isLoading(true);
    searchName = searchName.toLowerCase();
    billsShortageSearchList = billsShortageList.where(
      (bill) {
        var billId = bill.billId.toString();
        var billTotal = bill.billTotal.toString();
        var date = bill.billTimestamp.toString();
        var notes = bill.billNotes.toString();
        return billId.contains(searchName) ||
            billTotal.contains(searchName) ||
            date.contains(searchName) ||
            notes.contains(searchName);
      },
    ).toList();
    isLoading(false);
    update();
  }

  void searchKind({required int kind}) {
    isLoading(true);
    billsShortageSearchList = billsShortageList.where(
      (bill) {
        var billKind = bill.kind;
        return billKind == kind;
      },
    ).toList();
    isLoading(false);
    update();
  }

  @override
  deleteBill({required String billId}) async {
    isLoading(true);
    var item = await BillShortageRepo.deleteBillShortage(billId: billId);
    if (item.status == 'suc') {
      isLoading(false);
      Get.offAndToNamed(
        AppRoutes.loadingScreen,
        arguments: [
          AppRoutes.viewStockBillsScreen,
          () {
            getBillShortage();
          },
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
  // getBillShortageSum({required int kind}) async {
  //   try {
  //     var getSum = await Crud.postRequest(
  //       Api.apiGetBillShortageDate,
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
  // getBillShortagePaymentSum({required int kind}) async {
  //   try {
  //     var getSum = await Crud.postRequest(
  //       Api.apiGetBillShortagePaymentDate,
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
