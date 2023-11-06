import '../../data/models/users/user_model.dart';
import '../../data/repo/users/users_repo.dart';
import '../../libraries.dart';
import '../../view/widgets/login/snackbar.dart';

abstract class UsersController extends GetxController {
  addUser({required String kind});
  getUsers();
  editUser({required String userId});
  deleteUser({required String userId});
  void search(String searchName);
  login();
  logOut();
  showPassword();
}

class UsersControllerImp extends UsersController {
  late TextEditingController name;
  late TextEditingController userName;
  late TextEditingController password;
  late TextEditingController searchController;
  MyService myService = Get.find();
  GlobalKey<FormState> editUserKey = GlobalKey<FormState>();
  GlobalKey<FormState> addUserKey = GlobalKey<FormState>();
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  var selectedPrimison = ''.obs;
  var isLoading = false.obs;
  List<User> usersList = <User>[].obs;
  List<User> searchUsersList = <User>[].obs;
  List<User> loginList = <User>[].obs;
  static String? empName = '';
  static int? userKind = 0;

  bool isShown = true;

  @override
  void onInit() {
    name = TextEditingController();
    userName = TextEditingController();
    password = TextEditingController();
    searchController = TextEditingController();
    empName = myService.sharedPreferences.getString(AppStrings.keyUserName);
    userKind = myService.sharedPreferences.getInt(AppStrings.adminKey);
    getUsers();
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    userName.dispose();
    password.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  addUser({required String kind}) async {
    var formData = addUserKey.currentState;
    if (formData!.validate()) {
      isLoading.value = true;
      var addUser = await UsersRepo.addUser(
        name: name.text,
        userName: userName.text,
        password: password.text,
        kind: kind,
      );
      try {
        if (addUser.status == "suc") {
          isLoading(false);
          Get.offNamed(
            AppRoutes.loadingScreen,
            arguments: [
              AppRoutes.addUserScreen,
              () {
                getUsers();
              },
            ],
          );
          name.clear();
          userName.clear();
          password.clear();
          update();
        } else if (addUser.status == "found") {
          MySnackBar.snack(AppStrings.userFound, ' ');
          isLoading(false);
          update();
        } else if (addUser.status == "fail") {
          isLoading(false);
          update();
        }
      } catch (_) {
        isLoading(false);
        update();
      }
    }
  }

  @override
  editUser({required String userId}) async {
    var formData = editUserKey.currentState;
    if (formData!.validate()) {
      isLoading(true);
      var edituser = await UsersRepo.editUser(
        name: name.text,
        userName: userName.text,
        password: password.text,
        userId: userId,
      );
      try {
        if (edituser.status == "suc") {
          Get.offNamed(
            AppRoutes.loadingScreen,
            arguments: [
              AppRoutes.searchUserScreen,
              () {
                getUsers();
              },
            ],
          );
          isLoading(false);
          update();
        } else if (edituser.status == "fail") {
          MySnackBar.snack(AppStrings.noitemsEdited, '');
          isLoading(false);
          update();
        }
      } catch (_) {
        isLoading(false);
        update();
      }
    }
  }

  @override
  getUsers() async {
    usersList.clear();
    searchUsersList.clear();
    isLoading(true);
    try {
      var users = await UsersRepo.getUsers();
      if (users.status == 'fail') {
        isLoading(false);
        update();
      } else if (users.status == 'suc') {
        isLoading(false);
        usersList.addAll(users.data);
        update();
      }
    } catch (_) {}
  }

  @override
  void search(String searchName) {
    isLoading(true);
    searchName = searchName.toLowerCase();
    searchUsersList = usersList.where(
      (user) {
        var userName = user.userName;
        var userId = user.userId.toString();
        return userName.contains(searchName) || userId.contains(searchName);
      },
    ).toList();
    isLoading(false);
    update();
  }

  @override
  deleteUser({required String userId}) async {
    isLoading(true);
    var user = await UsersRepo.deleteUser(userId: userId);
    if (user.status == 'suc') {
      isLoading(false);
      Get.offNamed(AppRoutes.loadingScreen, arguments: [
        AppRoutes.searchUserScreen,
        () {},
      ]);
      getUsers();
      update();
    } else if (user.status == 'fail') {
      isLoading(false);
      update();
    }
  }

  @override
  showPassword() {
    isShown = !isShown;
    update();
  }

  @override
  login() async {
    var formData = loginKey.currentState;
    if (formData!.validate()) {
      loginList.clear();
      isLoading.value = true;
      var login = await UsersRepo.login(userName: userName.text);
      try {
        if (login.status == "suc") {
          loginList.addAll(login.data);
          if (loginList[0].userPassword != password.text) {
            MySnackBar.snack('', AppStrings.wrongPassword);
            isLoading(false);
            update();
          } else {
            MySnackBar.snack(AppStrings.sucLogIn, '');
            myService.sharedPreferences
                .setInt(AppStrings.adminKey, loginList[0].userKind);
            userKind = loginList[0].userKind;
            myService.sharedPreferences
                .setString(AppStrings.keyUserName, loginList[0].name);
            empName = loginList[0].name;
            isLoading(false);
            userName.clear();
            password.clear();
            update();
            Get.offNamed(AppRoutes.mainScreen);
            // if (loginList[0].userKind == 1) {
            //   MySnackBar.snack(AppStrings.sucLogIn, '');
            //   Get.offNamed(AppRoutes.mainScreen);
            //   myService.sharedPreferences.setInt(AppStrings.adminKey, 1);
            //   myService.sharedPreferences
            //       .setString(AppStrings.keyUserName, loginList[0].name);
            //   isLoading(false);
            //   update();
            // } else if (loginList[0].userKind == 2) {
            //   MySnackBar.snack(AppStrings.sucLogIn, '');
            //   Get.offNamed(AppRoutes.mainScreen);
            //   myService.sharedPreferences.setInt(AppStrings.adminKey, 2);
            //   myService.sharedPreferences
            //       .setString(AppStrings.keyUserName, loginList[0].name);
            //   isLoading(false);
            //   update();
            // } else if (loginList[0].userKind == 3) {
            //   MySnackBar.snack(AppStrings.sucLogIn, '');
            //   myService.sharedPreferences.setInt(AppStrings.adminKey, 3);
            //   myService.sharedPreferences
            //       .setString(AppStrings.keyUserName, loginList[0].name);
            //   Get.offNamed(AppRoutes.mainScreen);
            //   isLoading(false);
            //   update();
            // }
          }
        } else if (login.status == "fail") {
          MySnackBar.snack(AppStrings.userNotFound, '');
          isLoading(false);
          update();
        }
      } catch (_) {
        isLoading(false);
        update();
      }
    }
  }

  @override
  logOut() {
    isLoading(true);
    myService.sharedPreferences.setInt(AppStrings.adminKey, 0);
    myService.sharedPreferences.setString(AppStrings.keyUserName, '');
    userName.clear();
    password.clear();
    // myService.sharedPreferences.clear();
    Get.offNamed(AppRoutes.loginScreen);
    isLoading(false);
  }
}
