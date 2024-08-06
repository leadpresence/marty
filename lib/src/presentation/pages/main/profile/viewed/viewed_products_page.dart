import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../components/components.dart';
import '../../../../theme/theme.dart';
import 'riverpod/provider/viewed_products_provider.dart';

class ViewedProductsPage extends ConsumerStatefulWidget {
  final int? shopId;

  const ViewedProductsPage({Key? key, this.shopId}) : super(key: key);

  @override
  ConsumerState<ViewedProductsPage> createState() => _ViewedProductsPageState();
}

class _ViewedProductsPageState extends ConsumerState<ViewedProductsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(viewedProductsProvider.notifier).fetchViewedProducts(
              shopId: widget.shopId,
              checkYourNetwork: () {
                AppHelpers.showCheckFlash(
                  context,
                  AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
                );
              },
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground(),
      appBar: CommonAppBar(
        title: AppHelpers.getTranslation(TrKeys.viewedProducts),
        onLeadingPressed: context.popRoute,
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        child: Consumer(
          builder: (context, ref, child) {
            final viewedNotifier = ref.read(viewedProductsProvider.notifier);
            final viewedState = ref.watch(viewedProductsProvider);
            return GridProductsBody(
              onLiked: (productId) => viewedNotifier.likeOrUnlikeProduct(
                productId: productId,
              ),
              isLoading: viewedState.isLoading,
              products: viewedState.products,
              shopId: widget.shopId,
              increase: (index) {
                viewedNotifier.increaseProductCount(
                  index: index,
                  shopId: widget.shopId,
                );
              },
              decrease: (index) {
                viewedNotifier.decreaseProductCount(
                  index: index,
                  shopId: widget.shopId,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
