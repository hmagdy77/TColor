// import '../../../controllers/bill_in/bill_in_controller.dart';
// import '../../../libraries.dart';
// import '../../widgets/login/snackbar.dart';
// import '../../widgets/menus/upper_widget.dart';

// class ReportsBillInScreen extends StatelessWidget {
//   ReportsBillInScreen({super.key});
//   final BillInControllerImp billInController = Get.put(BillInControllerImp());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           UpperWidget(
//             isAdminScreen: true,
//             onPressed: () {},
//           ),
//           MyContainer(
//             content: Obx(
//               () {
//                 if (billInController.isLoading.value) {
//                   return const MyLottieLoading();
//                 } else {
//                   return Column(
//                     children: [
//                       Text(
//                         AppStrings.billInReports,
//                         style: context.textTheme.titleSmall,
//                       ),
//                       //for height
//                       SizedBox(
//                         height: AppSizes.h05,
//                       ),
//                       //buttons
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           MyButton(
//                             text: AppStrings.selectStartDate,
//                             onPressed: () {
//                               // billInController.getDate(
//                               //     context: context, end: false, start: true);
//                               // billInController.billsStockTotal.value = 0;
//                               // billInController.billsbackTotal.value = 0;
//                               // billInController.billsStockPayment.value = 0;
//                               // billInController.billsbackPayment.value = 0;
//                             },
//                           ),
//                           MyButton(
//                             text: AppStrings.selectendtDate,
//                             onPressed: () {
//                               // billInController.getDate(
//                               //     context: context, end: true, start: false);
//                               // billInController.billsStockTotal.value = 0;
//                               // billInController.billsbackTotal.value = 0;
//                               // billInController.billsStockPayment.value = 0;
//                               // billInController.billsbackPayment.value = 0;
//                             },
//                           ),
//                           MyButton(
//                             text: AppStrings.getData,
//                             onPressed: () async {
//                               if (billInController.startDate.isEmpty) {
//                                 MySnackBar.snack(
//                                     AppStrings.mustChoseStartDate, '');
//                               } else if (billInController.endDate.isEmpty) {
//                                 MySnackBar.snack(
//                                     AppStrings.mustChoseEndDate, '');
//                               } else {
//                                 // await billInController.getBillsInSum(kind: 0);
//                                 // await billInController.getBillsInSum(kind: 1);
//                                 // await billInController.getBillsInPaymentSum(
//                                 //     kind: 0);
//                                 // await billInController.getBillsInPaymentSum(
//                                 //     kind: 1);
//                               }
//                             },
//                           ),
//                         ],
//                       ),
//                       //for height
//                       SizedBox(
//                         height: AppSizes.h05,
//                       ),
//                       //dates
//                       Row(
//                         children: [
//                           const Spacer(),
//                           Text(
//                             '${AppStrings.startDate}  :  ${billInController.startDate.toString()}',
//                             style: context.textTheme.displayLarge,
//                           ),
//                           const Spacer(),
//                           Text(
//                             '${AppStrings.endtDate}  :  ${billInController.endDate.toString()}',
//                             style: context.textTheme.displayLarge,
//                           ),
//                           const Spacer(),
//                         ],
//                       ),
//                       //for height
//                       SizedBox(
//                         height: AppSizes.h05,
//                       ),
//                       // //table
//                       // Container(
//                       //   color: Colors.white,
//                       //   padding: EdgeInsets.symmetric(horizontal: AppSizes.w1),
//                       //   child: Table(
//                       //     border:
//                       //         TableBorder.all(color: Colors.black, width: 1),
//                       //     children: [
//                       //       TableRow(
//                       //         decoration: BoxDecoration(
//                       //             border: Border.all(width: 3),
//                       //             shape: BoxShape.rectangle),
//                       //         children: const [
//                       //           TableWidget(
//                       //             text: AppStrings.reportKind,
//                       //           ),
//                       //           TableWidget(
//                       //             text: AppStrings.total,
//                       //           ),
//                       //         ],
//                       //       ),
//                       //       TableRow(
//                       //         children: [
//                       //           const TableWidget(
//                       //             text: AppStrings.billIn,
//                       //           ),
//                       //           TableWidget(
//                       //             text: billInController.billsStockTotal
//                       //                 .toStringAsFixed(2),
//                       //           ),
//                       //         ],
//                       //       ),
//                       //       TableRow(
//                       //         children: [
//                       //           const TableWidget(
//                       //             text: AppStrings.pay14,
//                       //           ),
//                       //           TableWidget(
//                       //             text: (double.parse(billInController
//                       //                         .billsStockTotal
//                       //                         .toString()) *
//                       //                     .14)
//                       //                 .toStringAsFixed(2),
//                       //           ),
//                       //         ],
//                       //       ),
//                       //       TableRow(
//                       //         children: [
//                       //           const TableWidget(
//                       //             text: AppStrings.totalWithPay,
//                       //           ),
//                       //           TableWidget(
//                       //             text: ((double.parse(billInController
//                       //                             .billsStockTotal
//                       //                             .toString()) *
//                       //                         .14) +
//                       //                     double.parse(billInController
//                       //                         .billsStockTotal
//                       //                         .toString()))
//                       //                 .toStringAsFixed(2),
//                       //           ),
//                       //         ],
//                       //       ),
//                       //     ],
//                       //   ),
//                       // ),
//                       // // for Height
//                       // SizedBox(
//                       //   height: AppSizes.h05,
//                       // ),
//                       // //print Button
//                       // MyButton(
//                       //   text: AppStrings.print,
//                       //   onPressed: () {
//                       //     printReport(
//                       //       startDate: billInController.startDate.toString(),
//                       //       endDate: billInController.endDate.toString(),
//                       //       kind: AppStrings.billInReports,
//                       //       date:
//                       //           '${AppStrings.printDate} ${billInController.formatter.format(DateTime.now())}',
//                       //       fristRow: [
//                       //         billInController.billsStockTotal.value
//                       //             .toStringAsFixed(2),
//                       //         AppStrings.billIn,
//                       //       ],
//                       //       secondRow: [
//                       //         (double.parse(billInController.billsStockTotal
//                       //                     .toString()) *
//                       //                 .14)
//                       //             .toStringAsFixed(2),
//                       //         AppStrings.pay14,
//                       //       ],
//                       //       thirdRow: [
//                       //         ((double.parse(billInController.billsStockTotal
//                       //                         .toString()) *
//                       //                     .14) +
//                       //                 double.parse(billInController
//                       //                     .billsStockTotal
//                       //                     .toString()))
//                       //             .toStringAsFixed(2),
//                       //         AppStrings.totalWithPay,
//                       //       ],
//                       //     );
//                       //   },
//                       // ),
//                     ],
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
