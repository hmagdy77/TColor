import '../../../controllers/bill_in/bill_in_cart.dart';
import '../../../controllers/bill_in/bill_in_controller.dart';
import '../../../controllers/bill_stock/bill_stock_cart.dart';
import '../../../controllers/ingredients/ingredients_controller.dart';
import '../../../controllers/items/item_controller.dart';
import '../../../controllers/plans/plan_controller.dart';
import '../../../controllers/plans/plan_item_controller.dart';
import '../../../controllers/users/users_controller.dart';
import '../../../libraries.dart';
import 'bill_factory_menu.dart';
import 'bill_in_menu.dart';
import 'bill_out_menu.dart';
import 'bill_stock_menu.dart';
import 'plans_menu.dart';
import 'stock_menu.dart';
import 'users_menu.dart';

class UpperWidget extends StatelessWidget {
  UpperWidget(
      {super.key, required this.isAdminScreen, required this.onPressed});
  final bool isAdminScreen;
  final Function onPressed;
  final MyService myService = Get.find();
  final UsersControllerImp usersController = Get.find<UsersControllerImp>();
  final ItemControllerImp itemController = Get.find<ItemControllerImp>();
  final BillStockCartControllerImp billStockCartController =
      Get.find<BillStockCartControllerImp>();
  final PlanControllerImp planController = Get.find<PlanControllerImp>();
  final PlanItemControllerImp planItemController =
      Get.find<PlanItemControllerImp>();
  final BillInControllerImp billInController = Get.find<BillInControllerImp>();
  final BillInCartControllerImp billInCartController =
      Get.find<BillInCartControllerImp>();
  final IngredientControllerImp ingredientController =
      Get.find<IngredientControllerImp>();

  @override
  Widget build(BuildContext context) {
    int? key = myService.sharedPreferences.getInt(AppStrings.adminKey);
    String? name = UsersControllerImp.empName;
    if (key == 1) {
      return const PremisionAdmin();
    } else if (key == 2) {
      return PremisionPlans(
        usersController: usersController,
        itemController: itemController,
        billInController: billInController,
        billInCartController: billInCartController,
        ingredientController: ingredientController,
        name: name!,
      );
    } else if (key == 3) {
      return PremisionFactory(
        itemController: itemController,
        usersController: usersController,
        planController: planController,
        name: name!,
      );
    } else if (key == 4) {
      return PremisionStock(
        billStockCartController: billStockCartController,
        planController: planController,
        planItemController: planItemController,
        usersController: usersController,
        name: name!,
      );
    } else {
      return PremisionEmpty(
        usersController: usersController,
      );
    }
  }
}

class PremisionEmpty extends StatelessWidget {
  const PremisionEmpty({
    super.key,
    required this.usersController,
  });

  final UsersControllerImp usersController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.h01),
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              Get.offAllNamed(AppRoutes.mainScreen);
            },
            child: Text(
              AppStrings.mainScreen,
              style: context.textTheme.displaySmall,
            ),
          ),
          IconButton(
            onPressed: () {
              usersController.logOut();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
          IconButton(
            onPressed: () {
              ThemeController().changeTheme();
            },
            icon: const Icon(Icons.sunny),
          )
        ],
      ),
    );
  }
}

class PremisionAdmin extends StatelessWidget {
  const PremisionAdmin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.h01),
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              Get.offAllNamed(AppRoutes.mainScreen);
            },
            child: Text(
              AppStrings.mainScreen,
              style: context.textTheme.displaySmall,
            ),
          ),
          StockMenu(kind: AppStrings.allPrimisons),
          BillStockMenu(kind: AppStrings.allPrimisons),
          BillInMenu(),
          PlansMenu(),
          BillFactoryMenu(),
          BillOutMenu(),
          UsersMenu(),
          IconButton(
            onPressed: () {
              ThemeController().changeTheme();
            },
            icon: const Icon(Icons.sunny),
          )
        ],
      ),
    );
  }
}

