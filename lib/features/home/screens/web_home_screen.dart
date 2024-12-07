import 'package:justfood_multivendor/features/home/controllers/home_controller.dart';
import 'package:justfood_multivendor/features/home/widgets/all_restaurant_filter_widget.dart';
import 'package:justfood_multivendor/features/home/widgets/all_restaurants_widget.dart';
import 'package:justfood_multivendor/features/home/widgets/bad_weather_widget.dart';
import 'package:justfood_multivendor/features/home/widgets/best_review_item_view_widget.dart';
import 'package:justfood_multivendor/features/home/widgets/enjoy_off_banner_view_widget.dart';
import 'package:justfood_multivendor/features/home/widgets/order_again_view_widget.dart';
import 'package:justfood_multivendor/features/home/widgets/popular_foods_nearby_view_widget.dart';
import 'package:justfood_multivendor/features/home/widgets/popular_restaurants_view_widget.dart';
import 'package:justfood_multivendor/features/home/widgets/theme1/banner_view_widget1.dart';
import 'package:justfood_multivendor/features/home/widgets/today_trends_view_widget.dart';
import 'package:justfood_multivendor/features/home/widgets/web/web_banner_view_widget.dart';
import 'package:justfood_multivendor/features/home/widgets/web/web_cuisine_view_widget.dart';
import 'package:justfood_multivendor/features/home/widgets/web/web_highlight_widget_view.dart';
import 'package:justfood_multivendor/features/home/widgets/web/web_loaction_and_refer_banner_view_widget.dart';
import 'package:justfood_multivendor/features/home/widgets/web/web_new_on_stackfood_view_widget.dart';
import 'package:justfood_multivendor/features/home/widgets/what_on_your_mind_view_widget.dart';
import 'package:justfood_multivendor/features/splash/controllers/splash_controller.dart';
import 'package:justfood_multivendor/features/splash/domain/models/config_model.dart';
import 'package:justfood_multivendor/features/auth/controllers/auth_controller.dart';
import 'package:justfood_multivendor/util/dimensions.dart';
import 'package:justfood_multivendor/common/widgets/footer_view_widget.dart';
import 'package:justfood_multivendor/features/home/widgets/theme1/item_campaign_widget1.dart';
import 'package:justfood_multivendor/features/home/widgets/theme1/basic_campaign_widget1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebHomeScreen extends StatefulWidget {
  final ScrollController scrollController;
  const WebHomeScreen({super.key, required this.scrollController});

  @override
  State<WebHomeScreen> createState() => _WebHomeScreenState();
}

class _WebHomeScreenState extends State<WebHomeScreen> {
  ConfigModel? _configModel;


  @override
  void initState() {
    super.initState();
    Get.find<HomeController>().setCurrentIndex(0, false);
    _configModel = Get.find<SplashController>().configModel;
  }

  @override
  Widget build(BuildContext context) {

    bool isLogin = Get.find<AuthController>().isLoggedIn();

    return CustomScrollView(
      controller: widget.scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [

        SliverToBoxAdapter(child: Center(
          child: SizedBox( width: GetPlatform.isMobile ? MediaQuery.of(context).size.width : Dimensions.webMaxWidth + (2 * Dimensions.paddingSizeExtraLarge),
            child: GetBuilder<HomeController>(builder: (bannerController) {
              return bannerController.bannerImageList == null ? const BannerViewWidget1()
                  : bannerController.bannerImageList!.isEmpty ? const SizedBox() : const BannerViewWidget1();
            }),
          ),
        )),

        const SliverToBoxAdapter(
          child: Center(child: SizedBox(width: Dimensions.webMaxWidth,
              //child: WhatOnYourMindViewWidget()
          ),
          ),
        ),


        SliverToBoxAdapter(
            child: Center(child: SizedBox(
              width: Dimensions.webMaxWidth,
              child: Column(children: [

                const BasicCampaignWidget1(),

                const WhatOnYourMindViewWidget(),

                // SliverPersistentHeader(
                //   pinned: true,
                //   delegate: SliverDelegate(
                //     child:
                //   ),
                // ),

                const AllRestaurantFilterWidget(),
                AllRestaurantsWidget(scrollController: widget.scrollController),

                const WebLocationAndReferBannerViewWidget(),

                const WebCuisineViewWidget(),

                _configModel!.newRestaurant == 1 ? const WebNewOnStackFoodViewWidget(isLatest: true) : const SizedBox(),

                _configModel!.popularFood == 1 ?  const BestReviewItemViewWidget(isPopular: false) : const SizedBox(),

             //   isLogin ? const OrderAgainViewWidget() : const SizedBox(),

                const WebHighlightWidgetView(),

                isLogin ? const PopularRestaurantsViewWidget(isRecentlyViewed: true) : const SizedBox(),

                const PopularFoodNearbyViewWidget(),

                const PromotionalBannerViewWidget(),

                const PopularRestaurantsViewWidget(),

                const SizedBox(width: Dimensions.paddingSizeExtraSmall),

           //     const BadWeatherWidget(),

           //     const TodayTrendsViewWidget(),

              ]),
            ))
        ),

        SliverToBoxAdapter(child: Center(child: Column(
          children: [
          //  const SizedBox(height: Dimensions.paddingSizeLarge),

               FooterViewWidget(
                child: SizedBox(),
               ),
          ],
        ))),

      ],
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;

  SliverDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 || oldDelegate.minExtent != 50 || child != oldDelegate.child;
  }
}
