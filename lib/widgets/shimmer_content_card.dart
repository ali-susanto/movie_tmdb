import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContentCard extends StatelessWidget {
  const ShimmerContentCard({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Shimmer.fromColors(
          baseColor: Colors.black26,
          highlightColor: Colors.white24,
          child: Container(
            height: size.height * 0.25,
            width: size.width * 0.3,
            decoration: BoxDecoration(
                color: Colors.black26, borderRadius: BorderRadius.circular(10)),
          )),
    );
  }
}
