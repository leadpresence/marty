import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/utils.dart';
import '../../../models/models.dart';
import '../../theme/theme.dart';
import '../common_image.dart';

class CartTotalProductItem extends StatelessWidget {
  final ProductData? product;

  const CartTotalProductItem({Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasDiscount =
        product?.discount != null && ((product?.discount ?? 0) > 0);
    final discountPrice =
        hasDiscount ? ((product?.price ?? 0) - (product?.discount ?? 0)) : 0;
    return Padding(
      padding: REdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          CommonImage(
            imageUrl: product?.product?.img,
            width: 52,
            height: 52,
            radius: 0,
          ),
          24.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${product?.product?.translation?.title}',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    letterSpacing: -0.4,
                    color: AppColors.iconAndTextColor(),
                  ),
                ),
                3.verticalSpace,
                Row(
                  children: [
                    Text(
                      NumberFormat.currency(
                        symbol:
                            LocalStorage.instance.getSelectedCurrency()?.symbol,
                      ).format(hasDiscount ? discountPrice : product?.price),
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                        letterSpacing: -0.4,
                        color: AppColors.iconAndTextColor(),
                      ),
                    ),
                    9.horizontalSpace,
                    Icon(
                      FlutterRemix.close_fill,
                      size: 16.r,
                      color: AppColors.iconAndTextColor(),
                    ),
                    9.horizontalSpace,
                    Text(
                      '${product?.qty}',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                        letterSpacing: -0.4,
                        color: AppColors.iconAndTextColor(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
