import '../../libraries.dart';
import '../models/status/status_model.dart';
import '../models/sup/sup_model.dart';

class SupRepo {
  static getSup() {
    return Crud.postRequest(
      url: Api.apiGetSup,
      data: {},
      function: supModelFromJson,
    );
  }

  static addSup({
    required String name,
    required String tel,
  }) {
    return Crud.postRequest(
      url: Api.apiAddSup,
      data: {
        'sup_name': name,
        'sup_tel': tel,
      },
      function: statusModelFromJson,
    );
  }

  static editSup({
    required String id,
    required String name,
    required String tel,
  }) {
    Crud.postRequest(
        url: Api.apiEditSup,
        data: {
          'sup_id': id,
          'sup_name': name,
          'sup_tel': tel,
        },
        function: statusModelFromJson);
  }

  static deleteSup({
    required String id,
  }) {
    Crud.postRequest(
      url: Api.apiDeleteSup,
      data: {'sup_id': id},
      function: statusModelFromJson,
    );
  }
}
