import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/utils.dart';
import '../../../../components/components.dart';

class LanguageItemWidget extends StatelessWidget {
  final bool? isChecked;
  final String? text;
  final String? imageUrl;
  final Function()? onPress;

  const LanguageItemWidget({
    Key? key,
    this.isChecked,
    this.text,
    this.imageUrl,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = LocalStorage.instance.getAppThemeMode();
    return Padding(
      padding: REdgeInsets.only(bottom: 8),
      child: TextButton(
        style: ButtonStyle(
          padding:
              MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
        ),
        onPressed: onPress,
        child: Container(
          width: 1.sw - 30,
          height: 60.r,
          padding: REdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: isDarkMode
                    ? const Color.fromRGBO(23, 27, 32, 0.13)
                    : const Color.fromRGBO(169, 169, 150, 0.13),
                offset: const Offset(0, 1),
                blurRadius: 2,
                spreadRadius: 0,
              )
            ],
            color: isDarkMode
                ? const Color.fromRGBO(37, 48, 63, 1)
                : const Color.fromRGBO(255, 255, 255, 1),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            children: <Widget>[
              CustomCheckBox(isChecked: isChecked),
              Container(
                height: 15.r,
                width: 20.r,
                margin: REdgeInsets.only(left: 20, right: 8),
                child: CommonImage(
                  imageUrl: imageUrl,
                  height: 15,
                  width: 20,
                  radius: 0,
                ),
              ),
              Text(
                '$text',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  letterSpacing: -0.5,
                  color: isDarkMode
                      ? const Color.fromRGBO(255, 255, 255, 1)
                      : const Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
