import '../../../libraries.dart';
import '../../models/status/status_model.dart';
import '../../models/users/user_model.dart';

class UsersRepo {
  static getUsers() {
    return Crud.postRequest(
      url: Api.apiGetUsers,
      data: {},
      function: usersModelFromJson,
    );
  }

  static addUser({
    required String name,
    required String userName,
    required String password,
    required String kind,
  }) {
    return Crud.postRequest(
      url: Api.apiAddUsers,
      data: {
        'name': name,
        'user_name': userName,
        'user_password': password,
        'user_kind': kind,
      },
      function: statusModelFromJson,
    );
  }

  static deleteUser({
    required String userId,
  }) {
    return Crud.postRequest(
      url: Api.apiDeleteUsers,
      data: {
        'user_id': userId,
      },
      function: statusModelFromJson,
    );
  }

  static editUser({
    required String userId,
    required String name,
    required String userName,
    required String password,
  }) {
    return Crud.postRequest(
      url: Api.apiEditUsers,
      data: {
        'user_id': userId,
        'name': name,
        'user_name': userName,
        'user_password': password,
      },
      function: statusModelFromJson,
    );
  }

  static login({required String userName}) {
    return Crud.postRequest(
      url: Api.apiLogin,
      data: {
        'user_name': userName,
      },
      function: usersModelFromJson,
    );
  }

  static serial({required String number}) {
    return Crud.postRequest(
      url: Api.apiSerial,
      data: {
        'number': number,
      },
      function: usersModelFromJson,
    );
  }
}
