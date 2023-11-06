import 'package:get/get_navigation/src/routes/get_route.dart';

import 'core/middle_ware/middle_ware.dart';
import 'view/screens/bills_factory/add_bill_factory_screen.dart';
import 'view/screens/bills_factory/reports/reports_bill_factory_screen.dart';
import 'view/screens/bills_factory/search_bill_factory_screen.dart';
import 'view/screens/bills_factory/view_bill_factory_screen.dart';
import 'view/screens/bills_in/add_back_billin_screen.dart';
import 'view/screens/bills_in/add_billin_screen.dart';
import 'view/screens/bills_in/edit_bill_in_screen.dart';
import 'view/screens/bills_in/reports_billin.dart';
import 'view/screens/bills_in/search_bill_in_screen.dart';
import 'view/screens/bills_out/add_back_billout_screen.dart';
import 'view/screens/bills_out/add_billout_screen.dart';
import 'view/screens/bills_out/edit_bill_out_screen.dart';
import 'view/screens/bills_out/reports/reports_billout_screen.dart';
import 'view/screens/bills_out/search_bill_out_screen.dart';
import 'view/screens/bills_shortage/add_minus_bill_shortage_screen.dart';
import 'view/screens/bills_shortage/add_plus_bill_shortage_screen.dart';
import 'view/screens/bills_shortage/edit_bill_shortage_screen.dart';
import 'view/screens/bills_shortage/reports/reports_bill_shortage_screen.dart';
import 'view/screens/bills_stock/add_back_bill_stock_screen.dart';
import 'view/screens/bills_stock/add_bill_stock_screen.dart';
import 'view/screens/bills_stock/edit_bill_stock_screen.dart';
import 'view/screens/ip_address_screen.dart';
import 'view/screens/items/component/add_component_item_screen.dart';
import 'view/screens/items/component/componets_screen.dart';
import 'view/screens/items/component/edit_component_screen.dart';
import 'view/screens/items/products/add_proudct_item_screen.dart';
import 'view/screens/items/products/products_screen.dart';
import 'view/screens/items/products/view_proudct_details.dart';
import 'view/screens/items/reports/reports_stock_screen.dart';
import 'view/screens/items/sup_stock/sup_stock.dart';
import 'view/screens/items/view_stock_bills_screen.dart';
import 'view/screens/main/loading_screen.dart';
import 'view/screens/main/main_screen.dart';
import 'view/screens/main/splash_screen.dart';
import 'view/screens/plans/add_plan_screen.dart';
import 'view/screens/plans/day_report_screen.dart';
import 'view/screens/plans/plan_details_screen.dart';
import 'view/screens/plans/search_plan_screen.dart';
import 'view/screens/serial_number_screen.dart';
import 'view/screens/supplires/add_sup_screen.dart';
import 'view/screens/supplires/edit_sup_screen.dart';
import 'view/screens/supplires/search_sup_screen.dart';
import 'view/screens/users/add_user_screen.dart';
import 'view/screens/users/edit_user_screen.dart';
import 'view/screens/users/login_screen.dart';
import 'view/screens/users/search_user_screen.dart';

