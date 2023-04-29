import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common/constant.dart';
import '../../../common/enums.dart';
import '../../../view_models/movie_view_model.dart';
import '../../detail/detail_movie_screen.dart';
import '../../list_movie/movie_list_screen.dart';
import 'movie_name.dart';

class NowPlayingMovie extends StatelessWidget {
  const NowPlayingMovie({
    super.key,
    required this.size,
    required this.viewModel,
  });

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
              'Now Playing',
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
                                title: 'Now Playing',
                              
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
            return CarouselSlider.builder(
                itemCount: 6,
                itemBuilder: (context, index, pgIdx) {
                  return Container(
                    height: size.height / 3,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(10)),
                    child: Shimmer.fromColors(
                        baseColor: Colors.black26,
                        highlightColor: Colors.white24,
                        child: Container(
                          height: size.height / 3,
                          width: size.width,
                          decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(10)),
                        )),
                  );
                },
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  pauseAutoPlayOnTouch: true,
                ));
          } else if (state.state == WidgetState.error) {
            return Column(
              children: [
                const Center(
                  child: Text('Failed to get data'),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      viewModel
                          .getNowPlayingMovies()
                          .then((value) => viewModel.getPopularMovie());
                    },
                    child: const Text('Refresh'))
              ],
            );
          }
          return CarouselSlider.builder(
              itemCount: viewModel.nowPlayingMovieList.getRange(1, 7).length,
              itemBuilder: (context, index, pgIdx) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailMovieScreen(
                                idMovie:
                                    viewModel.nowPlayingMovieList[index].id)));
                  },
                  child: Stack(
                      fit: StackFit.expand,
                      alignment: Alignment.bottomLeft,
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: Constant.urlImage +
                                    viewModel.nowPlayingMovieList[index]
                                        .backdropPath,
                                height: size.height / 3,
                                width: size.width,
                                fit: BoxFit.cover,
                                placeholder: (context, url) {
                                  return Shimmer.fromColors(
                                      baseColor: Colors.black26,
                                      highlightColor: Colors.white24,
                                      child: Container(
                                        height: size.height / 3,
                                        width: size.width,
                                        decoration: BoxDecoration(
                                            color: Colors.black26,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ));
                                },
                                errorWidget: (context, error, url) {
                                  return const Text('Gagal memuat gambar');
                                },
                              )),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: MovieName(
                            size: size,
                            imgPath:
                                viewModel.nowPlayingMovieList[index].posterPath,
                            title: viewModel.nowPlayingMovieList[index].title,
                            releaseDate: viewModel
                                .nowPlayingMovieList[index].releaseDate
                                .toString(),
                          ),
                        ),
                      ]),
                );
              },
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                pauseAutoPlayOnTouch: true,
              ));
        })
      ],
    );
  }
}
