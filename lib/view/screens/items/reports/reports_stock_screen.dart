import '../../../../libraries.dart';
import '../../../widgets/menus/upper_widget.dart';
import 'components_tab.dart';
import 'products_tab.dart';
import 'sub_stock_tab.dart';

class ReportsStockScreen extends StatelessWidget {
  const ReportsStockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            UpperWidget(
              isAdminScreen: false,
              onPressed: () {},
            ),
            Expanded(
              child: MyContainer(
                content: Column(
                  children: [
                    const Text(AppStrings.stockReports),
                    SizedBox(
                      height: AppSizes.h02,
                    ),
                    TabBar(
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: AppColorManger.white,
                        border: Border.all(
                          width: 2,
                          color: AppColorManger.black,
                        ),
                      ),
                      tabs: <Widget>[
                        Tab(
                          icon: Text(
                            AppStrings.components,
                            style: Get.textTheme.displayMedium,
                          ),
                        ),
                        Tab(
                          icon: Text(
                            AppStrings.products,
                            style: Get.textTheme.displayMedium,
                          ),
                        ),
                        Tab(
                          icon: Text(
                            AppStrings.subStock,
                            style: Get.textTheme.displayMedium,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Center(
                            child: ComponentsTab(),
                          ),
                          Center(
                            child: ProductsTab(),
                          ),
                          Center(
                            child: SubStockTab(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
