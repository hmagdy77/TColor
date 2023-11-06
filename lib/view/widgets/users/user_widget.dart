import '../../../data/models/users/user_model.dart';
import '../../../libraries.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.w1),
      color: AppColorManger.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${AppStrings.userName} : ${user.userName}',
            style: context.textTheme.bodySmall,
          ),
          user.userKind == 1
              ? Text(
                  '${AppStrings.primison} : ${AppStrings.manger}',
                  style: context.textTheme.bodySmall,
                )
              : Text(
                  '${AppStrings.primison} : ${AppStrings.employ}',
                  style: context.textTheme.bodySmall,
                ),
        ],
      ),
    );
  }
}
