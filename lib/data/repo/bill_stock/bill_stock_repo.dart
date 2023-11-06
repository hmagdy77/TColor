import '../../../controllers/users/users_controller.dart';
import '../../../libraries.dart';
import '../../models/bills/bill_model.dart';
import '../../models/status/status_model.dart';

class BillsStockRepo {
  static getBillsStock() {
    return Crud.postRequest(
      url: Api.apiGetBillsstock,
      data: {},
      function: billModelFromJson,
    );
  }

  static addBillStock() {
    return Crud.postRequest(
      url: Api.apiAddBillsstock,
      data: {
        'bill_sup': 'bill_sup',
      },
      function: statusModelFromJson,
    );
  }

  static saveBillStock({
    required String id,
    required String sup,
    required String billTotal,
    required String billNotes,
    required String planId,
    required String kind,
    required String numberOfItems,
    required String billDate,
  }) {
    return Crud.postRequest(
      url: Api.apiSaveBillsstock,
      data: {
        'bill_sup': sup,
        'bill_id': id,
        'bill_total': billTotal,
        'bill_items': numberOfItems,
        'kind': kind,
        'plan_id': planId,
        'bill_payment': '0.1',
        'bill_notes': billNotes,
        'bill_timestamp': billDate,
        'work_name': UsersControllerImp.empName,
      },
      function: statusModelFromJson,
    );
  }

  static editBillStock({
    required String id,
    required String sup,
    required String billTotal,
    required String billNotes,
    required String billPayment,
    required String numberOfItems,
  }) {
    return Crud.postRequest(
      url: Api.apiEditBillsstock,
      data: {
        'bill_sup': sup,
        'bill_id': id,
        'bill_total': billTotal,
        'bill_items': numberOfItems,
        'bill_payment': billPayment,
        'bill_notes': billNotes,
      },
      function: statusModelFromJson,
    );
  }

  static deleteBillStock({
    required String billId,
  }) {
    return Crud.postRequest(
      url: Api.apiDeleteBillsstock,
      data: {'bill_id': billId},
      function: statusModelFromJson,
    );
  }
}
