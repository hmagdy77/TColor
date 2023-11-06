import '../../../data/models/items/item_model.dart';
import '../../../libraries.dart';
import '../items/table_ciel.dart';

class BillShortageTableItem extends StatelessWidget {
  BillShortageTableItem({
    super.key,
    this.item,
    required this.isHeader,
  });
  final Item? item;
  final bool isHeader;
  final MyService myService = Get.find();

  @override
  Widget build(BuildContext context) {
    if (isHeader) {
      return const Center(
          child: Row(
        children: [
          MyCiel(
            isBack: false,
            isHeader: true,
            width: 2,
            text: AppStrings.itemName,
          ),
          MyCiel(
            isBack: false,
            isHeader: true,
            width: 2,
            text: AppStrings.itemNum,
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
        ],
      ));
    } else {
      return Row(
        children: [
          MyCiel(
            isBack: false,
            isHeader: false,
            width: 2,
            text: item!.itemName,
          ),
          MyCiel(
            isBack: false,
            isHeader: false,
            width: 2,
            text: item!.itemNum,
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
        ],
      );
    }
  }
}
