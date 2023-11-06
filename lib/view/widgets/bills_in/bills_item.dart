import '../../../data/models/bills/bill_model.dart';
import '../../../libraries.dart';

class BillItem extends StatelessWidget {
  const BillItem({super.key, required this.bill, required this.isBillIn});
  final Bill bill;
  final bool isBillIn;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: bill.kind == 1 ? AppColorManger.primary : AppColorManger.grey,
      // height: AppSizes.h05,
      margin: EdgeInsets.symmetric(
        horizontal: AppSizes.w01,
        vertical: 5,
      ),
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
          isBillIn
              ? Text(
                  '${AppStrings.supName} : ${bill.billSup.toString()}',
                  style: context.textTheme.bodySmall,
                )
              : Text(
                  '${AppStrings.agentName} : ${bill.agentName.toString()}',
                  style: context.textTheme.bodySmall,
                ),
          const Spacer(),
          Text(
            '${AppStrings.billTotal} :  ${bill.billTotal.toString()}',
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