class PremisionStock extends StatelessWidget {
  const PremisionStock({
    super.key,
    required this.billStockCartController,
    required this.planController,
    required this.planItemController,
    required this.usersController,
    required this.name,
  });

  final BillStockCartControllerImp billStockCartController;
  final PlanControllerImp planController;
  final PlanItemControllerImp planItemController;
  final UsersControllerImp usersController;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.h01),
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              Get.offAllNamed(AppRoutes.mainScreen);
            },
            child: Text(
              AppStrings.mainScreen,
              style: context.textTheme.displaySmall,
            ),
          ),
          StockMenu(kind: ''),
          BillStockMenu(kind: AppStrings.stock),
          TextButton(
            onPressed: () async {
              Get.offAllNamed(AppRoutes.dayReportsScreen);
            },
            child: Text(
              AppStrings.dayReports,
              style: context.textTheme.displaySmall,
            ),
          ),
          SizedBox(
            width: AppSizes.h01,
          ),
          IconButton(
            onPressed: () {
              usersController.logOut();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
          IconButton(
            onPressed: () {
              ThemeController().changeTheme();
            },
            icon: const Icon(Icons.sunny),
          ),
          const Spacer(),
          Text(
            name,
            style: context.textTheme.displayMedium,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class PremisionFactory extends StatelessWidget {
  const PremisionFactory({
    super.key,
    required this.itemController,
    required this.usersController,
    required this.planController,
    required this.name,
  });

  final ItemControllerImp itemController;
  final UsersControllerImp usersController;
  final PlanControllerImp planController;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.h01),
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              Get.offAllNamed(AppRoutes.mainScreen);
            },
            child: Text(
              AppStrings.mainScreen,
              style: context.textTheme.displaySmall,
            ),
          ),
          TextButton(
            onPressed: () async {
              await itemController.getItems();
              Get.offAllNamed(AppRoutes.supStockScreen);
            },
            child: Text(
              AppStrings.subStock,
              style: context.textTheme.displaySmall,
            ),
          ),
          TextButton(
            onPressed: () async {
              await planController.getPlans();
              Get.offAllNamed(AppRoutes.searchPlansScreen);
            },
            child: Text(
              AppStrings.plans,
              style: context.textTheme.displaySmall,
            ),
          ),
          TextButton(
            onPressed: () async {
              Get.offAllNamed(AppRoutes.dayReportsScreen);
            },
            child: Text(
              AppStrings.dayReports,
              style: context.textTheme.displaySmall,
            ),
          ),
          BillStockMenu(kind: ''),
          BillFactoryMenu(),
          IconButton(
            onPressed: () async {
              usersController.logOut();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
          IconButton(
            onPressed: () {
              ThemeController().changeTheme();
            },
            icon: const Icon(Icons.sunny),
          ),
          const Spacer(),
          Text(
            name,
            style: context.textTheme.displayMedium,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class PremisionPlans extends StatelessWidget {
  const PremisionPlans({
    super.key,
    required this.usersController,
    required this.itemController,
    required this.billInCartController,
    required this.billInController,
    required this.ingredientController,
    required this.name,
  });

  final UsersControllerImp usersController;
  final ItemControllerImp itemController;
  final BillInCartControllerImp billInCartController;
  final BillInControllerImp billInController;
  final IngredientControllerImp ingredientController;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.h01),
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              Get.offAllNamed(AppRoutes.mainScreen);
            },
            child: Text(
              AppStrings.mainScreen,
              style: context.textTheme.displaySmall,
            ),
          ),
          TextButton(
            onPressed: () {
              ingredientController.getIngredients();
              Get.offNamed(AppRoutes.productsScreen);
            },
            child: Text(
              AppStrings.products,
              style: context.textTheme.displaySmall,
            ),
          ),
          BillInMenu(),
          PlansMenu(),
          BillOutMenu(),
          IconButton(
            onPressed: () {
              usersController.logOut();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
          IconButton(
            onPressed: () {
              ThemeController().changeTheme();
            },
            icon: const Icon(Icons.sunny),
          ),
          const Spacer(),
          Text(
            name,
            style: context.textTheme.displayMedium,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
