import '../../../libraries.dart';

class GoogleSign extends StatelessWidget {
  const GoogleSign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          child: CircleAvatar(
            backgroundColor: Get.theme.scaffoldBackgroundColor,
            backgroundImage: const AssetImage(AppImageAssets.google),
            radius: Sizes.height * .03,
          ),
          onTap: () {},
        ),
        GestureDetector(
          child: CircleAvatar(
            backgroundColor: Get.theme.scaffoldBackgroundColor,
            backgroundImage: const AssetImage(AppImageAssets.twitter),
            radius: Sizes.height * .03,
          ),
          onTap: () {},
        ),
        GestureDetector(
          child: CircleAvatar(
            backgroundColor: Get.theme.scaffoldBackgroundColor,
            backgroundImage: const AssetImage(AppImageAssets.facebook),
            radius: Sizes.height * .03,
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
