import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/features/marketplace/presentation/screens/marketplace_details_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../models/marketplace_item_api_model.dart';

class MarketplaceApiCard extends StatelessWidget {
  final MarketplaceItemApiModel item;

  const MarketplaceApiCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.cardBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageWithBadge(),
          const SizedBox(height: 2),
          _buildTitle(),
          _buildDescription(),
          _buildPrice(),
          _buildPriceButton(),
        ],
      ),
    );
  }

  Widget _buildImageWithBadge() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: item.image.isNotEmpty
              ? Image.network(
                  item.image,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      _buildFallbackImage(),
                )
              : _buildFallbackImage(),
        ),
        if (item.displayType.isNotEmpty)
          Positioned(
            top: 8,
            left: 8,
            child: _TypeBadge(type: item.displayType),
          ),
      ],
    );
  }

  Widget _buildFallbackImage() {
    return Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Icon(Icons.image, color: Colors.grey.shade400, size: 50),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        item.title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w900,
          color: AppColors.blackColor,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        item.description,
        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildPrice() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        item.displayPrice,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.textColorBlue,
        ),
      ),
    );
  }

  Widget _buildPriceButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Get.to(() => MarketplaceDetailsScreen(), arguments: item.id);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        child: const Text(
          'Buy Now',
          style: TextStyle(
            color: AppColors.titleTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _TypeBadge extends StatelessWidget {
  final String type;

  const _TypeBadge({required this.type});

  @override
  Widget build(BuildContext context) {
    Color badgeColor;
    switch (type.toLowerCase()) {
      case 'best seller':
        badgeColor = AppColors.bestSellerBoxColor;
        break;
      case 'free':
        badgeColor = Colors.green.shade100;
        break;
      case 'recommended':
        badgeColor = Colors.yellow.shade100;
        break;
      default:
        badgeColor = AppColors.textColorBlue;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        type,
        style: const TextStyle(
          color: AppColors.textColorBlue,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
