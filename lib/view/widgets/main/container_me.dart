import '../../../libraries.dart';

class ContainerMi extends StatelessWidget {
  const ContainerMi({
    super.key,
    this.content,
    this.color,
    this.margin,
    this.padding,
  });
  final Color? color;
  final Widget? content;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 45,
          child: Container(
            margin: margin ?? const EdgeInsets.symmetric(horizontal: 4),
            padding: padding ?? const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: color,
            ),
            child: content,
          ),
        ),
        const Spacer(
          flex: 1,
        ),
      ],
    );
  }
}
