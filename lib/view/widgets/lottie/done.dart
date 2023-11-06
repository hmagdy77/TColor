import '../../../libraries.dart';

class MyLottieDone extends StatelessWidget {
  const MyLottieDone({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/lottie/done.json',
        width: AppSizes.w2,
        height: AppSizes.h2,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