List<GetPage<dynamic>>? getRoutes = [
  //************************main Screens************************
  GetPage(
    name: '/',
    page: () => SerialNumberScreen(),
    middlewares: [
      MiddleWare(),
    ],
  ),
  GetPage(
    name: AppRoutes.splashScreen,
    page: () => SplashScreen(),
  ),
  GetPage(
    name: AppRoutes.mainScreen,
    page: () => const MainScreen(),
  ),
  GetPage(
    name: AppRoutes.loadingScreen,
    page: () => LoadingScreen(),
  ),
  GetPage(
    name: AppRoutes.ipAddressScreen,
    page: () => IpAddressScreen(),
  ),

  //************************Subliers Screens************************
  GetPage(
    name: AppRoutes.addSupScreen,
    page: () => AddSupScreen(),
  ),
  GetPage(
    name: AppRoutes.editSupScreen,
    page: () => EditSupScreen(),
  ),
  GetPage(
    name: AppRoutes.searchSupScreen,
    page: () => SearchSupScreen(),
  ),
  //************************items Screens************************
  GetPage(
    name: AppRoutes.addComponentItemScreen,
    page: () => AddComponentItemScreen(),
  ),
  GetPage(
    name: AppRoutes.addProudctItemScreen,
    page: () => AddProudctItemScreen(),
  ),
  GetPage(
    name: AppRoutes.productsScreen,
    page: () => ProductsScreen(),
  ),
  GetPage(
    name: AppRoutes.componetsScreen,
    page: () => ComponetsScreen(),
  ),
  // viewProudctDetails
  GetPage(
    name: AppRoutes.viewProudctDetails,
    page: () => ViewProudctDetails(),
  ),
  // EditItemScreen
  GetPage(
    name: AppRoutes.editComponentScreen,
    page: () => EditComponentScreen(),
  ),
  GetPage(
    name: AppRoutes.supStockScreen,
    page: () => SubStock(),
  ),
  GetPage(
    name: AppRoutes.viewStockBillsScreen,
    page: () => const ViewStockBillsScreen(),
  ),
  GetPage(
    name: AppRoutes.reportsStockScreen,
    page: () => const ReportsStockScreen(),
  ),

  //************************billIn Screens************************
  GetPage(
    name: AppRoutes.addBillInScreen,
    page: () => AddBillInScreen(),
  ),
  GetPage(
    name: AppRoutes.addBackBillInScreen,
    page: () => AddBackBillInScreen(),
  ),

  GetPage(
    name: AppRoutes.editBillInScreen,
    page: () => EditBillInScreen(),
  ),
  GetPage(
    name: AppRoutes.searchBillInScreen,
    page: () => SearchBillInScreen(),
  ),
  GetPage(
    name: AppRoutes.reportBillInScreen,
    page: () => ReportsBillInScreen(),
  ),

  //************************billOut Screens************************
  GetPage(
    name: AppRoutes.addBillOutScreen,
    page: () => AddBillOutScreen(),
  ),
  GetPage(
    name: AppRoutes.addBackBillOutScreen,
    page: () => AddBackBillOutScreen(),
  ),

  GetPage(
    name: AppRoutes.editBillOutScreen,
    page: () => EditBillOutScreen(),
  ),
  GetPage(
    name: AppRoutes.searchBillOutScreen,
    page: () => SearchBillOutScreen(),
  ),
  GetPage(
    name: AppRoutes.reportBillOutScreen,
    page: () => const ReportsBillsOutScreen(),
  ),

  //************************billShortage Screens************************
  GetPage(
    name: AppRoutes.addPlusBillShortageScreen,
    page: () => AddPlusBillShortageScreen(),
  ),
  GetPage(
    name: AppRoutes.addMinusBillShortageScreen,
    page: () => AddMinusBillShortageScreen(),
  ),
  GetPage(
    name: AppRoutes.editBillShortageScreen,
    page: () => EditBillShortageScreen(),
  ),

  GetPage(
    name: AppRoutes.reportsBillsShortageScreen,
    page: () => const ReportsBillsShortageScreen(),
  ),

  //************************Bill Factory Screens************************
  GetPage(
    name: AppRoutes.addBillFactoryScreen,
    page: () => AddBillFactoryScreen(),
  ),
  GetPage(
    name: AppRoutes.searchBillFactoryScreen,
    page: () => SearchBillFactoryScreen(),
  ),
  GetPage(
    name: AppRoutes.viewBillFactoryScreen,
    page: () => ViewBillFactoryScreen(),
  ),
  GetPage(
    name: AppRoutes.reportBillFactoryScreen,
    page: () => const ReportsBillsFactoryScreen(),
  ),

  //************************Bill Stock Screens************************
  GetPage(
    name: AppRoutes.addBillStockScreen,
    page: () => AddBillStockScreen(),
  ),
  GetPage(
    name: AppRoutes.addBackBillStockScreen,
    page: () => AddBillBackStockScreen(),
  ),

  GetPage(
    name: AppRoutes.editBillStockScreen,
    page: () => EditBillStockScreen(),
  ),
  //************************plans Screens************************
  GetPage(
    name: AppRoutes.addPlanScreen,
    page: () => AddPlanScreen(),
  ),
  GetPage(
    name: AppRoutes.searchPlansScreen,
    page: () => SearchPlanScreen(),
  ),
  GetPage(
    name: AppRoutes.planDetailsScreen,
    page: () => PlanDetailsScreen(),
  ),
  GetPage(
    name: AppRoutes.dayReportsScreen,
    page: () => DayReportsScreen(),
  ),

  //************************plans Screens************************
  GetPage(
    name: AppRoutes.addUserScreen,
    page: () => AddUserScreen(),
  ),
  GetPage(
    name: AppRoutes.editUserScreen,
    page: () => EditUserScreen(),
  ),
  GetPage(
    name: AppRoutes.searchUserScreen,
    page: () => SearchUserScreen(),
  ),
  GetPage(
    name: AppRoutes.loginScreen,
    page: () => LoginScreen(),
  ),
];

