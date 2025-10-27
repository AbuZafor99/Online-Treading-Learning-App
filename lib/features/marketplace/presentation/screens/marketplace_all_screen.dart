import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/features/marketplace/presentation/screens/marketplace_details_screen.dart';
import 'package:flutter_ladydenily/features/marketplace/presentation/controllers/marketplace_controller.dart';
import 'package:flutter_ladydenily/features/marketplace/presentation/widgets/marketplace_api_card.dart';
import 'package:get/get.dart';

class MarketplaceAllScreen extends StatelessWidget {
  const MarketplaceAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final marketplaceController = Get.find<MarketplaceController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Marketplace",
          style: TextStyle(
            color: Color(0xFF1A3E74),
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
      ),
      body: Obx(() {
        if (marketplaceController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (marketplaceController.marketplaceItems.isEmpty) {
          return const Center(
            child: Text(
              'Nothing to show!',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.textColorBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: marketplaceController.marketplaceItems.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent:
                  280, //* each card height increased to prevent overflow
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final item = marketplaceController.marketplaceItems[index];
              return MarketplaceApiCard(item: item);
            },
          ),
        );
      }),
    );
  }
}
