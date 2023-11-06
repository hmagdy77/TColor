import '../../../data/models/items/item_model.dart';
import '../../../libraries.dart';
import '../items/table_ciel.dart';

class ViewBillFactoryItem extends StatelessWidget {
  const ViewBillFactoryItem({
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
              text: double.parse(item!.itemCount).toStringAsFixed(3),
              style: Get.textTheme.displaySmall,
              isHeader: false,
              width: 2,
              isBack: false,
            ),
            MyCiel(
              text: double.parse(item!.itemQuantWight).toStringAsFixed(3),
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
              text: AppStrings.usedFactory,
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
              text: double.parse(item!.itemCount).toStringAsFixed(3),
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
