import '../../../libraries.dart';

class MyLogo extends StatelessWidget {
  const MyLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage(AppImageAssets.logo),
      width: double.infinity,
    );
  }
}
