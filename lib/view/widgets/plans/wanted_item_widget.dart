import '../../../controllers/sub_stock/sub_stock_cart.dart';
import '../../../data/models/items/item_model.dart';
import '../../../libraries.dart';
import '../items/table_ciel.dart';

class WantedItemWidget extends StatelessWidget {
  WantedItemWidget({
    super.key,
    this.item,
    required this.isHeader,
    required this.isProudct,
    required this.index,
    this.name,
    this.code,
    this.wanted,
    this.sub,
    this.done,
    this.main,
    required this.inView,
    this.wight,
  });
  final Item? item;
  final bool isProudct;
  final bool isHeader;
  final bool inView;
  final int index;
  final String? name;
  final String? code;
  final String? wanted;
  final String? sub;
  final String? done;
  final String? wight;
  final String? main;

  final SubStockCartControllerImp subStockCartController =
      Get.find<SubStockCartControllerImp>();

  @override
  Widget build(BuildContext context) {
    if (isProudct) {
      if (isHeader) {
        return Row(
          children: [
            MyCiel(
              text: name ?? AppStrings.name,
              style: Get.textTheme.displaySmall,
              isHeader: true,
              width: 2,
              isBack: name == null ? false : true,
            ),
            MyCiel(
              text: code ?? 'code',
              style: Get.textTheme.displaySmall,
              isHeader: true,
              width: 2,
              isBack: code == null ? false : true,
            ),
            MyCiel(
              text: wanted ?? AppStrings.wanted,
              style: Get.textTheme.displaySmall,
              isHeader: true,
              width: 2,
              isBack: wanted == null ? false : true,
            ),
            MyCiel(
              text: sub ?? AppStrings.doneFactory,
              style: Get.textTheme.displaySmall,
              isHeader: true,
              width: 2,
              isBack: done == null ? false : true,
            ),
            MyCiel(
              text: sub ?? AppStrings.wight,
              style: Get.textTheme.displaySmall,
              isHeader: true,
              width: 2,
              isBack: wight == null ? false : true,
            ),
          ],
        );
      } else {
        return Row(
          children: [
            MyCiel(
              text: item!.itemName.maxLength(8),
              style: Get.textTheme.displaySmall,
              isHeader: false,
              width: 2,
              isBack: false,
            ),
            MyCiel(
              text: item!.itemNum.maxLength(10),
              style: Get.textTheme.displaySmall,
              isHeader: false,
              width: 2,
              isBack: false,
            ),
            MyCiel(
              text: double.parse(item!.itemCount).toStringAsFixed(2),
              style: Get.textTheme.displaySmall,
              isHeader: false,
              width: 2,
              isBack: false,
              color: inView
                  ? AppColorManger.greyLight
                  : (double.parse(item!.itemDone) <
                          (double.parse(item!.itemCount))
                      ? AppColorManger.red
                      : AppColorManger.greyLight),
            ),
            MyCiel(
              text: double.parse(item!.itemDone).toStringAsFixed(2),
              style: Get.textTheme.displaySmall,
              isHeader: false,
              width: 2,
              isBack: false,
            ),
            MyCiel(
              text: double.parse(item!.itemQuantWight).toStringAsFixed(2),
              style: Get.textTheme.displaySmall,
              isHeader: false,
              width: 2,
              isBack: false,
            ),
          ],
        );
      }
    } else {
      if (isHeader) {
        return Row(
          children: [
            MyCiel(
              text: name ?? AppStrings.name,
              style: Get.textTheme.displaySmall,
              isHeader: true,
              width: 2,
              isBack: name == null ? false : true,
              borderRadius: name != null
                  ? const BorderRadius.only(bottomRight: Radius.circular(20))
                  : BorderRadius.circular(0),
            ),
            MyCiel(
              text: code ?? 'code',
              style: Get.textTheme.displaySmall,
              isHeader: true,
              width: 2,
              isBack: code == null ? false : true,
            ),
            MyCiel(
              text: wanted ?? AppStrings.wanted,
              style: Get.textTheme.displaySmall,
              isHeader: true,
              width: 2,
              isBack: wanted == null ? false : true,
            ),
            inView
                ? MyCiel(
                    text: sub ?? AppStrings.doneExchange,
                    style: Get.textTheme.displaySmall,
                    isHeader: true,
                    width: 2,
                    isBack: sub == null ? false : true,
                  )
                : MyCiel(
                    text: sub ?? AppStrings.sub,
                    style: Get.textTheme.displaySmall,
                    isHeader: true,
                    width: 2,
                    isBack: sub == null ? false : true,
                  ),
            inView
                ? MyCiel(
                    text: main ?? AppStrings.usedFactory,
                    style: Get.textTheme.displaySmall,
                    isHeader: true,
                    width: 2,
                    isBack: main == null ? false : true,
                  )
                : MyCiel(
                    text: main ?? AppStrings.main,
                    style: Get.textTheme.displaySmall,
                    isHeader: true,
                    width: 2,
                    isBack: main == null ? false : true,
                    borderRadius: main != null
                        ? const BorderRadius.only(
                            bottomLeft: Radius.circular(20))
                        : BorderRadius.circular(0),
                  ),
          ],
        );
      } else {
        if (!inView) {
          (double.parse(item!.itemCount) >
                  (double.parse(item!.itemQuant) +
                      double.parse(item!.itemSubQuant)))
              ? subStockCartController.isFound![index] = true
              : false;
        }
        return Row(
          children: [
            MyCiel(
              text: item!.itemName.maxLength(8),
              style: Get.textTheme.displaySmall,
              isHeader: false,
              width: 2,
              isBack: false,
            ),
            MyCiel(
              text: item!.itemNum.maxLength(10),
              style: Get.textTheme.displaySmall,
              isHeader: false,
              width: 2,
              isBack: false,
            ),
            MyCiel(
              text: double.parse(item!.itemCount).toStringAsFixed(3),
              style: Get.textTheme.displaySmall,
              isHeader: false,
              width: 2,
              isBack: (double.parse(item!.itemCount) >
                      (double.parse(item!.itemQuant) +
                          double.parse(item!.itemSubQuant))
                  ? true
                  : false),
              color: inView
                  ? AppColorManger.greyLight
                  : (double.parse(item!.itemCount) >
                          (double.parse(item!.itemQuant) +
                              double.parse(item!.itemSubQuant))
                      ? AppColorManger.red
                      : AppColorManger.greyLight),
            ),
            inView
                ? MyCiel(
                    text: double.parse(item!.itemExchange).toStringAsFixed(3),
                    style: Get.textTheme.displaySmall,
                    isHeader: false,
                    width: 2,
                    isBack: false,
                  )
                : MyCiel(
                    text: double.parse(item!.itemSubQuant).toStringAsFixed(3),
                    style: Get.textTheme.displaySmall,
                    isHeader: false,
                    width: 2,
                    isBack: false,
                  ),
            inView
                ? MyCiel(
                    text: double.parse(item!.itemUsed).toStringAsFixed(3),
                    style: Get.textTheme.displaySmall,
                    isHeader: false,
                    width: 2,
                    isBack: false,
                  )
                : MyCiel(
                    text: double.parse(item!.itemQuant).toStringAsFixed(3),
                    style: Get.textTheme.displaySmall,
                    isHeader: false,
                    width: 2,
                    isBack: false,
                  ),
          ],
        );
      }
    }
  }
}
