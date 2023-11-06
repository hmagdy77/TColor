import '../../../libraries.dart';

class MyLottieInternet extends StatelessWidget {
  const MyLottieInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/lottie/internet.json',
        width: AppSizes.w3,
        height: AppSizes.h3,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
