import 'package:flutter/material.dart';
import 'shimmer_content_card.dart';

class ItemShimmer extends StatelessWidget {
  const ItemShimmer({required this.isSmallCount, super.key});
  final bool isSmallCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemCount: isSmallCount ? 3 : 16,
        itemBuilder: (context, index) {
          return const ShimmerContentCard();
        });
  }
}
