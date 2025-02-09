import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets.Login_Signup/custom_shapes/container/circular_container.dart';
import '../../../../../common/widgets.Login_Signup/images/t_Rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/shimmer_circular_Indicator/shimmer.dart';
import '../../../controllers/banner_controller.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController()); // Initialize your controller properly
    return Obx(() {
      /// LOADER
      if (controller.isLoading.value) return const TShimmerEffect(width: double.infinity, height: 190);

      if (controller.banners.isEmpty) {
        return const Center(child: Text("No Banner Found"));
      } else {
        return Column(
          children: [
            CarouselSlider(
              items: controller.banners.map((banner) => TRoundedImage(
                width: 250,
                imageUlr: banner.imageUrl.isNotEmpty ? banner.imageUrl : TImages.defaultImage,
                isNetworkImage:false,
              )).toList(),
              options: CarouselOptions(
                onPageChanged: (index, _) => controller.updatePageIndicator(index),
              ),
            ),
            const SizedBox(height: TSizes.sm8),
            Center(
              child: Obx(() => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < controller.banners.length; i++)
                    TCircularContainer(
                      width: 20,
                      height: 5,
                      margin: const EdgeInsets.only(right: 8),
                      backgroundColor:
                      controller.carousalCurrentIndex.value == i
                          ? TColors.primaryColor
                          : TColors.grey,
                    )
                ],
              )),
            )
          ],
        );
      }
    });
  }
}