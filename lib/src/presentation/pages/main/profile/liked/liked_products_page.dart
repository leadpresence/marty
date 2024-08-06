import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../components/components.dart';
import '../../../../theme/theme.dart';
import '../../shop/details/riverpod/provider/shop_category_products_provider.dart';
import '../../shop/riverpod/provider/shop_cart_provider.dart';
import 'riverpod/provider/liked_products_provider.dart';

class LikedProductsPage extends ConsumerStatefulWidget {
  final int? shopId;

  const LikedProductsPage({Key? key, this.shopId}) : super(key: key);

  @override
  ConsumerState<LikedProductsPage> createState() => _LikedProductsPageState();
}

class _LikedProductsPageState extends ConsumerState<LikedProductsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(likedProductsProvider.notifier).fetchLikedProducts(
              shopId: widget.shopId,
              cartData: ref.watch(shopCartProvider).cartData,
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground(),
      appBar: CommonAppBar(
        title: AppHelpers.getTranslation(TrKeys.likedProducts),
        onLeadingPressed: context.popRoute,
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        child: Consumer(
          builder: (context, ref, child) {
            final notifier = ref.read(likedProductsProvider.notifier);
            final state = ref.watch(likedProductsProvider);
            return GridProductsBody(
              shopId: widget.shopId,
              isLoading: state.isLoading,
              products: state.products,
              onLiked: (productId) => notifier.likeOrUnlikeProduct(
                productId: productId,
                shopId: widget.shopId,
              ),
              increase: (index) {
                notifier.increaseProductCount(
                  productIndex: index,
                  shopId: widget.shopId,
                  onCartUpdate: (data) {
                    ref.read(shopCartProvider.notifier).setShopCart(data);
                    ref
                        .read(shopCategoryProductsProvider.notifier)
                        .updateShopCategoryProducts(cartData: data);
                  },
                );
              },
              decrease: (index) {
                notifier.decreaseProductCount(
                  productIndex: index,
                  shopId: widget.shopId,
                  onCartUpdate: (data) {
                    ref.read(shopCartProvider.notifier).setShopCart(data);
                    ref
                        .read(shopCategoryProductsProvider.notifier)
                        .updateShopCategoryProducts(cartData: data);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
