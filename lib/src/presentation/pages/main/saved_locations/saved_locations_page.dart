import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/routes/app_router.gr.dart';
import '../../../../core/utils/utils.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';
import 'riverpod/provider/saved_locations_provider.dart';
import 'widgets/saved_location_item.dart';

class SavedLocationsPage extends ConsumerStatefulWidget {
  const SavedLocationsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SavedLocationsPage> createState() => _SavedLocationsPageState();
}

class _SavedLocationsPageState extends ConsumerState<SavedLocationsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(savedLocationsProvider.notifier).fetchSavedLocations();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(savedLocationsProvider);
    final notifier = ref.read(savedLocationsProvider.notifier);
    return Directionality(
      textDirection: LocalStorage.instance.getLangLtr()
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: AbsorbPointer(
        absorbing: state.isLoading || state.isUpdating,
        child: Scaffold(
          extendBody: true,
          backgroundColor: AppColors.mainBackground(),
          appBar: CommonAppBar(
            title: AppHelpers.getTranslation(TrKeys.addressList),
            onLeadingPressed: context.popRoute,
            actions: [
              Padding(
                padding: REdgeInsets.symmetric(
                  vertical: Platform.isAndroid ? 12 : 8,
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(100.r),
                  color: AppColors.green,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100.r),
                    onTap: () =>
                        context.pushRoute(AddAddressRoute(isRequired: false)),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      padding: REdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Icon(
                            FlutterRemix.add_line,
                            size: 18.r,
                            color: AppColors.white,
                          ),
                          4.horizontalSpace,
                          Text(
                            AppHelpers.getTranslation(TrKeys.addAddress),
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              letterSpacing: -0.5,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              16.horizontalSpace,
            ],
          ),
          body: Stack(
            children: [
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 15),
                child: state.isLoading
                    ? const MainListShimmer(
                        itemHeight: 248,
                        spacing: 10,
                        borderRadius: 10,
                        verticalPadding: 20,
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: REdgeInsets.only(top: 31, bottom: 82),
                        itemCount: state.addresses.length,
                        itemBuilder: (context, index) {
                          final address = state.addresses[index];
                          final markers = state.listOfMarkers[index];
                          return SavedLocationItem(
                            address: address,
                            markers: markers,
                            onDelete: () => notifier.deleteAddress(address),
                            onMakeDefault: () =>
                                notifier.makeDefaultAddress(address),
                          );
                        },
                      ),
              ),
              BlurLoadingWidget(isLoading: state.isUpdating),
            ],
          ),
        ),
      ),
    );
  }
}
