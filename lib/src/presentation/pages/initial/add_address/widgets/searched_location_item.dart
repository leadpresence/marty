import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:osm_nominatim/osm_nominatim.dart';

import '../../../../theme/theme.dart';

class SearchedLocationItem extends StatelessWidget {
  final Place place;
  final bool isLast;
  final Function() onTap;

  const SearchedLocationItem({
    Key? key,
    required this.place,
    required this.onTap,
    required this.isLast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: AppColors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Column(
              children: [
                20.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        place.displayName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          letterSpacing: -0.4,
                          color: AppColors.iconAndTextColor(),
                        ),
                      ),
                    ),
                    8.horizontalSpace,
                    Icon(
                      FlutterRemix.arrow_left_up_line,
                      color: AppColors.iconAndTextColor(),
                      size: 20.r,
                    ),
                  ],
                ),
                20.verticalSpace,
              ],
            ),
          ),
        ),
        if (!isLast)
          Divider(
            color: AppColors.secondaryIconTextColor().withOpacity(0.2),
            thickness: 1.r,
            height: 1.r,
          ),
      ],
    );
  }
}
