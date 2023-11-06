import '../../../libraries.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
  final MyService myService = Get.find();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  _goNext() {
    var key = widget.myService.sharedPreferences.getInt(AppStrings.adminKey);

    if (key == 0 || key == null) {
      Get.offNamed(AppRoutes.loginScreen);
    } else {
      Get.offNamed(AppRoutes.mainScreen);
    }
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColorManger.primary,
      body: Center(
        child: Image(
          image: AssetImage('assets/images/home.png'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
}
