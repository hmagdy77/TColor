import '../../../libraries.dart';

class DrawerColumn extends StatelessWidget {
  const DrawerColumn({Key? key}) : super(key: key);
  // final AgentsControllerImp agentsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(10),
      color: context.theme.primaryColorDark,
      child: const SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // DrawerItem(
            //   label: AppStrings.news,
            //   ontap: () {
            //     Get.toNamed(AppRoutes.newsScreen);
            //   },
            // ),
            // DrawerItem(
            //   label: AppStrings.goldenOffers,
            //   ontap: () {
            //     Get.toNamed(AppRoutes.offerScreen);
            //   },
            // ),
            // DrawerItem(
            //   label: AppStrings.gallery,
            //   ontap: () {
            //     Get.toNamed(AppRoutes.galleryScreen);
            //   },
            // ),
            // DrawerItem(
            //   label: AppStrings.viedosLibrary,
            //   ontap: () {
            //     Get.toNamed(AppRoutes.videosScreen);
            //   },
            // ),
            // DrawerItem(
            //   label: AppStrings.activties,
            //   ontap: () {
            //     Get.toNamed(AppRoutes.activtiesScreen);
            //   },
            // ),
            // DrawerItem(
            //   label: AppStrings.contactUs,
            //   ontap: () {
            //     Get.toNamed(AppRoutes.contactScreen);
            //   },
            // ),
            // DrawerItem(
            //   label: AppStrings.suggestions,
            //   ontap: () {
            //     agentsController.name.clear();
            //     agentsController.phone.clear();
            //     agentsController.sug.clear();
            //     Get.toNamed(AppRoutes.suggestionsScreen);
            //   },
            // ),
            // DrawerItem(
            //   label: AppStrings.themeMode,
            //   ontap: () {
            //     Get.toNamed(AppRoutes.contactScreen);
            //   },
            //   child: SwitchListTile(
            //     activeColor: AppColorManger.primary,
            //     value: ThemeController().getDataFromBox(),
            //     onChanged: (value) {
            //       ThemeController().changeTheme();
            //     },
            //     title: Text(
            //       AppStrings.themeMode,
            //       textAlign: TextAlign.center,
            //       style: context.textTheme.displayMedium!
            //           .copyWith(color: AppColorManger.lightScaffold),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: AppSizes.h02,
            // ),
            // Container(
            //   width: double.infinity,
            //   color: context.theme.primaryColorDark,
            //   child: Column(
            //     children: [
            //       Text(
            //         AppStrings.aboutApp,
            //         textAlign: TextAlign.center,
            //         style: context.textTheme.displayMedium!
            //             .copyWith(decoration: TextDecoration.underline),
            //       ),
            //       SizedBox(
            //         height: AppSizes.h02,
            //       )
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
