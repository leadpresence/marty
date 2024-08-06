import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/routes/app_router.gr.dart';
import '../../../../../../core/utils/utils.dart';
import '../../../../../../riverpod/provider/app_provider.dart';
import '../../../../../components/components.dart';
import '../../../../../theme/theme.dart';
import '../riverpod/provider/recipe_categories_provider.dart';
import '../riverpod/provider/recipes_in_shop_provider.dart';

class RecipesTabBody extends ConsumerWidget {
  final int? shopId;

  const RecipesTabBody({Key? key, this.shopId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(appProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        31.verticalSpace,
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppHelpers.getTranslation(TrKeys.recipeCategories),
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.sp,
                  color: AppColors.iconAndTextColor(),
                  letterSpacing: -1,
                ),
              ),
              GestureDetector(
                onTap: () =>
                    context.pushRoute(RecipeCategoriesRoute(shopId: shopId)),
                child: Text(
                  AppHelpers.getTranslation(TrKeys.viewMore),
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: AppColors.blue,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        16.verticalSpace,
        Consumer(
          builder: (context, ref, child) {
            final recipesState = ref.watch(recipeCategoriesProvider);
            return RecipeCategoriesBody(
              isLoading: recipesState.isLoading,
              recipeCategories: recipesState.recipeCategories,
              shopId: shopId,
            );
          },
        ),
        40.verticalSpace,
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppHelpers.getTranslation(TrKeys.recipes),
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.sp,
                  color: AppColors.iconAndTextColor(),
                  letterSpacing: -1,
                ),
              ),
              GestureDetector(
                onTap: () => context.pushRoute(RecipesRoute(shopId: shopId)),
                child: Text(
                  AppHelpers.getTranslation(TrKeys.viewMore),
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: AppColors.blue,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Consumer(
            builder: (context, ref, child) {
              final recipesState = ref.watch(recipesInShopProvider);
              return GridRecipesBody(
                isLoading: recipesState.isLoading,
                recipes: recipesState.recipes,
                shopId: shopId,
              );
            },
          ),
        ),
      ],
    );
  }
}
