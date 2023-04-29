import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/enums.dart';
import '../../../common/fade_animation.dart';
import '../../../view_models/movie_view_model.dart';
import '../../../widgets/content_card.dart';
import '../../../widgets/item_shimmer.dart';
import '../../detail/detail_movie_screen.dart';
import '../../list_movie/movie_list_screen.dart';

class UpcomingMovie extends StatelessWidget {
  const UpcomingMovie({super.key, required this.size, required this.viewModel});

  final Size size;
  final MovieViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Upcoming',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MovieListScreen(
                                title: 'Upcoming',
                              )));
                },
                child: const Text('More >'))
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Consumer<MovieViewModel>(builder: (context, state, child) {
          if (state.state == WidgetState.loading) {
            return const ItemShimmer(
              isSmallCount: true,
            );
          } else if (state.state == WidgetState.error) {
            return const Center(
              child: Text('Failed to get data'),
            );
          }
          return GridView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.6,
                  crossAxisCount: 3),
              itemCount: viewModel.upcomingMovieList.getRange(1, 4).length,
              itemBuilder: (context, index) {
                return FadeAnimation(
                  child: ContentCard(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailMovieScreen(
                                  idMovie:
                                      viewModel.upcomingMovieList[index].id)));
                    },
                    imgPath: viewModel.upcomingMovieList[index].posterPath,
                    title: viewModel.upcomingMovieList[index].title,
                    size: size,
                  ),
                );
              });
        })
      ],
    );
  }
}
