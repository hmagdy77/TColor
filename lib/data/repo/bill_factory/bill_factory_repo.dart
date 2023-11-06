import '../../../controllers/users/users_controller.dart';
import '../../../libraries.dart';
import '../../models/bills/bill_model.dart';
import '../../models/status/status_model.dart';

class BillsFactoryRepo {
  static getBillsFactory() {
    return Crud.postRequest(
      url: Api.apiGetBillsFactory,
      data: {},
      function: billModelFromJson,
    );
  }

  static addBillFactory() {
    return Crud.postRequest(
      url: Api.apiAddBillsFactory,
      data: {
        'agent_name': 'agent_name',
        'agent_phone': 'agent_phone',
      },
      function: statusModelFromJson,
    );
  }

  static saveBillFactory({
    required String id,
    required String agentName,
    required String agentPhone,
    required String billNotes,
    required String planId,
    required String billTotal,
    required String numberOfItems,
    required String billDate,
    required String kind,
  }) {
    return Crud.postRequest(
      url: Api.apiSaveBillsFactory,
      data: {
        'agent_name': agentName,
        'agent_phone': agentPhone,
        'bill_notes': billNotes,
        'plan_id': planId,
        'kind': kind,
        'bill_id': id,
        'bill_total': billTotal,
        'bill_items': numberOfItems,
        'bill_timestamp': billDate,
        'bill_payment': '0',
        'work_name': UsersControllerImp.empName,
        'bill_sup': 'sup',
      },
      function: statusModelFromJson,
    );
  }

  static deleteBillFactory({
    required String id,
  }) {
    return Crud.postRequest(
      url: Api.apiDeleteBillsFactory,
      data: {'bill_id': id},
      function: statusModelFromJson,
    );
  }
}
