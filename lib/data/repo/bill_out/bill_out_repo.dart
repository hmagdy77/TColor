import '../../../controllers/users/users_controller.dart';
import '../../../libraries.dart';
import '../../models/bills/bill_model.dart';
import '../../models/status/status_model.dart';

class BillsOutRepo {
  static getBillsOut() {
    return Crud.postRequest(
      url: Api.apiGetBillsOut,
      data: {},
      function: billModelFromJson,
    );
  }

  static addBillOut() {
    return Crud.postRequest(
      url: Api.apiAddBillsOut,
      data: {
        'bill_sup': 'bill_sup',
      },
      function: statusModelFromJson,
    );
  }

  static saveBillOut({
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
      url: Api.apiSaveBillsOut,
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

  static editBillOut({
    required String id,
    required String sup,
    required String billTotal,
    required String billNotes,
    required String billPayment,
    required String numberOfItems,
  }) {
    return Crud.postRequest(
      url: Api.apiEditBillsOut,
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

  static deleteBillOut({
    required String billId,
  }) {
    return Crud.postRequest(
      url: Api.apiDeleteBillsOut,
      data: {'bill_id': billId},
      function: statusModelFromJson,
    );
  }
}
