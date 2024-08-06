import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/routes/app_router.gr.dart';
import '../../../../../../core/utils/utils.dart';
import '../../../../../components/components.dart';
import '../../../../../theme/theme.dart';
import 'riverpod/provider/checkout_cart_provider.dart';
import 'riverpod/provider/checkout_deliveries_provider.dart';
import 'riverpod/provider/checkout_payments_provider.dart';
import 'riverpod/provider/checkout_provider.dart';
import 'riverpod/provider/coupon_provider.dart';
import 'riverpod/provider/order_provider.dart';
import 'widgets/checkout_status_widget.dart';
import 'widgets/payment_body.dart';
import 'widgets/shipping_body.dart';
import 'widgets/verify_body.dart';

class CheckoutPage extends ConsumerStatefulWidget {
  final int? shopId;
  final int? cartId;

  const CheckoutPage({Key? key, this.shopId, this.cartId}) : super(key: key);

  @override
  ConsumerState<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref
            .read(checkoutDeliveriesProvider.notifier)
            .fetchShopDeliveries(shopId: widget.shopId);
        ref
            .read(checkoutPaymentsProvider.notifier)
            .fetchPayments(shopId: widget.shopId);
        ref
            .read(checkoutCartProvider.notifier)
            .fetchCartCalculations(cartId: widget.cartId);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: AppColors.mainBackground(),
        extendBody: true,
        appBar: CommonAppBar(
          title: AppHelpers.getTranslation(TrKeys.checkout),
          onLeadingPressed: context.popRoute,
        ),
        body: Consumer(
          builder: (context, ref, child) {
            return Column(
              children: [
                CheckoutStatusWidget(
                  onPageChangeTap: (page) {
                    _pageController.animateToPage(
                      page,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                    ref.read(checkoutProvider.notifier).setActiveTab(page);
                  },
                ),
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    onPageChanged:
                        ref.read(checkoutProvider.notifier).setActiveTab,
                    children: [
                      const ShippingBody(),
                      const PaymentBody(),
                      VerifyBody(shopId: widget.shopId),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: REdgeInsets.only(left: 16, right: 16, bottom: 36),
          child: Consumer(
            builder: (context, ref, child) {
              final cartState = ref.watch(checkoutCartProvider);
              final orderState = ref.watch(orderProvider);
              final deliveriesState = ref.watch(checkoutDeliveriesProvider);
              return MainConfirmButton(
                title: AppHelpers.getTranslation(TrKeys.continueKey),
                isLoading: orderState.isLoading,
                onTap: () {
                  if (ref.watch(checkoutProvider).activeTab == 2) {
                    ref.read(orderProvider.notifier).createOrder(
                          coupon: ref.watch(couponProvider).coupon,
                          shopId: widget.shopId,
                          total:
                              cartState.calculateData?.orderTotal?.toDouble(),
                          deliveryTypeId: AppHelpers.getDeliveries(
                                      deliveriesState.shopDeliveries)[
                                  deliveriesState.selectedDeliveryTypeIndex]
                              .id,
                          deliveryFee: AppHelpers.getDeliveries(
                                      deliveriesState.shopDeliveries)[
                                  deliveriesState.selectedDeliveryTypeIndex]
                              .price
                              ?.toDouble(),
                          addressId: AppHelpers.getActiveLocalAddress()?.id,
                          totalDiscount: cartState.calculateData?.totalDiscount
                              ?.toDouble(),
                          tax: cartState.calculateData?.orderTax?.toDouble(),
                          deliveryDate: deliveriesState.isPickup
                              ? (deliveriesState.pickupDate != null
                                  ? DateFormat('yyyy-MM-dd')
                                      .format(deliveriesState.pickupDate!)
                                  : null)
                              : (deliveriesState.deliveryDate != null
                                  ? DateFormat('yyyy-MM-dd')
                                      .format(deliveriesState.deliveryDate!)
                                  : null),
                          deliveryTime: deliveriesState.deliveryTime == null
                              ? null
                              : DateFormat.Hm()
                                  .format(deliveriesState.deliveryTime!),
                          cartId: widget.cartId,
                          checkYourNetwork: () {
                            AppHelpers.showCheckFlash(
                              context,
                              AppHelpers.getTranslation(
                                  TrKeys.checkYourNetworkConnection),
                            );
                          },
                          orderSuccess: () {
                            context.router.popUntilRoot();
                            context.pushRoute(const OrderHistoryRoute());
                          },
                        );
                    return;
                  }
                  _pageController.animateToPage(
                    ref.watch(checkoutProvider).activeTab + 1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
