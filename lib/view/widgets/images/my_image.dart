import '../../../libraries.dart';

class MyImage extends StatelessWidget {
  const MyImage({
    super.key,
    required this.url,
    this.width,
    this.height, //this.border
  });
  final String url;
  final double? width;
  final double? height;
  //final BorderRadiusGeometry? border;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          // topLeft: Radius.circular(AppSizes.h04),
          // topRight: Radius.circular(AppSizes.h04),
          // ),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
          ),
        ),
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.black12,
        highlightColor: Colors.black26,
        enabled: true,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(AppSizes.h01),
          ),
          // height: AppSizes.h1,
          // margin: EdgeInsets.all(AppSizes.h01),
        ),
      ),
      errorWidget: (context, url, error) => Center(
        child: Lottie.asset(
          'assets/lottie/questions.json',
          // width: AppSizes.w08,
          // height: AppSizes.w08,
        ),
      ),
    );
  }
}
