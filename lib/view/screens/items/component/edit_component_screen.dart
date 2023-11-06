import '../../../../controllers/items/item_controller.dart';
import '../../../../controllers/supplires/sup_controller.dart';
import '../../../../data/models/items/item_model.dart';
import '../../../../libraries.dart';
import '../../../widgets/admin/dialouge.dart';
import '../../../widgets/drop_menu/drop_menu.dart';
import '../../../widgets/login/snackbar.dart';
import '../../../widgets/menus/upper_widget.dart';

class EditComponentScreen extends StatelessWidget {
  EditComponentScreen({super.key});
  final Item myItem = Get.arguments[0];
  // final int kind = Get.arguments[1];
  final ItemControllerImp itemController = Get.find<ItemControllerImp>();
  final SupControllerImp supController = Get.find<SupControllerImp>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UpperWidget(
            isAdminScreen: false,
            onPressed: () {},
          ),
          Expanded(
            child: Form(
              key: itemController.editItemKey,
              child: Obx(
                () {
                  if (itemController.isLoading.value) {
                    return const MyLottieLoading();
                  } else {
                    return MyContainer(
                      content: ListView(
                        children: [
                          Text(AppStrings.components,
                              style: context.textTheme.titleSmall),
                          //for height
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          // name and num
                          Row(
                            children: [
                              //name textfield
                              Expanded(
                                child: MyTextField(
                                  controller: itemController.name,
                                  validate: (val) {
                                    return validInput(
                                      max: 80,
                                      min: 1,
                                      type: AppStrings.validateAdmin,
                                      val: val,
                                    );
                                  },
                                  label: AppStrings.itemName,
                                  hidePassword: false,
                                ),
                              ),
                              //for width
                              SizedBox(
                                width: AppSizes.w1,
                              ),
                              //code textfield
                              Expanded(
                                child: MyTextField(
                                  controller: itemController.num,
                                  validate: (val) {
                                    return validInput(
                                      max: 80,
                                      min: 1,
                                      type: AppStrings.validateAdmin,
                                      val: val,
                                    );
                                  },
                                  readOnly: true,
                                  label: AppStrings.itemNum,
                                  hint: 'P18129898',
                                  hidePassword: false,
                                ),
                              ),
                            ],
                          ),
                          //for height
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          //priceIn textfield and priceout textfield
                          Row(
                            children: [
                              Expanded(
                                child: MyNumberField(
                                  withDot: true,
                                  controller: itemController.priceIn,
                                  label: AppStrings.itemPriceIn,
                                  padding: 8,
                                ),
                              ),
                              SizedBox(
                                width: AppSizes.w1,
                              ),
                              Expanded(
                                child: MyNumberField(
                                  withDot: true,
                                  controller: itemController.priceOut,
                                  label: AppStrings.itemPriceOut,
                                  padding: 8,
                                ),
                              ),
                            ],
                          ),
                          //for height
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          //min textfield and max textfield
                          Row(
                            children: [
                              Expanded(
                                child: MyNumberField(
                                  withDot: true,
                                  controller: itemController.min,
                                  label: AppStrings.min,
                                  padding: 8,
                                ),
                              ),
                              SizedBox(
                                width: AppSizes.w1,
                              ),
                              Expanded(
                                child: MyNumberField(
                                  withDot: true,
                                  controller: itemController.max,
                                  label: AppStrings.max,
                                  padding: 8,
                                ),
                              ),
                            ],
                          ),
                          //for height
                          SizedBox(
                            height: AppSizes.h05,
                          ),
                          //  select sup
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      '${AppStrings.supName} : ',
                                      style: context.textTheme.displayLarge,
                                    ),
                                    Expanded(
                                      child: MyDropMenu(
                                        label: supController
                                            .selectedSupFrist.value,
                                        bodyItems: supController.supListNames,
                                        onChanged: (value) {
                                          supController.selectedSupFrist.value =
                                              value as String;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: AppSizes.w1,
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      '${AppStrings.supName} : ',
                                      style: context.textTheme.displayLarge,
                                    ),
                                    Expanded(
                                      child: MyDropMenu(
                                        label: supController
                                            .selectedSupSecond.value,
                                        bodyItems: supController.supListNames,
                                        onChanged: (value) {
                                          supController.selectedSupSecond
                                              .value = value as String;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          //for height
                          SizedBox(
                            height: AppSizes.h05,
                          ),

                          // select sup third and forth
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      '${AppStrings.supNameThird} : ',
                                      style: context.textTheme.displayLarge,
                                    ),
                                    Expanded(
                                      child: MyDropMenu(
                                        label: supController
                                            .selectedSupThird.value,
                                        bodyItems: supController.supListNames,
                                        onChanged: (value) {
                                          supController.selectedSupThird.value =
                                              value as String;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: AppSizes.w1,
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      '${AppStrings.supNameForth} : ',
                                      style: context.textTheme.displayLarge,
                                    ),
                                    Expanded(
                                      child: MyDropMenu(
                                        label: supController
                                            .selectedSupForth.value,
                                        bodyItems: supController.supListNames,
                                        onChanged: (value) {
                                          supController.selectedSupForth.value =
                                              value as String;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          // edit && deletr buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MyButton(
                                text: AppStrings.delete,
                                onPressed: () {
                                  myDialuge(
                                    confirm: () {
                                      itemController.deleteItem(
                                        id: myItem.itemId.toString(),
                                      );
                                    },
                                    cancel: () {},
                                    title: AppStrings.confirm,
                                    middleText: '',
                                  );
                                },
                              ),
                              MyButton(
                                // minWidth: true,
                                text: AppStrings.edit,
                                onPressed: () {
                                  var supFrist =
                                      supController.selectedSupFrist.value;
                                  var supSecond =
                                      supController.selectedSupSecond.value;
                                  var supForth =
                                      supController.selectedSupForth.value;
                                  var supThird =
                                      supController.selectedSupThird.value;

                                  if (itemController.name.text.isEmpty ||
                                      itemController.num.text.isEmpty ||
                                      itemController.priceOut.text.isEmpty ||
                                      itemController.priceIn.text.isEmpty ||
                                      itemController.min.text.isEmpty ||
                                      itemController.max.text.isEmpty ||
                                      // bad end
                                      itemController.priceOut.text
                                          .endsWith('.') ||
                                      itemController.priceIn.text
                                          .endsWith('.') ||
                                      itemController.min.text.endsWith('.') ||
                                      itemController.max.text.endsWith('.')) {
                                    MySnackBar.snack(
                                        AppStrings.pleaseEnterWantedValues, '');
                                  } else if (supFrist.isEmpty) {
                                    MySnackBar.snack(AppStrings.choseSup, '');
                                  } else {
                                    itemController.editItem(
                                      sup:
                                          '$supFrist , $supSecond , $supThird , $supForth',
                                      item: myItem,
                                    );
                                  }
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
