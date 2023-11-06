import 'package:intl/intl.dart';

import '../../../data/models/plans/plan_model.dart';
import '../../../libraries.dart';
import '../items/table_ciel.dart';

class PlanDetails extends StatelessWidget {
  const PlanDetails({super.key, required this.plan});
  final Plans plan;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Text(
            AppStrings.plansView,
          ),
        ),
        //for height
        SizedBox(
          height: AppSizes.h04,
        ),

        //Plan id and date and numberOfitems
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MyCiel(
              text: '${AppStrings.planNumper} : ${plan.id.toString()}',
              isHeader: true,
              width: 1,
              isBack: false,
            ),
            MyCiel(
              text:
                  '${AppStrings.date} : ${DateFormat.yMMMMEEEEd('ar').format(plan.date)}',
              isHeader: true,
              width: 1,
              isBack: false,
            ),
            MyCiel(
              text: '${AppStrings.empName} : ${plan.workName}',
              isHeader: true,
              width: 1,
              isBack: false,
            ),
            MyCiel(
              text: '${AppStrings.planName} : ${plan.name}',
              isHeader: true,
              width: 1,
              isBack: false,
            ),
            MyCiel(
              text: '${AppStrings.plandesc} : ${plan.des}',
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
              text: '${AppStrings.products} : ${plan.proudcts}',
              isHeader: true,
              width: 1,
              isBack: false,
            ),
            MyCiel(
              text: '${AppStrings.doneFactory} : ${plan.proudctsDone}',
              isHeader: true,
              width: 1,
              isBack: false,
            ),
            MyCiel(
              text: '${AppStrings.components} : ${plan.components}',
              isHeader: true,
              width: 1,
              isBack: false,
            ),
            MyCiel(
              text: '${AppStrings.doneExchange} : ${plan.exghange}',
              isHeader: true,
              width: 1,
              isBack: false,
            ),
            MyCiel(
              text: '${AppStrings.usedFactory} : ${plan.componentsDone}',
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
