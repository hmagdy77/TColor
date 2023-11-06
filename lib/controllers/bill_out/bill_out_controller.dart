import 'package:intl/intl.dart';

import '../../data/models/bills/bill_model.dart';
import '../../data/repo/bill_out/bill_out_repo.dart';
import '../../libraries.dart';
import '../../view/widgets/login/snackbar.dart';

abstract class BillOutController extends GetxController {
  addBillOut();
  saveBillOut({
    required String sup,
    required String id,
    required String total,
    required String numberOfItems,
    required String kind,
    required String planId,
  });
  setBillDate({required context});
  getDate({required context, required bool start, required bool end});
  editBillOut(
      {required String sup,
      required String id,
      required String total,
      required String numberOfItems});
  getBillsOut();
  search({required String searchName});
  deleteBill({required String billId});
  // getBillsOutSum({required int kind});
  // getBillsOutPaymentSum({required int kind});
}

class BillOutControllerImp extends BillOutController {
  late TextEditingController billOutSearchController;
  late TextEditingController billPayment;
  late TextEditingController billNotes;
  late TextEditingController agentName;
  late TextEditingController agentPhone;

  bool isShown = true;
  var isLoading = false.obs;
  List<Bill> billsOutList = <Bill>[].obs;
  List<Bill> billsOutSearchList = <Bill>[].obs;
  List<Bill> billsOutListReversed = <Bill>[].obs;
  List<Bill> billsOutDateList = <Bill>[].obs;
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
    billOutSearchController = TextEditingController();
    billPayment = TextEditingController();
    billNotes = TextEditingController();
    agentName = TextEditingController();
    agentPhone = TextEditingController();
    getBillsOut();
    super.onInit();
  }

  @override
  void dispose() {
    billOutSearchController.dispose();
    billPayment.dispose();
    billNotes.dispose();
    agentName.dispose();
    agentPhone.dispose();
    super.dispose();
  }

  @override
  addBillOut() async {
    isLoading.value = true;
    var addBillOut = await BillsOutRepo.addBillOut();
    try {
      if (addBillOut.status == "suc") {
        isLoading(false);
        update();
      } else if (addBillOut.status == "fail") {
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  saveBillOut({
    required String sup,
    required String id,
    required String total,
    required String numberOfItems,
    required String kind,
    required String planId,
  }) async {
    isLoading.value = true;
    var saveBillOut = await BillsOutRepo.saveBillOut(
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
    if (saveBillOut.status == "suc") {
      if (kind == '1') {
        Get.offNamed(
          AppRoutes.loadingScreen,
          arguments: [
            AppRoutes.addBillOutScreen,
            () {
              getBillsOut();
            },
          ],
        );
      } else {
        Get.offNamed(
          AppRoutes.loadingScreen,
          arguments: [
            AppRoutes.addBackBillOutScreen,
            () {
              getBillsOut();
            },
          ],
        );
      }

      isLoading(false);
      update();
    } else if (saveBillOut.status == "fail") {
      isLoading(false);
      update();
    }
    try {} catch (_) {
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
  editBillOut({
    required String sup,
    required String id,
    required String total,
    required String numberOfItems,
  }) async {
    try {
      isLoading.value = true;
      var editBillOut = await BillsOutRepo.editBillOut(
        id: id,
        sup: sup,
        billTotal: double.parse(total).toString(),
        billNotes: billNotes.text,
        billPayment: billPayment.text.toString(),
        numberOfItems: numberOfItems,
      );

      if (editBillOut.status == "suc") {
        Get.offNamed(
          AppRoutes.loadingScreen,
          arguments: [AppRoutes.searchBillOutScreen],
        );
        isLoading(false);
        update();
      } else if (editBillOut.status == "fail") {
        Get.offNamed(
          AppRoutes.loadingScreen,
          arguments: [AppRoutes.searchBillOutScreen],
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
  getBillsOut() async {
    billsOutList.clear();
    billsOutListReversed.clear();
    isLoading(true);
    var billOut = await BillsOutRepo.getBillsOut();
    try {
      if (billOut.status == 'fail') {
        isLoading(false);
        update();
      } else if (billOut.status == 'suc') {
        isLoading(false);
        billsOutList.addAll(billOut.data);
        billsOutListReversed = billsOutList.reversed.toList();
        update();
      }
    } catch (_) {}
  }

  @override
  void search({required String searchName}) {
    isLoading(true);
    searchName = searchName.toLowerCase();
    billsOutSearchList = billsOutList.where(
      (bill) {
        var agentName = bill.agentName;
        var agentPhone = bill.agentPhone;
        var billId = bill.billId.toString();
        var billTotal = bill.billTotal.toString();
        var date = bill.billTimestamp.toString();
        var notes = bill.billNotes.toString();
        return agentName.contains(searchName) ||
            agentPhone.contains(searchName) ||
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
    var item = await BillsOutRepo.deleteBillOut(billId: billId);
    if (item.status == 'suc') {
      isLoading(false);
      Get.offAndToNamed(
        AppRoutes.loadingScreen,
        arguments: [
          AppRoutes.searchBillOutScreen,
          () {
            getBillsOut();
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
  // getBillsOutSum({required int kind}) async {
  //   try {
  //     var getSum = await Crud.postRequest(
  //       Api.apiGetBillsOutDate,
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
  // getBillsOutPaymentSum({required int kind}) async {
  //   try {
  //     var getSum = await Crud.postRequest(
  //       Api.apiGetBillsOutPaymentDate,
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
