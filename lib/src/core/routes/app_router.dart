import 'package:auto_route/auto_route.dart';

import '../../presentation/pages/pages.dart';

@CupertinoAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    CupertinoRoute(path: '/', page: SplashPage),
    CupertinoRoute(path: '/select-lang', page: SelectLangPage),
    CupertinoRoute(path: '/onboarding', page: OnBoardingPage),
    CupertinoRoute(path: '/login', page: LoginPage),
    CupertinoRoute(
      path: '/main',
      page: MainPage,
      children: [
        CustomRoute(
          path: 'delivery',
          page: DeliveryPage,
          transitionsBuilder: TransitionsBuilders.slideRight,
        ),
        CustomRoute(
          path: 'pickup',
          page: PickupPage,
          transitionsBuilder: TransitionsBuilders.slideLeft,
        ),
        AutoRoute(
          path: 'search',
          page: SearchShopsPage,
        ),
      ],
    ),
    CupertinoRoute(path: '/add-address', page: AddAddressPage),
    CupertinoRoute(path: '/profile', page: ProfilePage),
    CupertinoRoute(path: '/liked-products', page: LikedProductsPage),
    CupertinoRoute(path: '/viewed-products', page: ViewedProductsPage),
    CupertinoRoute(path: '/profile-settings', page: ProfileSettingsPage),
    CupertinoRoute(path: '/settings', page: SettingsPage),
    CupertinoRoute(path: '/saved-locations', page: SavedLocationsPage),
    CupertinoRoute(path: '/currencies', page: CurrenciesPage),
    CupertinoRoute(path: '/chat', page: ChatPage),
    CustomRoute(
      path: '/shop',
      page: ShopMainPage,
      transitionsBuilder: TransitionsBuilders.slideBottom,
      children: [
        AutoRoute(
          path: 'details',
          page: ShopDetailsPage,
        ),
        AutoRoute(
          path: 'recipes',
          page: ShopRecipesPage,
        ),
        AutoRoute(
          path: 'saved',
          page: SavedProductsPage,
        ),
      ],
    ),
    CupertinoRoute(path: '/view-on-map', page: ViewOnMapPage),
    CupertinoRoute(path: '/banner-details', page: BannerDetailsPage),
    CupertinoRoute(path: '/product', page: ProductPage),
    CupertinoRoute(path: '/add-review', page: AddReviewPage),
    CupertinoRoute(path: '/market-info', page: MarketInfoPage),
    CupertinoRoute(path: '/wallet-histories', page: WalletHistoriesPage),
    CupertinoRoute(path: '/brands', page: BrandsPage),
    CupertinoRoute(path: '/brand-products', page: BrandProductsPage),
    CupertinoRoute(path: '/recipe-categories', page: RecipeCategoriesPage),
    CupertinoRoute(path: '/recipes', page: RecipesPage),
    CupertinoRoute(path: '/recipes-details', page: RecipeDetailsPage),
    CupertinoRoute(path: '/cart', page: CartPage),
    CupertinoRoute(path: '/checkout', page: CheckoutPage),
    CupertinoRoute(path: '/order-history', page: OrderHistoryPage),
    CupertinoRoute(path: '/category-products', page: CategoryProductsPage),
    CupertinoRoute(path: '/become-seller', page: BecomeSellerPage),
    CupertinoRoute(path: '/recipe-category', page: RecipeCategoryPage),
    CupertinoRoute(path: '/more-recipe-category', page: MoreRecipeCategoryPage),
    CupertinoRoute(path: '/enter-phone', page: EnterPhonePage),
    CupertinoRoute(path: '/category-details', page: CategoryDetailsPage),
    CupertinoRoute(path: '/notifications', page: NotificationsPage),
  ],
)
class $AppRouter {}
