import '../../../controllers/users/users_controller.dart';
import '../../../libraries.dart';
import '../../models/bills/bill_model.dart';
import '../../models/status/status_model.dart';

class BillShortageRepo {
  static getBillShortage() {
    return Crud.postRequest(
      url: Api.apiGetBillShortage,
      data: {},
      function: billModelFromJson,
    );
  }

  static addBillShortage() {
    return Crud.postRequest(
      url: Api.apiAddBillShortage,
      data: {
        'bill_sup': 'bill_sup',
      },
      function: statusModelFromJson,
    );
  }

  static saveBillShortage({
    required String id,
    required String sup,
    required String billTotal,
    required String billNotes,
    required String planId,
    required String kind,
    required String numberOfItems,
    required String billDate,
    required String agentName,
    required String agentPhone,
  }) {
    return Crud.postRequest(
      url: Api.apiSaveBillShortage,
      data: {
        'bill_sup': sup,
        'bill_id': id,
        'bill_total': billTotal,
        'bill_items': numberOfItems,
        'kind': kind,
        'bill_notes': billNotes,
        'bill_timestamp': billDate,
        'plan_id': planId,
        'bill_payment': '0.1',
        'agent_name': agentName, //8
        'agent_phone': agentPhone, //9
        'work_name': UsersControllerImp.empName,
      },
      function: statusModelFromJson,
    );
  }

  static editBillShortage({
    required String id,
    required String sup,
    required String billTotal,
    required String billNotes,
    required String billPayment,
    required String numberOfItems,
  }) {
    return Crud.postRequest(
      url: Api.apiEditBillShortage,
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

  static deleteBillShortage({
    required String billId,
  }) {
    return Crud.postRequest(
      url: Api.apiDeleteBillShortage,
      data: {'bill_id': billId},
      function: statusModelFromJson,
    );
  }
}
