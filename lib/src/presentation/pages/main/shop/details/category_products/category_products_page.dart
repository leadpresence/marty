import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../models/models.dart';
import '../../../../../components/components.dart';
import '../../../../../theme/theme.dart';
import '../../riverpod/provider/shop_cart_provider.dart';
import '../riverpod/provider/shop_category_products_provider.dart';
import 'riverpod/provider/category_products_provider.dart';
import 'riverpod/provider/search_product_in_category_products_provider.dart';

class CategoryProductsPage extends ConsumerStatefulWidget {
  final ShopCategoryData category;
  final int? shopId;

  const CategoryProductsPage({Key? key, required this.category, this.shopId})
      : super(key: key);

  @override
  ConsumerState<CategoryProductsPage> createState() =>
      _CategoryProductsPageState();
}

class _CategoryProductsPageState extends ConsumerState<CategoryProductsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(categoryProductsProvider.notifier).updateCategoryProducts(
              context,
              categoryId: widget.category.id,
              shopId: widget.shopId,
              cartData: ref.watch(shopCartProvider).cartData,
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: AppColors.mainBackground(),
        appBar: CommonAppBar(
          title: '${widget.shopId}',
          onLeadingPressed: context.popRoute,
        ),
        body: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(searchProductInCategoryProductsProvider);
            final notifier =
                ref.read(searchProductInCategoryProductsProvider.notifier);
            return Column(
              children: [
                SearchTextField(
                  onChanged: (query) => notifier.setQuery(context, query),
                ),
                Expanded(
                  child: state.isSearching
                      ? SearchProductsBody(
                          isSearchLoading: state.isSearchLoading,
                          searchedProducts: state.searchedProducts,
                          onLikeProduct: (productId) =>
                              notifier.likeOrUnlikeProduct(
                            productId: productId,
                            shopId: widget.shopId,
                          ),
                          onIncrease: (index) {},
                          onDecrease: (index) {},
                        )
                      : Padding(
                          padding: REdgeInsets.symmetric(horizontal: 16.0),
                          child: Consumer(
                            builder: (context, ref, child) {
                              final productsState =
                                  ref.watch(categoryProductsProvider);
                              final productsNotifier =
                                  ref.read(categoryProductsProvider.notifier);
                              return GridProductsBody(
                                isLoading: productsState.isLoading,
                                products: productsState.products,
                                bottomPadding: 24,
                                shopId: widget.shopId,
                                increase: (index) {
                                  productsNotifier.increaseProductCount(
                                    productIndex: index,
                                    shopId: widget.shopId,
                                    onCartUpdate: (data) {
                                      ref
                                          .read(shopCartProvider.notifier)
                                          .setShopCart(data);
                                      ref
                                          .read(shopCategoryProductsProvider
                                              .notifier)
                                          .updateShopCategoryProducts(
                                              cartData: data);
                                    },
                                  );
                                },
                                decrease: (index) {
                                  productsNotifier.decreaseProductCount(
                                    productIndex: index,
                                    shopId: widget.shopId,
                                    onCartUpdate: (data) {
                                      ref
                                          .read(shopCartProvider.notifier)
                                          .setShopCart(data);
                                      ref
                                          .read(shopCategoryProductsProvider
                                              .notifier)
                                          .updateShopCategoryProducts(
                                              cartData: data);
                                    },
                                  );
                                },
                                onLiked: (id) {
                                  ref
                                      .read(categoryProductsProvider.notifier)
                                      .likeOrUnlikeProduct(
                                        productId: id,
                                        shopId: widget.shopId,
                                      );
                                },
                              );
                            },
                          ),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
