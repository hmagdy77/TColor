import '../../../controllers/users/users_controller.dart';
import '../../../libraries.dart';
import '../../models/bills/bill_model.dart';
import '../../models/status/status_model.dart';

class BillsInRepo {
  static getBillsIn() {
    return Crud.postRequest(
      url: Api.apiGetBillsIn,
      data: {},
      function: billModelFromJson,
    );
  }

  static addBillIn() {
    return Crud.postRequest(
      url: Api.apiAddBillsIn,
      data: {
        'bill_sup': 'bill_sup',
      },
      function: statusModelFromJson,
    );
  }

  static saveBillIn({
    required String id,
    required String sup,
    required String billTotal,
    required String billNotes,
    // required String workNum,
    required String kind,
    required String numberOfItems,
    required String billDate,
  }) {
    return Crud.postRequest(
      url: Api.apiSaveBillsIn,
      data: {
        'bill_sup': sup,
        'bill_id': id,
        'bill_total': billTotal,
        'bill_items': numberOfItems,
        'kind': kind,
        'bill_notes': billNotes,
        'bill_timestamp': billDate,
        'work_name': UsersControllerImp.empName,
        'plan_id': '0',
        'bill_payment': '0.1',
      },
      function: statusModelFromJson,
    );
  }

  static editBillIn({
    required String id,
    required String sup,
    required String billTotal,
    required String billNotes,
    required String billPayment,
    required String numberOfItems,
  }) {
    return Crud.postRequest(
      url: Api.apiEditBillsIn,
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

  static deleteBillIn({
    required String billId,
  }) {
    return Crud.postRequest(
      url: Api.apiDeleteBillsIn,
      data: {'bill_id': billId},
      function: statusModelFromJson,
    );
  }
}
