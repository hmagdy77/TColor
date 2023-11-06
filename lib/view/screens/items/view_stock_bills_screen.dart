import '../../../../libraries.dart';
import '../../widgets/menus/upper_widget.dart';
import '../bills_shortage/search_bill_shortage_tab.dart';
import '../bills_stock/search_bill_stock_tab.dart';

class ViewStockBillsScreen extends StatelessWidget {
  const ViewStockBillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
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
                    const Text(AppStrings.stockBills),
                    SizedBox(
                      height: AppSizes.h02,
                    ),
                    TabBar(
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: AppColorManger.white,
                        border:
                            Border.all(width: 2, color: AppColorManger.black),
                      ),
                      tabs: <Widget>[
                        Tab(
                          icon: Text(
                            AppStrings.billsShortage,
                            style: Get.textTheme.displayMedium,
                          ),
                        ),
                        Tab(
                          icon: Text(
                            AppStrings.billsStock,
                            style: Get.textTheme.displayMedium,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Center(
                            child: SearchBillShortageTab(),
                          ),
                          Center(
                            child: SearchBillStockTab(),
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
