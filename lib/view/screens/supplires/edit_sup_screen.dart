import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/supplires/sup_controller.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/functions/valid_input.dart';
import '../../../data/models/sup/sup_model.dart';
import '../../../routes.dart';
import '../../widgets/admin/dialouge.dart';
import '../../widgets/menus/upper_widget.dart';
import '../../widgets/public/my_button.dart';
import '../../widgets/public/my_container.dart';
import '../../widgets/text_fields/my_text_field.dart';

class EditSupScreen extends StatelessWidget {
  EditSupScreen({super.key});

  final Sup mySup = Get.arguments[0];

  final SupControllerImp supController = Get.find<SupControllerImp>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     onPressed: () {
      //       editSupController.goToMainScreen();
      //     },
      //     icon: const Icon(Icons.arrow_back),
      //   ),
      // ),
      body: Form(
        key: supController.editSupKey,
        child: Column(
          children: [
            UpperWidget(
              isAdminScreen: true,
              onPressed: () {
                Get.offAllNamed(AppRoutes.searchSupScreen);
              },
            ),
            Expanded(
              child: MyContainer(
                content: ListView(
                  children: [
                    Text(AppStrings.editSup,
                        style: context.textTheme.titleSmall),
                    SizedBox(
                      height: AppSizes.h05,
                    ),
                    Text(
                      '${AppStrings.idNumber} : ${mySup.supId}',
                      style: context.textTheme.displayLarge,
                    ),
                    SizedBox(
                      height: AppSizes.h1,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MyTextField(
                            controller: supController.name,
                            validate: (val) {
                              return validInput(
                                max: 50,
                                min: 0,
                                type: AppStrings.validateAdmin,
                                val: val,
                              );
                            },
                            label: AppStrings.supName,
                            hidePassword: false,
                          ),
                        ),
                        SizedBox(
                          width: AppSizes.w1,
                        ),
                        Expanded(
                          child: MyTextField(
                            controller: supController.tel,
                            validate: (val) {
                              return validInput(
                                max: 50,
                                min: 0,
                                type: AppStrings.validateAdmin,
                                val: val,
                              );
                            },
                            label: AppStrings.supTel,
                            hidePassword: false,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSizes.h05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MyButton(
                          text: AppStrings.editSup,
                          onPressed: () async {
                            await supController.editSup(mySup.supId.toString());
                          },
                        ),
                        MyButton(
                          // minWidth: true,
                          text: AppStrings.deleteSup,
                          onPressed: () {
                            myDialuge(
                              cancel: () {
                                Get.back();
                              },
                              confirm: () async {
                                await supController
                                    .deleteSub(mySup.supId.toString());
                                Get.offAndToNamed(AppRoutes.splashScreen);
                              },
                              title: AppStrings.deleteSup,
                              middleText: '',
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
