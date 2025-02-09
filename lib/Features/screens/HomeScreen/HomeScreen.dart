import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oru_ecommerce_app/Features/controllers/ProdcutController.dart';
import 'package:oru_ecommerce_app/Features/screens/HomeScreen/widgets/TProductCardVertical.dart';
import 'package:oru_ecommerce_app/Features/screens/HomeScreen/widgets/brand_home_category.dart';
import 'package:oru_ecommerce_app/Features/screens/HomeScreen/widgets/home_categories.dart';
import 'package:oru_ecommerce_app/Features/screens/HomeScreen/widgets/promo_slider.dart';
import 'package:oru_ecommerce_app/utils/constants/image_string.dart';
import 'package:oru_ecommerce_app/utils/validators/validator.dart';

import '../../../common/shimmers/vertical_productShimmer.dart';
import '../../../common/widgets.Login_Signup/appBar/appbar.dart';
import '../../../common/widgets.Login_Signup/custom_shapes/container/TRoundedContainer.dart';
import '../../../common/widgets.Login_Signup/layout/grid_layout.dart';
import '../../../utils/constants/colors.dart';
import '../../controllers/banner_controller.dart';
import '../Login/login_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    final productController = Get.put(ProductController());

    List<String> names = ["Sell Used Phone", "Buy Used Phone", "Compare Price", "My Profile", "My Listing", "Services", "Register your Store", "Get the App"];

    return Scaffold(
      appBar: TAppBar(
        leadingIcon: Icons.list,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(TImages.oruApp, width: 50),
            Row(
              children: [
                Text("India ", style: Theme.of(context).textTheme.bodyMedium),
                Icon(Icons.location_on_outlined)
              ],
            ),
          ],
        ),
        actions: [
          Container(
            width: 80,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: TColors.homeButtonColor,
            ),
            child: Center(child: Text("Login")),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                // controller: controller.mobileNumber,
                validator: (value) => TValidator.validateEmptyText("Name", value),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: TColors.homeButtonColor,
                  hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                  hintText: 'Search phone with make, model..',
                  suffixIcon: Icon(Icons.mic_none_outlined),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: names.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: TRoundedContainer(
                        radius: 8,
                        padding: EdgeInsets.all(8),
                        showBorder: true,
                        child: Center(child: Text(names[index], style: Theme.of(context).textTheme.labelLarge)),
                      ),
                    );
                  },
                ),
              ),

              //// PROMO BANNER SLIDER HAR /////
              const SizedBox(height: 16),
              TPromoSlider(),

              //// WHATS ON YOUR MIND ///
              const SizedBox(height: 16),
              Text("What's on your mind?", style: Theme.of(context).textTheme.titleSmall),
              THomeCategories(),

              //// WHATS ON YOUR MIND ///
              const SizedBox(height: 16),
              Text("Top Brands", style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 10),
              TBrandHomeCategory(),

              //// FETCHED PRODUCT HARE ////
              Obx(() {
                if (productController.isLoading.value) {
                  return const TVerticalProductShimmer();
                }
                if (productController.products.isEmpty) {
                  return Center(child: Text("NO Data Found!", style: Theme.of(context).textTheme.bodyLarge));
                }
                return TGridLayout(
                  itemBuilder: (_, index) => TProductCardVertical(
                    product: productController.products[index],
                  ),
                  itemCount: productController.products.length,
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}