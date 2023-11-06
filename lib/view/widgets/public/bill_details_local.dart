import 'package:intl/intl.dart';

import '../../../data/models/bills/bill_model.dart';
import '../../../libraries.dart';
import '../items/table_ciel.dart';

class BillDetailsLocal extends StatelessWidget {
  const BillDetailsLocal({super.key, required this.bill, required this.label});
  final Bill bill;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            label,
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
                  '${DateFormat.yMMMMEEEEd('ar').format(bill.billTimestamp)}   ${DateFormat.jm('ar').format(bill.billTimestamp)}',
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
              text: '${AppStrings.total} : ${bill.billTotal}',
              isHeader: true,
              width: 1,
              isBack: false,
            ),
            MyCiel(
              text: '${AppStrings.notes} : ${bill.billNotes}',
              isHeader: true,
              width: 2,
              isBack: false,
            ),
          ],
        ),
      ],
    );
  }
}
