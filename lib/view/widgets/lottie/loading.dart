import '../../../libraries.dart';

class MyLottieLoading extends StatelessWidget {
  const MyLottieLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/lottie/loading.json',
        width: AppSizes.w2,
        height: AppSizes.h2,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
