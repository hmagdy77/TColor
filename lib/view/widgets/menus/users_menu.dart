import '../../../controllers/users/users_controller.dart';
import '../../../libraries.dart';
import '../drop_menu/drop_menu.dart';

class UsersMenu extends StatelessWidget {
  UsersMenu({super.key});

  final List bodyItems = [
    AppStrings.users,
    'ip address',
    AppStrings.logOut,
  ];
  final UsersControllerImp usersController = Get.find<UsersControllerImp>();

  @override
  Widget build(BuildContext context) {
    return MyDropMenu(
      label: AppStrings.settings,
      bodyItems: bodyItems,
      onChanged: (value) async {
        switch (value) {
          case AppStrings.users:
            await usersController.getUsers();
            Get.offAllNamed(
              AppRoutes.searchUserScreen,
            );
            break;
          case 'ip address':
            Get.offAllNamed(
              AppRoutes.ipAddressScreen,
            );
            break;
          case AppStrings.logOut:
            usersController.logOut();
            break;
          default:
            Get.offAllNamed(
              AppRoutes.mainScreen,
            );
        }
      },
    );
  }
}
