import 'package:justfood_multivendor/features/product/controllers/campaign_controller.dart';
import 'package:justfood_multivendor/helper/route_helper.dart';
import 'package:justfood_multivendor/util/dimensions.dart';
import 'package:justfood_multivendor/common/widgets/custom_image_widget.dart';
import 'package:justfood_multivendor/common/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:justfood_multivendor/util/styles.dart';
import 'package:get/get.dart';
import 'package:justfood_multivendor/features/home/controllers/home_controller.dart';
import 'package:justfood_multivendor/features/home/domain/services/home_service_interface.dart';
import 'package:justfood_multivendor/features/product/domain/models/basic_campaign_model.dart';

class BasicCampaignWidget1 extends StatelessWidget {
  const BasicCampaignWidget1({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CampaignController>(builder: (campaignController) {
      return (campaignController.basicCampaignList != null && campaignController.basicCampaignList!.isEmpty)
          ? const SizedBox()
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('basic_campaigns'.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          SizedBox(
            height: 150,
            child: campaignController.basicCampaignList != null
                ? ListView.builder(
              controller: ScrollController(),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
              itemCount: campaignController.basicCampaignList!.length > 10
                  ? 10
                  : campaignController.basicCampaignList!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall, bottom: 5),
                  child: InkWell(
                    onTap: () {
                      // Define your desired action on tap
                      BasicCampaignModel campaign = campaignController.basicCampaignList![index];
                      Get.toNamed(RouteHelper.getBasicCampaignRoute(campaign));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                      child: CustomImageWidget(
                        image: '${campaignController.basicCampaignList![index].imageFullUrl}',
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            )
                : BasicCampaignShimmer(campaignController: campaignController),
          ),
        ],
      );
    });
  }
}

class BasicCampaignShimmer extends StatelessWidget {
  final CampaignController campaignController;
  const BasicCampaignShimmer({super.key, required this.campaignController});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
      itemCount: 10, // You can adjust the number of shimmer items here
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall, bottom: 5),
          child: Shimmer(
            duration: const Duration(seconds: 2),
            enabled: campaignController.basicCampaignList == null,
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                color: Colors.grey[300],
              ),
            ),
          ),
        );
      },
    );
  }
}




