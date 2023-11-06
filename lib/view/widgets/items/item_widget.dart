import '../../../data/models/items/item_model.dart';
import '../../../libraries.dart';

class MyItemWidget extends StatelessWidget {
  const MyItemWidget({super.key, required this.item});
  final Item item;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.h05,
      padding: EdgeInsets.symmetric(horizontal: AppSizes.w02),
      color: AppColorManger.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${AppStrings.name} : ${item.itemName}',
            style: context.textTheme.displaySmall,
          ),
          Text(
            '${AppStrings.code} : ${item.itemNum}',
            style: context.textTheme.displaySmall,
          ),
        ],
      ),
    );
  }
}
