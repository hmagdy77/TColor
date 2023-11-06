import '../../../controllers/users/users_controller.dart';
import '../../../libraries.dart';
import '../../models/plans/plan_model.dart';
import '../../models/status/status_model.dart';

class PlansRepo {
  static getPlans() {
    return Crud.postRequest(
      url: Api.apiGetPlans,
      data: {},
      function: plansModelFromJson,
    );
  }

  static addPlan() {
    return Crud.postRequest(
      url: Api.apiAddPlans,
      data: {},
      function: statusModelFromJson,
    );
  }

  static savePlan({
    required String id,
    required String name,
    required String description,
    required String done,
    required String date,
    required String components,
    required String proudcts,
  }) {
    return Crud.postRequest(
      url: Api.apiSavePlans,
      data: {
        'id': id,
        'name': name,
        'des': description,
        'done': done,
        'date': date,
        'components': components,
        'proudcts': proudcts,
        'work_name': UsersControllerImp.empName,
      },
      function: statusModelFromJson,
    );
  }

  static updatePlan({
    required String id,
    required String exghange,
    required String componentsDone,
    required String proudctsDone,
  }) {
    return Crud.postRequest(
      url: Api.apiUpdatePlan,
      data: {
        'id': id,
        'exghange': exghange,
        'components_done': componentsDone,
        'proudcts_done': proudctsDone,
      },
      function: statusModelFromJson,
    );
  }

  static editPlan({
    required String id,
    required String done,
  }) {
    return Crud.postRequest(
      url: Api.apiEditPlans,
      data: {
        'done': done,
        'id': id,
      },
      function: statusModelFromJson,
    );
  }

  static deletePlan({
    required String id,
  }) {
    return Crud.postRequest(
      url: Api.apiDeletePlans,
      data: {'id': id},
      function: statusModelFromJson,
    );
  }
}
