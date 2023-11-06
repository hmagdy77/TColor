import '../../../controllers/sub_stock/sub_stock_cart.dart';
import '../../../data/models/items/item_model.dart';
import '../../../libraries.dart';
import '../items/table_ciel.dart';

class WantedBillFactoryItem extends StatelessWidget {
  WantedBillFactoryItem({
    super.key,
    this.item,
    required this.isHeader,
    required this.isProudct,
    required this.index,
  });
  final Item? item;
  final bool isProudct;
  final bool isHeader;
  final int index;
  final SubStockCartControllerImp subStockCartController =
      Get.find<SubStockCartControllerImp>();

  @override
  Widget build(BuildContext context) {
    if (isProudct) {
      if (isHeader) {
        return Row(
          children: [
            MyCiel(
              text: AppStrings.name,
              style: Get.textTheme.displaySmall,
              isHeader: true,
              width: 2,
              isBack: false,
            ),
            MyCiel(
              text: 'code',
              style: Get.textTheme.displaySmall,
              isHeader: true,
              width: 2,
              isBack: false,
            ),
            MyCiel(
              text: AppStrings.wanted,
              style: Get.textTheme.displaySmall,
              isHeader: true,
              width: 2,
              isBack: false,
            ),
            MyCiel(
              text: AppStrings.doneFactory,
              style: Get.textTheme.displaySmall,
              isHeader: true,
              width: 2,
              isBack: false,
            ),
            MyCiel(
              text: AppStrings.wight,
              style: Get.textTheme.displaySmall,
              isHeader: true,
              width: 2,
              isBack: false,
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
              text: item!.itemCount.maxLength(8),
              style: Get.textTheme.displaySmall,
              isHeader: false,
              width: 2,
              isBack: false,
            ),
            MyCiel(
              text: item!.itemDone.maxLength(8),
              style: Get.textTheme.displaySmall,
              isHeader: false,
              width: 2,
              isBack: false,
            ),
            MyCiel(
              text: item!.itemQuantWight.maxLength(8),
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
              text: AppStrings.name,
              style: Get.textTheme.displaySmall,
              isHeader: true,
              width: 2,
              isBack: false,
            ),
            MyCiel(
              text: 'code',
              style: Get.textTheme.displaySmall,
              isHeader: true,
              width: 2,
              isBack: false,
            ),
            MyCiel(
              text: AppStrings.wanted,
              style: Get.textTheme.displaySmall,
              isHeader: true,
              width: 2,
              isBack: false,
            ),
            MyCiel(
              text: AppStrings.sub,
              style: Get.textTheme.displaySmall,
              isHeader: true,
              width: 2,
              isBack: false,
            ),
          ],
        );
      } else {
        (double.parse(item!.itemCount) > double.parse(item!.itemSubQuant))
            ? subStockCartController.isFound![index] = true
            : false;
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
              color: (double.parse(item!.itemCount) >
                      (double.parse(item!.itemSubQuant))
                  ? AppColorManger.red
                  : AppColorManger.greyLight),
            ),
            MyCiel(
              text: double.parse(item!.itemSubQuant).toStringAsFixed(3),
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
