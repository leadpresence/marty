import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../../../core/constants/constants.dart';
import '../../../../../../../core/routes/app_router.gr.dart';
import '../../../../../../../core/utils/utils.dart';
import '../../../../../../components/components.dart';
import '../../../../../../theme/theme.dart';
import '../../../../saved_locations/riverpod/provider/saved_locations_provider.dart';
import '../riverpod/provider/checkout_cart_provider.dart';
import '../riverpod/provider/checkout_deliveries_provider.dart';
import 'delivery_type_item.dart';
import 'select_delivery_type_button.dart';

class SelectDeliveriesBody extends StatelessWidget {
  const SelectDeliveriesBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(checkoutDeliveriesProvider);
        final notifier = ref.read(checkoutDeliveriesProvider.notifier);
        final checkoutCartNotifier = ref.read(checkoutCartProvider.notifier);
        return state.isLoading
            ? Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3.r,
                  color: AppColors.green,
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SelectDeliveryTypeButton(
                          isSelected: !state.isPickup,
                          iconData: FlutterRemix.takeaway_fill,
                          title: AppHelpers.getTranslation(TrKeys.delivery),
                          onTap: AppHelpers.getDeliveries(state.shopDeliveries)
                                  .isEmpty
                              ? null
                              : () {
                                  notifier.setIsPickup(false);
                                  checkoutCartNotifier.setDeliveryFee(
                                    state
                                        .shopDeliveries[
                                            state.selectedDeliveryTypeIndex]
                                        .price,
                                  );
                                },
                        ),
                      ),
                      8.horizontalSpace,
                      Expanded(
                        child: SelectDeliveryTypeButton(
                          isSelected: state.isPickup,
                          iconData: FlutterRemix.shopping_bag_3_fill,
                          title: AppHelpers.getTranslation(TrKeys.pickup),
                          onTap: AppHelpers.hasPickup(state.shopDeliveries)
                              ? () {
                                  notifier.setIsPickup(true);
                                  checkoutCartNotifier.setDeliveryFee(0);
                                }
                              : null,
                        ),
                      ),
                    ],
                  ),
                  state.isPickup
                      ? Column(
                          children: [
                            30.verticalSpace,
                            SelectDateButton(
                              label:
                                  AppHelpers.getTranslation(TrKeys.pickupDate),
                              time: state.pickupDate == null
                                  ? AppHelpers.getTranslation(
                                      TrKeys.selectPickupDate)
                                  : DateFormat('yyyy-MM-dd')
                                      .format(state.pickupDate!),
                              onChangeTap: () {
                                AppHelpers.showCustomModalBottomSheet(
                                  context: context,
                                  modal: DatePickerModal(
                                    onDateSaved: notifier.setPickupDate,
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            30.verticalSpace,
                            Divider(
                              thickness: 1.r,
                              height: 1.r,
                              color: AppColors.unrated,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount:
                                  AppHelpers.getDeliveries(state.shopDeliveries)
                                      .length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return DeliveryTypeItem(
                                  delivery: AppHelpers.getDeliveries(
                                      state.shopDeliveries)[index],
                                  isSelected:
                                      state.selectedDeliveryTypeIndex == index,
                                  onTap: () {
                                    notifier
                                        .setSelectedDeliveryTypeIndex(index);
                                    checkoutCartNotifier.setDeliveryFee(
                                      AppHelpers.getDeliveries(
                                          state.shopDeliveries)[index].price,
                                    );
                                  },
                                );
                              },
                            ),
                            38.verticalSpace,
                            GestureDetector(
                              onTap: () => context
                                  .pushRoute(const SavedLocationsRoute()),
                              child: Text(
                                AppHelpers.getTranslation(TrKeys.edit),
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  color: AppColors.blue,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ),
                            6.verticalSpace,
                            Consumer(
                              builder: (context, ref, child) {
                                ref.watch(savedLocationsProvider);
                                return ProfileEditFieldButton(
                                  onTap: () {},
                                  label: AppHelpers.getTranslation(
                                      TrKeys.deliveryAddress),
                                  hintText:
                                      AppHelpers.getActiveLocalAddress()?.title,
                                );
                              },
                            ),
                            30.verticalSpace,
                            SelectDateButton(
                              label: AppHelpers.getTranslation(
                                  TrKeys.deliveryDate),
                              time: state.deliveryDate == null
                                  ? null
                                  : DateFormat('yyyy-MM-dd')
                                      .format(state.deliveryDate!),
                              onChangeTap: () {
                                AppHelpers.showCustomModalBottomSheet(
                                  context: context,
                                  modal: DatePickerModal(
                                    onDateSaved: notifier.setDeliveryDate,
                                  ),
                                );
                              },
                            ),
                            30.verticalSpace,
                            SelectDateButton(
                              label: AppHelpers.getTranslation(
                                  TrKeys.deliveryTime),
                              time: state.deliveryTime == null
                                  ? null
                                  : DateFormat.Hm().format(state.deliveryTime!),
                              onChangeTap: () {
                                AppHelpers.showCustomModalBottomSheet(
                                  context: context,
                                  modal: TimePickerModal(
                                    onSaved: notifier.setDeliveryTime,
                                    openTime: state.shopData?.openTime,
                                    closeTime: state.shopData?.closeTime,
                                  ),
                                );
                              },
                            ),
                            110.verticalSpace,
                          ],
                        ),
                ],
              );
      },
    );
  }
}
