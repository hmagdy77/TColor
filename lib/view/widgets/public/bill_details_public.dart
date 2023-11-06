import 'package:intl/intl.dart';

import '../../../data/models/bills/bill_model.dart';
import '../../../libraries.dart';
import '../items/table_ciel.dart';

class BillDetailsPublic extends StatelessWidget {
  const BillDetailsPublic({super.key, required this.bill, required this.kind});
  final Bill bill;
  final String kind;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kind == AppStrings.billIn
            ? Center(
                child: Text(
                  bill.kind == 1 ? AppStrings.billIn : AppStrings.backBillIn,
                ),
              )
            : Center(
                child: Text(
                  bill.kind == 1 ? AppStrings.billOut : AppStrings.backBillOut,
                ),
              ),
        //for height
        SizedBox(
          height: AppSizes.h04,
        ),
        //bill id and date and numberOfitems
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MyCiel(
              text: '${AppStrings.billNumper} : ${bill.billId.toString()}',
              isHeader: true,
              width: 1,
              isBack: false,
            ),
            MyCiel(
              text:
                  '${AppStrings.numberOfitems} : ${bill.billItems.toString()}',
              isHeader: true,
              width: 1,
              isBack: false,
            ),
            MyCiel(
              text:
                  '${DateFormat.yMMMMEEEEd('ar').format(bill.billTimestamp)}   ${DateFormat.jm('ar').format(bill.billTimestamp)}',
              isHeader: true,
              width: 1,
              isBack: false,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MyCiel(
              text: kind == AppStrings.billIn
                  ? '${AppStrings.supName} : ${bill.billSup}'
                  : '${AppStrings.agentName} : ${bill.billSup}',
              isHeader: true,
              width: 1,
              isBack: false,
            ),
            MyCiel(
              text: '${AppStrings.total} : ${bill.billTotal}',
              isHeader: true,
              width: 1,
              isBack: false,
            ),
            MyCiel(
              text: '${AppStrings.empName} : ${bill.workName}',
              isHeader: true,
              width: 1,
              isBack: false,
            ),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MyCiel(
              text: '${AppStrings.notes} : ${bill.billNotes}',
              isHeader: true,
              width: 1,
              isBack: false,
            ),
          ],
        ),
      ],
    );
  }
}
