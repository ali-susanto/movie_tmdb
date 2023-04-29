import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/constant.dart';

class MovieName extends StatelessWidget {
  const MovieName({
    super.key,
    required this.size,
    required this.title,
    required this.releaseDate,
    required this.imgPath,
  });

  final Size size;
  final String title;
  final String releaseDate;
  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.09,
            width: size.width * 0.16,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                Constant.urlImage + imgPath,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: '$title\n',
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis),
                  ),
                  TextSpan(
                      text: DateFormat('MMM / dd /yyyy')
                          .format(DateTime.parse(releaseDate)))
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