class AppRoutes {
  //************************main Screens************************
  static const String onBoardingScreen = '/onBoarding';
  static const String splashScreen = '/splashScreen';
  static const String mainScreen = '/mainScreen';
  static const String loadingScreen = '/loadingScreen';
  static const String ipAddressScreen = '/ipAddressScreen';
//************************items Screens************************
  static const String addComponentItemScreen = '/addComponentItemScreen';
  static const String componetsScreen = '/componetsScreen';
  static const String editComponentScreen = '/editComponentScreen';
  static const String addProudctItemScreen = '/addProudctItemScreen';
  static const String viewProudctDetails = '/viewProudctDetails';
  static const String productsScreen = '/productsScreen';
  static const String supStockScreen = '/supStockScreen';
  static const String viewStockBillsScreen = '/viewStockBillsScreen';
  //************************Bill Stock Screens************************
  static const String addBillStockScreen = '/addBillStockScreen';
  // static const String searchBillStockScreen = '/searchBillStockScreen';
  static const String editBillStockScreen = '/editBillStockScreen';
  static const String addBackBillStockScreen = '/addBackBillStockScreen';
  static const String reportsStockScreen = '/reportsStockScreen';
  //************************sup Screens************************
  static const String addSupScreen = '/addSupScreen';
  static const String searchSupScreen = '/searchSupScreen';
  static const String editSupScreen = '/editSupScreen';
  //************************plans Screens************************
  static const String addPlanScreen = '/addPlanScreen';
  static const String searchPlansScreen = '/searchPlansScreen';
  static const String planDetailsScreen = '/planDetailsScreen';
  static const String dayReportsScreen = '/dayReportsScreen';
  //************************Bill In Screens************************
  static const String addBillInScreen = '/addBillInScreen';
  static const String searchBillInScreen = '/searchBillInScreen';
  static const String editBillInScreen = '/editBillInScreen';
  static const String addBackBillInScreen = '/addBackBillInScreen';
  static const String reportBillInScreen = '/reportBillInScreen';
  //************************Bill Out Screens************************
  static const String addBillOutScreen = '/addBillOutScreen';
  static const String searchBillOutScreen = '/searchBillOutScreen';
  static const String editBillOutScreen = '/editBillOutScreen';
  static const String addBackBillOutScreen = '/addBackBillOutScreen';
  static const String reportBillOutScreen = '/reportBillOutScreen';
  //************************Bill Shortage Screens************************
  static const String addMinusBillShortageScreen =
      '/addMinusBillShortageScreen';
  static const String addPlusBillShortageScreen = '/addPlusBillShortageScreen';
  static const String editBillShortageScreen = '/editBillShortageScreen';
  // static const String searchBillShortageScreen = '/searchBillShortageScreen';
  static const String reportsBillsShortageScreen =
      '/reportsBillsShortageScreen';
  //************************Bill Factory Screens************************
  static const String addBillFactoryScreen = '/addBillFactoryScreen';
  static const String viewBillFactoryScreen = '/viewBillFactoryScreen';
  static const String searchBillFactoryScreen = '/searchBillFactoryScreen';
  static const String reportBillFactoryScreen = '/reportBillFactoryScreen';
//************************auth Screens************************
  static const String loginScreen = '/login';
  static const String addUserScreen = '/addUserScreen';
  static const String searchUserScreen = '/searchUserScreen';
  static const String editUserScreen = '/editUserScreen';
}
