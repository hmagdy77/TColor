import '../../../data/models/bills/bill_model.dart';
import '../../../libraries.dart';

class BillShortageItem extends StatelessWidget {
  const BillShortageItem({super.key, required this.bill});
  final Bill bill;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: bill.kind == 1 ? AppColorManger.primary : AppColorManger.grey,
      margin: EdgeInsets.symmetric(horizontal: AppSizes.w01, vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: AppSizes.w05,
          ),
          Text(
            '${AppStrings.billNumper} : ${bill.billId.toString()}',
            style: context.textTheme.bodySmall,
          ),
          const Spacer(),
          Text(
            '${AppStrings.numberOfitems} :  ${bill.billItems.toString()}',
            style: context.textTheme.bodySmall,
          ),
          const Spacer(),
          Text(
            '${AppStrings.billDate} : ${bill.billTimestamp.year} - ${bill.billTimestamp.month} - ${bill.billTimestamp.day}',
            style: context.textTheme.bodySmall,
          ),
          SizedBox(
            width: AppSizes.w05,
          ),
        ],
      ),
    );
  }
}
