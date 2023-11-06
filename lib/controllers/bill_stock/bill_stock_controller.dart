import 'package:intl/intl.dart';

import '../../data/models/bills/bill_model.dart';
import '../../data/repo/bill_stock/bill_stock_repo.dart';
import '../../libraries.dart';
import '../../view/widgets/login/snackbar.dart';

abstract class BillStockController extends GetxController {
  addBill();
  saveBillStock({
    required String sup,
    required String id,
    required String total,
    required String numberOfItems,
    required String kind,
    required String planId,
  });
  setBillDate({required context});
  getDate({required context, required bool start, required bool end});
  editBillStock(
      {required String sup,
      required String id,
      required String total,
      required String numberOfItems});
  getBillsStock();
  search({required String searchName});
  void searchKind({required int kind});
  deleteBill({required String billId});
}

class BillStockControllerImp extends BillStockController {
  late TextEditingController billStockSearchController;
  late TextEditingController billPayment;
  late TextEditingController billNotes;
  bool isShown = true;
  var isLoading = false.obs;
  List<Bill> billsStockList = <Bill>[].obs;
  List<Bill> billsStockSearchList = <Bill>[].obs;
  List<Bill> billsStockListReversed = <Bill>[].obs;
  MyService myService = Get.find();
  var now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');
  var startDate = ''.obs;
  var endDate = ''.obs;
  var selectedKind = ''.obs;
  var billDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  var date = DateTime.now().obs;
  var billsStockTotal = 0.obs;
  var billsbackTotal = 0.obs;
  var billsStockPayment = 0.obs;
  var billsbackPayment = 0.obs;

  @override
  void onInit() {
    billStockSearchController = TextEditingController();
    billPayment = TextEditingController();
    billNotes = TextEditingController();
    getBillsStock();
    super.onInit();
  }

  @override
  void dispose() {
    billStockSearchController.dispose();
    billPayment.dispose();
    billNotes.dispose();
    super.dispose();
  }

  @override
  addBill() async {
    isLoading.value = true;
    var addBill = await BillsStockRepo.addBillStock();
    try {
      if (addBill.status == "suc") {
        isLoading(false);
        update();
      } else if (addBill.status == "fail") {
        isLoading(false);
        update();
      }
    } catch (_) {
      isLoading(false);
      update();
    }
  }

  @override
  saveBillStock({
    required String sup,
    required String id,
    required String total,
    required String numberOfItems,
    required String kind,
    required String planId,
  }) async {
    isLoading.value = true;
    var saveBillStock = await BillsStockRepo.saveBillStock(
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
    );
    if (saveBillStock.status == "suc") {
      if (kind == '1') {
        Get.offNamed(
          AppRoutes.loadingScreen,
          arguments: [
            AppRoutes.addBillStockScreen,
            () {
              getBillsStock();
            },
          ],
        );
      } else {
        Get.offNamed(
          AppRoutes.loadingScreen,
          arguments: [
            AppRoutes.addBackBillStockScreen,
            () {
              getBillsStock();
            },
          ],
        );
      }
      isLoading(false);
      update();
    } else if (saveBillStock.status == "fail") {
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
  editBillStock({
    required String sup,
    required String id,
    required String total,
    required String numberOfItems,
  }) async {
    try {
      isLoading.value = true;
      var editBillStock = await BillsStockRepo.editBillStock(
        id: id,
        sup: sup,
        billTotal: double.parse(total).toString(),
        billNotes: billNotes.text,
        billPayment: billPayment.text.toString(),
        numberOfItems: numberOfItems,
      );

      if (editBillStock.status == "suc") {
        Get.offNamed(
          AppRoutes.loadingScreen,
          arguments: [
            AppRoutes.searchBillInScreen,
            () {
              getBillsStock();
            },
          ],
        );
        isLoading(false);
        update();
      } else if (editBillStock.status == "fail") {
        Get.offNamed(
          AppRoutes.loadingScreen,
          arguments: [
            AppRoutes.searchBillInScreen,
            () {
              getBillsStock();
            },
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
  getBillsStock() async {
    billsStockList.clear();
    billsStockListReversed.clear();
    isLoading(true);
    var billIn = await BillsStockRepo.getBillsStock();
    try {
      if (billIn.status == 'fail') {
        isLoading(false);
        update();
      } else if (billIn.status == 'suc') {
        isLoading(false);
        billsStockList.addAll(billIn.data);
        billsStockListReversed = billsStockList.reversed.toList();
        update();
      }
    } catch (_) {}
  }

  @override
  void search({required String searchName}) {
    isLoading(true);
    searchName = searchName.toLowerCase();
    billsStockSearchList = billsStockList.where(
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

  @override
  void searchKind({required int kind}) {
    isLoading(true);
    billsStockSearchList = billsStockList.where(
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
    var item = await BillsStockRepo.deleteBillStock(billId: billId);
    if (item.status == 'suc') {
      isLoading(false);
      Get.offNamed(
        AppRoutes.loadingScreen,
        arguments: [
          AppRoutes.searchBillInScreen,
          () {},
        ],
      );
      update();
    } else if (item.status == 'fail') {
      isLoading(false);
      update();
    }
  }
}
