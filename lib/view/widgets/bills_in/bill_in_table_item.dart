import '../../../controllers/items/item_controller.dart';
import '../../../data/models/items/item_model.dart';
import '../../../libraries.dart';
import '../items/table_ciel.dart';

class BillInTableItem extends StatelessWidget {
  BillInTableItem({
    super.key,
    this.item,
    required this.isHeader,
    required this.isInDay,
  });
  final Item? item;
  final bool isHeader;
  final MyService myService = Get.find();
  final ItemControllerImp itemController = Get.put(ItemControllerImp());
  final bool isInDay;
  @override
  Widget build(BuildContext context) {
    if (isHeader) {
      return Center(
          child: Row(
        children: [
          const MyCiel(
            isBack: false,
            isHeader: true,
            width: 3,
            text: AppStrings.itemName,
          ),
          const MyCiel(
            isBack: false,
            isHeader: true,
            width: 3,
            text: AppStrings.itemNum,
            color: AppColorManger.grey,
          ),
          const MyCiel(
            isBack: false,
            isHeader: true,
            width: 3,
            text: AppStrings.itemPriceIn,
          ),
          const MyCiel(
            isBack: false,
            isHeader: true,
            width: 2,
            text: AppStrings.billIn,
            color: AppColorManger.grey,
          ),
          const MyCiel(
            isBack: false,
            isHeader: true,
            width: 2,
            text: AppStrings.total,
          ),
          const MyCiel(
            isBack: false,
            isHeader: true,
            width: 2,
            text: AppStrings.back,
            color: AppColorManger.grey,
          ),
          const MyCiel(
            isBack: false,
            isHeader: true,
            width: 2,
            text: AppStrings.total,
          ),
          isInDay
              ? const SizedBox()
              : const MyCiel(
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
            width: 3,
            text: item!.itemPriceIn,
          ),
          MyCiel(
            isBack: false,
            isHeader: false,
            width: 2,
            text: item!.itemMin,
            color: AppColorManger.grey,
          ),
          MyCiel(
            isBack: false,
            isHeader: false,
            width: 2,
            text:
                (double.parse(item!.itemPriceIn) * double.parse(item!.itemMin))
                    .toStringAsFixed(2),
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
            text:
                (double.parse(item!.itemPriceIn) * double.parse(item!.itemMax))
                    .toStringAsFixed(2),
          ),
          isInDay
              ? const SizedBox()
              : MyCiel(
                  isBack: false,
                  isHeader: false,
                  width: 2,
                  text: item!.itemQuant,
                  color: (double.parse(item!.itemQuant) > 0)
                      ? AppColorManger.grey
                      : AppColorManger.red,
                ),
        ],
      );
    }
  }
}
