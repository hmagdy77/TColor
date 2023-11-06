import 'package:intl/intl.dart';

import '../../data/models/bills/bill_model.dart';
import '../../data/repo/bill_factory/bill_factory_repo.dart';
import '../../libraries.dart';

abstract class BillFactoryController extends GetxController {
  addBillFactory();
  getBillsFactory();
  saveBillFactory({
    required String id,
    required String total,
    required String numberOfItems,
    required String kind,
    required String planId,
  });
  setBillDate({required context});
  deleteBill({required String billId});

  search({required String searchName});
  // void searchKind({required String searchName});
  // deleteBill({required String billId});
  // getDate({required context, required bool start, required bool end});
  // setBillDate({required context});
  // getBillsFactorySum({required int kind});
  // double unPaid({required double afterDiscount});
  // double afterDiscount({required double total});
  // editBillFactory({
  //   required String id,
  //   required String total,
  //   required String numberOfItems,
  // });
  // getitemsbyBillService(String workId);
  // getItemsbyBillId(String workId);
  // getItemsByIndex(String workId);
  // void searchWorkBills({required String searchName});
  // addPayment({
  //   required String workName,
  //   required String workId,
  // });
}

class BillFactoryControllerImp extends BillFactoryController {
  List<Bill> billsFactoryList = <Bill>[].obs;
  var workBillsList = <Bill>[].obs;
  List<Bill> billsFactorySearchList = <Bill>[].obs;
  List<Bill> billsFactoryListReversed = <Bill>[].obs;
  GlobalKey<FormState> billFactoryKey = GlobalKey<FormState>();

  var now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');
  var startDate = ''.obs;
  var endDate = ''.obs;
  var billDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  var date = DateTime.now().obs;
  var discountValue = 0.0.obs;
  var paidValue = 0.0.obs;
  var billsStockTotal = 0.0.obs;
  var billsbackTotal = 0.0.obs;
  var billsRentTotal = 0.0.obs;
  var billsfixTotal = 0.0.obs;
  var stockRentFix = 0.0.obs;
  var safy = 0.0.obs;

  MyService myService = Get.find();
  late TextEditingController billFactorySearchController;
  late TextEditingController agentNameController;
  late TextEditingController agentPhoneController;
  late TextEditingController billNotesController;
  late TextEditingController discountController;
  late TextEditingController paidController;

  bool isShown = true;
  var isLoading = false.obs;

  @override
  void onInit() {
    billFactorySearchController = TextEditingController();
    agentNameController = TextEditingController();
    agentPhoneController = TextEditingController();
    billNotesController = TextEditingController();
    discountController = TextEditingController();
    paidController = TextEditingController();
    getBillsFactory();
    super.onInit();
  }

  @override
  void dispose() {
    billFactorySearchController.dispose();
    agentNameController.dispose();
    agentPhoneController.dispose();
    billNotesController.dispose();
    discountController.dispose();
    paidController.dispose();
    super.dispose();
  }

