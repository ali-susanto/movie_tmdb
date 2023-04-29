// ignore: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../common/constant.dart';

// ignore: must_be_immutable
class ContentCard extends StatelessWidget {
  ContentCard({
    super.key,
    required this.onTap,
    required this.imgPath,
    required this.title,
    required this.size,
  });

  final Size size;
  final String imgPath;
  final String title;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xFF292B37),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0xFF292B37).withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 6),
                    ]),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: Constant.urlImage + imgPath,
                      fit: BoxFit.fill,
                      placeholder: (context, url) {
                        return Shimmer.fromColors(
                            baseColor: Colors.black26,
                            highlightColor: Colors.white24,
                            child: Container(
                              height: size.height / 3,
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(10)),
                            ));
                      },
                      errorWidget: (context, error, url) {
                        return const Center(
                            child: Text(
                          'Gagal memuat gambar',
                          style: TextStyle(color: Colors.white),
                        ));
                      },
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            )
          ],
        ));
  }
}
