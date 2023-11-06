// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../controllers/bill_stock/bill_stock_cart.dart';
// import '../../../controllers/bill_stock/bill_stock_controller.dart';
// import '../../../controllers/items/item_controller.dart';
// import '../../../core/constants/app_color_manger.dart';
// import '../../../core/constants/app_sizes.dart';
// import '../../../core/constants/app_strings.dart';
// import '../../../core/functions/sub_string.dart';
// import '../../../data/models/items/item_model.dart';

// // ignore: must_be_immutable
// class BillLocalCartItem extends StatelessWidget {
//   BillLocalCartItem({
//     Key? key,
//     required this.index,
//     required this.billStockItem,
//     required this.quantity,
//   }) : super(key: key);
//   final BillStockCartControllerImp cartController =
//       Get.find<BillStockCartControllerImp>();
//   final BillStockControllerImp billStockController =
//       Get.find<BillStockControllerImp>();
//   final int index;
//   final Item billStockItem;
//   double quantity;
//   @override
//   Widget build(BuildContext context) {
//     // int? isAdmin =
//     //     cartController.myService.sharedPreferences.getInt(AppStrings.adminKey);
//     return Container(
//       margin: EdgeInsets.only(
//         left: AppSizes.w01,
//         top: AppSizes.w01,
//       ),
//       padding: EdgeInsets.only(top: AppSizes.w01, right: AppSizes.w01),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         color: cartController.isOverd![index]
//             ? AppColorManger.grey
//             : AppColorManger.primary,
//       ),
//       width: AppSizes.w25,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             billStockItem.itemName.maxLength(18),
//             style: Get.textTheme.displayMedium,
//             textAlign: TextAlign.start,
//           ),
//           Text(
//             billStockItem.itemNum.maxLength(18),
//             style: Get.textTheme.displayMedium,
//             textAlign: TextAlign.start,
//           ),
//           Text(
//             '${AppStrings.itemQuantity} : ${ItemControllerImp().converter(quant: billStockItem.itemCount)}',
//             style: context.textTheme.displayMedium,
//             textAlign: TextAlign.start,
//           ),
//         ],
//       ),
//     );
//   }
// }