  @override
  addBillFactory() async {
    isLoading.value = true;
    var addBillFactory = await BillsFactoryRepo.addBillFactory();
    try {
      if (addBillFactory.status == "suc") {
        isLoading(false);
        update();
      } else if (addBillFactory.status == "fail") {
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  saveBillFactory({
    required String id,
    required String total,
    required String numberOfItems,
    required String kind,
    required String planId,
  }) async {
    isLoading.value = true;

    var saveBillFactory = await BillsFactoryRepo.saveBillFactory(
      id: id,
      agentName: agentNameController.text,
      agentPhone: agentPhoneController.text.trim(),
      billNotes: billNotesController.text,
      planId: planId,
      billTotal: total,
      numberOfItems: numberOfItems,
      billDate: billDate.value.isEmpty
          ? '${formatter.format(now)} ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}'
          : '${billDate.value.toString()} ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}',
      kind: kind,
    );
    if (saveBillFactory.status == "suc") {
      getBillsFactory();
      Get.offNamed(
        AppRoutes.loadingScreen,
        arguments: [
          AppRoutes.addBillFactoryScreen,
          () {},
        ],
      );
      isLoading(false);
      update();
    } else if (saveBillFactory.status == "fail") {
      Get.offNamed(
        AppRoutes.loadingScreen,
        arguments: [
          AppRoutes.addBillFactoryScreen,
          () {},
        ],
      );
      isLoading(false);
      update();
    }
    try {} catch (_) {
      // MySnackBar.snack('please try later', 'Some thing went wrong');
      isLoading(false);
      update();
    }
  }

  @override
  getBillsFactory() async {
    isLoading(true);
    var billFactory = await BillsFactoryRepo.getBillsFactory();
    billsFactorySearchList.clear();
    billsFactoryList.clear();
    try {
      if (billFactory.status == 'fail') {
        isLoading(false);
        update();
      } else if (billFactory.status == 'suc') {
        isLoading(false);
        billsFactoryList.addAll(billFactory.data);
        billsFactoryListReversed = billsFactoryList.reversed.toList();
        update();
      }
    } catch (_) {}
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
  deleteBill({required String billId}) async {
    isLoading(true);
    var item = await BillsFactoryRepo.deleteBillFactory(id: billId);
    if (item.status == 'suc') {
      isLoading(false);
      Get.offNamed(
        AppRoutes.loadingScreen,
        arguments: [
          AppRoutes.searchBillFactoryScreen,
          () {
            getBillsFactory();
          },
        ],
      );
      update();
    } else if (item.status == 'fail') {
      isLoading(false);
      update();
    }
  }

  @override
  void search({required String searchName}) {
    isLoading(true);
    searchName = searchName.toLowerCase();
    billsFactorySearchList = billsFactoryList
        .where(
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
        )
        .toList()
        .reversed
        .toList();
    isLoading(false);
    update();
  }
  // @override
  // setBillDate({required context}) {
  //   showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2020),
  //     lastDate: DateTime(2030),
  //     locale: const Locale('ar'),
  //   ).then(
  //     (pickedDate) {
  //       billDate.value = formatter.format(pickedDate!);
  //     },
  //   );
  // }

  // @override
  // getDate({required context, required bool start, required bool end}) {
  //   showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2020),
  //     lastDate: DateTime(2030),
  //     locale: const Locale('ar'),
  //   ).then(
  //     (pickedDate) {
  //       if (pickedDate == null) {
  //         return;
  //       }
  //       if (start) {
  //         startDate.value = formatter.format(pickedDate);
  //       } else if (end) {
  //         endDate.value = formatter.format(pickedDate);
  //       }
  //     },
  //   );
  // }

  // @override
  // getBillsFactorySum({required int kind}) async {
  //   try {
  //     var getSum = await Crud.postRequest(
  //       AppStrings.apiGetBillsFactoryInDate,
  //       {
  //         'start_date': '${startDate.value.toString()} 00:00:00',
  //         'end_date': '${endDate.value.toString()} 23:59:00',
  //         'is_back': kind.toString(),
  //       },
  //       sumBillModelFromJson,
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
  //           case 2:
  //             billsRentTotal.value = 0;
  //             break;
  //           case 3:
  //             billsfixTotal.value = 0;
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
  //           case 2:
  //             billsRentTotal.value = getSum.data[0].sumBillTotal;
  //             break;
  //           case 3:
  //             billsfixTotal.value = getSum.data[0].sumBillTotal;
  //             break;
  //         }

  //         isLoading(false);
  //         update();
  //       }
  //     }
  //   } catch (_) {}
  // }

  // @override
  // editBillFactory({
  //   required String id,
  //   required String total,
  //   required String numberOfItems,
  // }) async {
  //   isLoading.value = true;
  //   try {
  //     var editBillFactory = await Crud.postRequest(
  //       AppStrings.apiEditBillsFactory,
  //       {
  //         'agent_name': agentNameController.text,
  //         'agent_phone': agentPhoneController.text.trim(),
  //         'bill_notes': billNotesController.text,
  //         'bill_id': id,
  //         'bill_sup': 'bill_sup',
  //         'bill_total': total,
  //         'bill_discount': discountController.text,
  //         'bill_after_discount':
  //             (double.parse(total) - discountValue.value).toString(),
  //         'bill_paid': paidController.text,
  //         'bill_unpaid':
  //             ((double.parse(total) - discountValue.value) - paidValue.value)
  //                 .toString(),
  //         'bill_items': numberOfItems,
  //         // 'bill_timestamp': '${formatter.format(now)} 00:00:00'
  //       },
  //       statusModelFromJson,
  //     );
  //     if (editBillFactory.status == "suc") {
  //       Get.offNamed(
  //         AppRoutes.loadingScreen,
  //         arguments: [AppRoutes.searchBillFactoryScreen],
  //       );
  //       isLoading(false);
  //       update();
  //     } else if (editBillFactory.status == "fail") {
  //       MySnackBar.snack(AppStrings.noitemsEdited, '');
  //       Get.offNamed(
  //         AppRoutes.loadingScreen,
  //         arguments: [AppRoutes.searchBillFactoryScreen],
  //       );
  //       isLoading(false);
  //       update();
  //     }
  //   } catch (_) {
  //     isLoading(false);
  //     update();
  //   }
  // }

  // @override
  // double unPaid({required double afterDiscount}) {
  //   if (paidValue.value == 0) {
  //     return afterDiscount;
  //   } else {
  //     return (paidValue.value - afterDiscount);
  //   }
  // }

  // @override
  // double afterDiscount({required double total}) {
  //   if (discountValue.value == 0) {
  //     return total;
  //   } else {
  //     return (total - discountValue.value);
  //   }
  // }

  // @override
  // void searchKind({required String searchName}) {
  //   isLoading(true);
  //   searchName = searchName.toLowerCase();
  //   billsFactorySearchList = workBillsList.where(
  //     (bill) {
  //       var billBack = bill.kind.toString();
  //       return billBack.contains(searchName);
  //     },
  //   ).toList();
  //   isLoading(false);
  //   update();
  // }

  // @override
  // void searchWorkBills({required String searchName}) {
  //   isLoading(true);
  //   searchName = searchName.toLowerCase();
  //   billsFactorySearchList = workBillsList.where(
  //     (bill) {
  //       var billId = bill.billId.toString();
  //       var billTotal = bill.billTotal.toString();
  //       var billAgentName = bill.agentName.toString();
  //       var billAgentPhone = bill.agentPhone.toString();

  //       return billId.contains(searchName) ||
  //           billTotal.contains(searchName) ||
  //           billAgentName.contains(searchName) ||
  //           billAgentPhone.contains(searchName);
  //     },
  //   ).toList();
  //   isLoading(false);
  //   update();
  // }

  // @override
  // getitemsbyBillService(String workId) async {
  //   var bills = await Crud.postRequest(
  //     AppStrings.apiGetWorkBills,
  //     {'work_id': workId},
  //     billModelFromJson,
  //   );
  //   return bills.data;
  // }

  // @override
  // getItemsbyBillId(String workId) async {
  //   var bills = await getitemsbyBillService(workId);
  //   isLoading(true);
  //   workBillsList.value = bills;
  //   isLoading(false);
  //   if (bills.isEmpty) {
  //     isLoading(false);
  //     update();
  //   }
  // }

  // @override
  // getItemsByIndex(String workId) async {
  //   isLoading(true);
  //   var items = await getItemsbyBillId(workId);
  //   if (items != null) {
  //     workBillsList.value = items;
  //   }
  //   isLoading(false);
  // }

  // @override
  // addPayment({
  //   required String workName,
  //   required String workId,
  // }) async {
  //   var formData = billFactoryKey.currentState;
  //   if (formData!.validate()) {
  //     isLoading.value = true;
  //     var addBillFactory = await Crud.postRequest(
  //       AppStrings.apiAddBillsFactory,
  //       {
  //         'agent_name': 'agent_name',
  //         'agent_phone': 'agent_phone',
  //       },
  //       statusModelFromJson,
  //     );
  //     try {
  //       if (addBillFactory.status == "suc") {
  //         isLoading(false);
  //         update();
  //       } else if (addBillFactory.status == "fail") {
  //         MySnackBar.snack('please try later', 'Some thing went wrong');
  //         isLoading(false);
  //         update();
  //       }
  //     } catch (_) {
  //       //MySnackBar.snack('please try later', 'Some thing went wrong');
  //       isLoading(false);
  //       update();
  //     }
  //   }
  // }
}
