import '../../../data/models/items/item_model.dart';
import '../../../libraries.dart';
import '../items/table_ciel.dart';

class BillFactoryTableItem extends StatelessWidget {
  BillFactoryTableItem({
    super.key,
    this.item,
    required this.isHeader,
    required this.kind,
    required this.inDayReport,
  });
  final Item? item;
  final String? kind;
  final bool isHeader;
  final bool inDayReport;

  final MyService myService = Get.find();

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
          MyCiel(
            isBack: false,
            isHeader: true,
            width: 3,
            text: kind == AppStrings.components
                ? AppStrings.usedFactory
                : AppStrings.doneFactory,
          ),
          kind == AppStrings.components
              ? const SizedBox()
              : const MyCiel(
                  isBack: false,
                  isHeader: true,
                  width: 3,
                  text: AppStrings.wight,
                ),
          inDayReport
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
            text: inDayReport ? item!.itemMin : item!.itemUsed,
          ),
          kind == AppStrings.components
              ? const SizedBox()
              : MyCiel(
                  isBack: false,
                  isHeader: true,
                  width: 3,
                  text: item!.itemQuantWight,
                ),
          inDayReport
              ? const SizedBox()
              : MyCiel(
                  isBack: false,
                  isHeader: false,
                  width: 2,
                  text: double.parse(item!.itemQuant).toStringAsFixed(3),
                  color: (double.parse(item!.itemQuant) > 0)
                      ? AppColorManger.grey
                      : AppColorManger.red,
                ),
        ],
      );
    }
  }
}
