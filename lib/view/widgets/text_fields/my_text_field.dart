import '../../../libraries.dart';

class MyTextField extends StatelessWidget {
  const MyTextField(
      {Key? key,
      this.sufIcon,
      this.label,
      this.hint,
      this.controller,
      required this.hidePassword,
      this.keyboard,
      this.readOnly,
      required this.validate,
      this.onSubmite,
      this.onChanged,
      this.preIcon,
      this.maxLines})
      : super(key: key);
  final TextEditingController? controller;
  final Widget? sufIcon; //sufIcon
  final Widget? preIcon; //
  final int? maxLines;
  final String? label;
  final String? hint;
  final bool hidePassword;
  final bool? readOnly;
  final Function? validate;
  final TextInputType? keyboard;
  final Function(String)? onSubmite;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.w01),
        color: AppColorManger.white,
        // border: Border.all(color: Get.theme.primaryColor, width: 2)
      ),
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        validator: (value) => validate!(value),
        onFieldSubmitted: onSubmite,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        style: context.textTheme.displayMedium!,
        controller: controller,
        autocorrect: true,
        cursorColor: Get.theme.primaryColor,
        cursorWidth: 2,
        showCursor: true,
        keyboardType: keyboard,
        readOnly: readOnly == null ? false : true,
        obscureText: hidePassword,
        textCapitalization: TextCapitalization.sentences,
        maxLines: maxLines ?? 1,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: const EdgeInsets.all(1),
          errorStyle: context.textTheme.displaySmall!
              .copyWith(color: AppColorManger.red),
          label: Text(label!, style: context.textTheme.displayMedium!),
          floatingLabelStyle: context.textTheme.displaySmall,
          hintText: hint,
          hintStyle: context.textTheme.displaySmall!
              .copyWith(color: AppColorManger.grey),
          suffixIcon: preIcon,
          prefixIcon: sufIcon ?? const Text(''),
          suffixIconColor: Get.theme.primaryColor,
          prefixIconColor: Get.theme.primaryColor,
          filled: true,
          fillColor: AppColorManger.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.w01),
            borderSide: BorderSide(color: Get.theme.primaryColor, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.w01),
            borderSide: BorderSide(color: Get.theme.primaryColor, width: 2),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.w01),
            borderSide: BorderSide(color: Get.theme.primaryColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.w01),
            borderSide: BorderSide(color: Get.theme.primaryColor, width: 2),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.w01),
            borderSide: const BorderSide(color: AppColorManger.red, width: 2),
          ),
          errorBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.w01),
            borderSide: const BorderSide(color: AppColorManger.red, width: 2),
          ),
        ),
      ),
    );
  }
}
