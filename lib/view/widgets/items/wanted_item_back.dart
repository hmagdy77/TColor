import '../../../controllers/items/item_controller.dart';
import '../../../data/models/items/item_model.dart';
import '../../../libraries.dart';
import 'table_ciel.dart';

class WantedItemBack extends StatefulWidget {
  const WantedItemBack({
    Key? key,
    this.item,
    required this.index,
    required this.kind,
  }) : super(key: key);
  final int index;
  final Item? item;
  final String kind;

  @override
  State<WantedItemBack> createState() => _WantedItemBackState();
}

class _WantedItemBackState extends State<WantedItemBack> {
  final ItemControllerImp itemController = Get.find<ItemControllerImp>();

  @override
  Widget build(BuildContext context) {
    if (widget.kind == AppStrings.header) {
      return Row(
        children: [
          MyCiel(
            text: AppStrings.name,
            isHeader: true,
            width: 2,
            style: Get.textTheme.displaySmall,
            isBack: false,
          ),
          MyCiel(
            text: AppStrings.code,
            isHeader: true,
            width: 2,
            isBack: false,
            style: Get.textTheme.displaySmall,
          ),
          MyCiel(
            text: AppStrings.itemQuantity,
            isHeader: true,
            width: 2,
            isBack: false,
            style: Get.textTheme.displaySmall,
          ),
          MyCiel(
            text: '',
            isHeader: true,
            width: 1,
            isBack: false,
            style: Get.textTheme.displaySmall,
          ),
        ],
      );
    } else if (widget.kind == AppStrings.body) {
      return Container(
        decoration: BoxDecoration(
          color: itemController.colorsBool[widget.index]
              ? AppColorManger.grey
              : AppColorManger.primary,
          border: Border.all(width: 2, color: AppColorManger.black),
        ),
        child: Row(
          children: [
            MyCiel(
              text: widget.item!.itemName,
              isHeader: false,
              width: 2,
              isBack: !itemController.colorsBool[widget.index],
              style: Get.textTheme.displaySmall,
            ),
            MyCiel(
              text: widget.item!.itemNum,
              isHeader: false,
              width: 2,
              isBack: !itemController.colorsBool[widget.index],
              style: Get.textTheme.displaySmall,
            ),
            MyCiel(
              text: double.parse(widget.item!.itemSubQuant)
                  .toString()
                  .maxLength(8),
              isHeader: false,
              width: 2,
              isBack: !itemController.colorsBool[widget.index],
              style: Get.textTheme.displaySmall,
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () {
                  setState(
                    () {
                      itemController.colorsBool[widget.index] =
                          !itemController.colorsBool[widget.index];
                    },
                  );
                },
                icon: itemController.colorsBool[widget.index]
                    ? const Icon(Icons.check_box)
                    : const Icon(Icons.check_box_outline_blank),
              ),
            ),
          ],
        ),
      );
    } else {
      return Row(
        children: [
          MyCiel(
            text: AppStrings.total,
            isHeader: true,
            width: 2,
            style: Get.textTheme.displaySmall,
            isBack: false,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(20),
            ),
          ),
          MyCiel(
            text: itemController.subStockItemsList.length.toString(),
            isHeader: true,
            width: 2,
            isBack: false,
            style: Get.textTheme.displaySmall,
          ),
          MyCiel(
            text: itemController.converter(
                quant: itemController.totalSubQuant.value.toString()),
            isHeader: true,
            width: 3,
            isBack: false,
            style: Get.textTheme.displaySmall,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
            ),
          ),
        ],
      );
    }
  }
}
