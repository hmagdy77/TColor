import '../../../libraries.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {Key? key, this.child, required this.label, required this.ontap})
      : super(key: key);

  final String label;
  final VoidCallback ontap;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(0),
      hoverColor: AppColorManger.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onPressed: ontap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        decoration: BoxDecoration(
          color: AppColorManger.backdark,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(AppSizes.h02),
            bottomRight: Radius.circular(AppSizes.h02),
            topLeft: Radius.circular(AppSizes.h02),
          ),
        ),
        child: child ??
            ListTile(
              title: Text(
                label,
                textAlign: TextAlign.center,
                style: context.textTheme.displayMedium!
                    .copyWith(color: AppColorManger.lightScaffold),
              ),
            ),
      ),
    );
  }
}
