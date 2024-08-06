import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../core/constants/constants.dart';
import '../../../../../../../core/utils/utils.dart';
import '../../../../../../components/components.dart';
import '../../../../../../theme/theme.dart';
import '../riverpod/provider/checkout_payments_provider.dart';

class PaymentBody extends StatelessWidget {
  const PaymentBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mainAppbarBack(),
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          24.verticalSpace,
          Text(
            AppHelpers.getTranslation(TrKeys.paymentMethods),
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              letterSpacing: -0.4,
              color: AppColors.secondaryIconTextColor(),
            ),
          ),
          14.verticalSpace,
          Consumer(
            builder: (context, ref, child) {
              final state = ref.watch(checkoutPaymentsProvider);
              final notifier = ref.read(checkoutPaymentsProvider.notifier);
              return state.isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3.r,
                        color: AppColors.green,
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: state.payments.length,
                      itemBuilder: (context, index) {
                        return CheckoutPaymentItem(
                          payment: state.payments[index],
                          isSelected: state.selectedPaymentIndex == index,
                          onTap: () {
                            notifier.setSelectedPayment(index);
                          },
                        );
                      },
                    );
            },
          ),
        ],
      ),
    );
  }
}
