// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:showcaseview/showcaseview.dart';

// import '../../../controllers/main/main_screen_controller.dart';

// class ShowCaseView extends StatelessWidget {
//   ShowCaseView({
//     super.key,
//     required this.globalKey,
//     required this.title,
//     required this.description,
//     required this.child,
//     required this.onTap,
//   });
//   final GlobalKey globalKey;
//   final String title;
//   final String description;
//   final Widget child;
//   final Function onTap;
//   final MainControllerImp mainController = Get.find();
//   @override
//   Widget build(BuildContext context) {
//     return Showcase(
//       key: globalKey,
//       description: description,
//       title: title,
//       onBarrierClick: onTap(),
//       child: child,
//     );
//   }
// }
