import '../../../data/models/sup/sup_model.dart';
import '../../../libraries.dart';

class MySupWidget extends StatelessWidget {
  const MySupWidget({super.key, required this.sup});
  final Sup sup;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.h05,
      padding: EdgeInsets.symmetric(horizontal: AppSizes.w1),
      color: AppColorManger.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${AppStrings.idNumber} : ${sup.supId}',
            style: context.textTheme.bodySmall,
          ),
          Text(
            '${AppStrings.supName} : ${sup.supName}',
            style: context.textTheme.bodySmall,
          ),
          Text(
            '${AppStrings.supTel} : ${sup.supTel}',
            style: context.textTheme.bodySmall,
          )
        ],
      ),
    );
  }
}
