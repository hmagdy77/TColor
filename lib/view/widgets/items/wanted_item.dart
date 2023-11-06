import '../../../controllers/plans/plan_item_controller.dart';
import '../../../data/models/items/item_model.dart';
import '../../../libraries.dart';
import 'table_ciel.dart';

// ignore: must_be_immutable
class WantedItem extends StatefulWidget {
  const WantedItem({
    Key? key,
    this.item,
    required this.index,
    required this.lenth,
    required this.isHeader,
  }) : super(key: key);
  final int index;
  final Item? item;
  final int lenth;
  final bool isHeader;

  @override
  State<WantedItem> createState() => _WantedItemState();
}

class _WantedItemState extends State<WantedItem> {
  final PlanItemControllerImp planItemController =
      Get.find<PlanItemControllerImp>();

  @override
  Widget build(BuildContext context) {
    if (widget.isHeader) {
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
            text: AppStrings.doneExchange,
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
    } else {
      // if ((double.parse(widget.item!.itemCount) -
      //         double.parse(widget.item!.itemSubQuant)) <=
      //     0) {
      //   return const SizedBox();
      // } else {
      //  }

      Color widgetColor = (double.parse(widget.item!.itemCount) -
                  double.parse(widget.item!.itemSubQuant)) ==
              double.parse(widget.item!.itemExchange)
          ? Colors.green
          : (double.parse(widget.item!.itemCount) -
                      double.parse(widget.item!.itemSubQuant)) <
                  double.parse(widget.item!.itemExchange)
              ? Colors.blue
              : AppColorManger.grey;
      return Container(
        decoration: BoxDecoration(
          color: planItemController.colorsBool[widget.index]
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
              isBack: !planItemController.colorsBool[widget.index],
              style: Get.textTheme.displaySmall,
              color: widgetColor,
            ),
            MyCiel(
              text: widget.item!.itemNum,
              isHeader: false,
              width: 2,
              isBack: !planItemController.colorsBool[widget.index],
              style: Get.textTheme.displaySmall,
              color: widgetColor,
            ),
            MyCiel(
              text: (double.parse(widget.item!.itemCount) -
                      double.parse(widget.item!.itemSubQuant))
                  .toString()
                  .maxLength(8),
              isHeader: false,
              width: 2,
              isBack: !planItemController.colorsBool[widget.index],
              style: Get.textTheme.displaySmall,
              color: widgetColor,
            ),
            MyCiel(
              text: widget.item!.itemExchange,
              isHeader: false,
              width: 2,
              isBack: !planItemController.colorsBool[widget.index],
              style: Get.textTheme.displaySmall,
              color: widgetColor,
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () {
                  setState(
                    () {
                      planItemController.colorsBool[widget.index] =
                          !planItemController.colorsBool[widget.index];
                    },
                  );
                },
                icon: planItemController.colorsBool[widget.index]
                    ? const Icon(Icons.check_box)
                    : const Icon(Icons.check_box_outline_blank),
              ),
            ),
            // MyCiel(
            //   text: '',
            //   isHeader: false,
            //   width: 1,
            //   isBack: !planItemController.colorsBool[widget.index],
            //   padding: const EdgeInsets.all(6),
            // ),
          ],
        ),
      );
    }
  }
}
