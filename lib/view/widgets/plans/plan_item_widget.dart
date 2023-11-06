import '../../../data/models/plans/plan_model.dart';
import '../../../libraries.dart';

class PlanItemWidget extends StatelessWidget {
  const PlanItemWidget({super.key, required this.plan});
  final Plans plan;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColorManger.primary,
      height: AppSizes.h05,
      margin: EdgeInsets.symmetric(horizontal: AppSizes.w01, vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: AppSizes.w05,
          ),
          Text(
            '${AppStrings.planNumper} : ${plan.id.toString()}',
            style: context.textTheme.bodySmall,
          ),
          const Spacer(),
          Text(
            '${AppStrings.planName} : ${plan.name.toString()}',
            style: context.textTheme.bodySmall,
          ),
          const Spacer(),
          Text(
            '${AppStrings.plandesc} : ${plan.des.toString()}',
            style: context.textTheme.bodySmall,
          ),
          const Spacer(),
          Text(
            '${AppStrings.date} : ${plan.date.year} - ${plan.date.month} - ${plan.date.day}',
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
