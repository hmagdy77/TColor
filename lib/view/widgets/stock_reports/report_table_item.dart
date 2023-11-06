import '../../../data/models/items/item_model.dart';
import '../../../libraries.dart';
import '../items/table_ciel.dart';

class ReporTableItem extends StatelessWidget {
  ReporTableItem({
    super.key,
    this.item,
    required this.isHeader,
    required this.kind,
  });
  final Item? item;
  final bool isHeader;
  final String kind;
  final MyService myService = Get.find();

  @override
  Widget build(BuildContext context) {
    if (kind == AppStrings.products) {
      if (isHeader) {
        return const Center(
          child: Row(
            children: [
              MyCiel(
                isBack: false,
                isHeader: true,
                width: 4,
                text: AppStrings.itemName,
              ),
              MyCiel(
                isBack: false,
                isHeader: true,
                width: 3,
                text: AppStrings.itemNum,
                color: AppColorManger.grey,
              ),
              MyCiel(
                isBack: false,
                isHeader: true,
                width: 3,
                text: AppStrings.billOut,
              ),
              MyCiel(
                isBack: false,
                isHeader: true,
                width: 3,
                text: AppStrings.backBillOut,
                color: AppColorManger.grey,
              ),
              MyCiel(
                isBack: false,
                isHeader: true,
                width: 3,
                text: AppStrings.theFactory,
              ),
              MyCiel(
                isBack: false,
                isHeader: true,
                width: 3,
                text: AppStrings.thePlus,
                color: AppColorManger.grey,
              ),
              MyCiel(
                isBack: false,
                isHeader: true,
                width: 3,
                text: AppStrings.theMinus,
              ),
              MyCiel(
                isBack: false,
                isHeader: true,
                width: 3,
                text: AppStrings.currentValue,
                color: AppColorManger.grey,
              ),
            ],
          ),
        );
      } else {
        return Row(
          children: [
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 4,
              text: item!.itemName,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 3,
              text: item!.itemNum,
              color: AppColorManger.grey,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 3,
              text: item!.itemMin,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 3,
              text: item!.itemMax,
              color: AppColorManger.grey,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 3,
              text: item!.itemUsed,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 3,
              text: item!.billId,
              color: AppColorManger.grey,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 3,
              text: item!.stockId,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 3,
              text: double.parse(item!.itemQuant).toStringAsFixed(3),
              color: (double.parse(item!.itemQuant) > 0)
                  ? AppColorManger.grey
                  : AppColorManger.red,
            ),
          ],
        );
      }
    } else if (kind == AppStrings.components) {
      if (isHeader) {
        return const Center(
            child: Row(
          children: [
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 3,
              text: AppStrings.itemName,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 3,
              text: AppStrings.itemNum,
              color: AppColorManger.grey,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: AppStrings.billIn,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: AppStrings.back,
              color: AppColorManger.grey,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: AppStrings.billOut,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: AppStrings.back,
              color: AppColorManger.grey,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: AppStrings.billStock,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: AppStrings.back,
              color: AppColorManger.grey,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: AppStrings.thePlus,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: AppStrings.theMinus,
              color: AppColorManger.grey,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: AppStrings.currentValue,
            ),
          ],
        ));
      } else {
        return Row(
          children: [
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 3,
              text: item!.itemName,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 3,
              text: item!.itemNum,
              color: AppColorManger.grey,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 2,
              text: item!.itemPriceIn,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 2,
              text: item!.itemPriceOut,
              color: AppColorManger.grey,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 2,
              text: item!.itemMin,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 2,
              text: item!.itemMax,
              color: AppColorManger.grey,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 2,
              text: item!.itemExchange,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 2,
              text: item!.itemDone,
              color: AppColorManger.grey,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 2,
              text: item!.billId,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 2,
              text: item!.stockId,
              color: AppColorManger.grey,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 2,
              text: double.parse(item!.itemQuant).toStringAsFixed(3),
              color: (double.parse(item!.itemQuant) > 0)
                  ? AppColorManger.white
                  : AppColorManger.red,
            ),
          ],
        );
      }
    } else {
      if (isHeader) {
        return const Center(
            child: Row(
          children: [
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 3,
              text: AppStrings.itemName,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 3,
              text: AppStrings.itemNum,
              color: AppColorManger.grey,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: AppStrings.billStock,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: AppStrings.back,
              color: AppColorManger.grey,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: AppStrings.usedFactory,
            ),
            MyCiel(
              isBack: false,
              isHeader: true,
              width: 2,
              text: AppStrings.currentValue,
              color: AppColorManger.grey,
            ),
          ],
        ));
      } else {
        return Row(
          children: [
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 3,
              text: item!.itemName,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 3,
              text: item!.itemNum,
              color: AppColorManger.grey,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 2,
              text: item!.itemExchange,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 2,
              text: item!.itemDone,
              color: AppColorManger.grey,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 2,
              text: item!.itemUsed,
            ),
            MyCiel(
              isBack: false,
              isHeader: false,
              width: 2,
              text: double.parse(item!.itemSubQuant).toStringAsFixed(3),
              color: (double.parse(item!.itemSubQuant) > 0)
                  ? AppColorManger.grey
                  : AppColorManger.red,
            ),
          ],
        );
      }
    }
  }
}
