import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';

class UserAddressAppBar extends StatelessWidget {
  final double height;
  final double searchHeight;
  final String? address;
  final Function() onChangeTap;
  final Function(String) onTextFieldChange;

  const UserAddressAppBar({
    Key? key,
    required this.height,
    required this.searchHeight,
    this.address,
    required this.onChangeTap,
    required this.onTextFieldChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            color: AppColors.mainAppbar(),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 2),
                blurRadius: 2.r,
                spreadRadius: 0,
                color: AppColors.mainAppbarShadow(),
              ),

            ],
          ),
          alignment: Alignment.bottomCenter,
          padding: REdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      height: 34.r,
                      width: 34.r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17.r),
                        color: AppColors.green,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        FlutterRemix.map_pin_2_fill,
                        color: AppColors.white,
                        size: 16.r,
                      ),
                    ),
                    8.horizontalSpace,
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppHelpers.getTranslation(TrKeys.deliveryAddress),
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.iconAndTextColorAppbar(),
                            letterSpacing: -0.5,
                          ),
                        ),
                        2.verticalSpace,
                        Text(
                          '$address',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300,
                            color: AppColors.white
                            ,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Material(
                borderRadius: BorderRadius.circular(100.r),
                color: AppColors.green,
                child: InkWell(
                  borderRadius: BorderRadius.circular(100.r),
                  onTap: onChangeTap,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    alignment: Alignment.center,
                    height: 30.r,
                    padding: REdgeInsets.symmetric(horizontal: 13),
                    child: Text(
                      AppHelpers.getTranslation(TrKeys.change),
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(16.0),
        height: 90,
          decoration: BoxDecoration(
            color: AppColors.darkGreen,
          ),
          child: Container(
            padding: EdgeInsets.all(12.0),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.secondaryBack(),
              borderRadius: BorderRadius.circular(20)
            ),
            child: SearchTextField(
              hintText: AppHelpers.getTranslation(TrKeys.searchplus),
              onChanged: onTextFieldChange,
            ),
          ),
        ),
      ],
    );
  }
}
