import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:provider/provider.dart';

import '../../common/constant.dart';
import '../../common/enums.dart';
import '../../models/movie_detail_model.dart';
import '../../view_models/detail_movie_view_model.dart';

class DetailMovieScreen extends StatefulWidget {
  const DetailMovieScreen({required this.idMovie, super.key});
  final int idMovie;

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  @override
  void initState() {
    super.initState();
    var provider = Provider.of<DetailMovieViewModel>(context, listen: false);
    if (mounted) {
      WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) async {
        provider.getMovieDetail(idMovie: widget.idMovie);
      });
    }
  }

  @override
  void dispose() {
    Provider.of<DetailMovieViewModel>(context, listen: false).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var viewModel = Provider.of<DetailMovieViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Consumer<DetailMovieViewModel>(
          builder: (context, state, child) {
            if (state.state == WidgetState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == WidgetState.error) {
              return Column(
                children: [
                  const Center(
                      child: Text("Gagal memuat data",
                          style: TextStyle(
                            color: Colors.red,
                          ))),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        viewModel.getMovieDetail(idMovie: widget.idMovie);
                      },
                      child: child)
                ],
              );
            }
            return Stack(
              children: [
                CachedNetworkImage(
                  imageUrl:
                      Constant.urlImage + viewModel.detailMovie!.posterPath,
                  width: size.width,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 48 + 8),
                  child: DraggableScrollableSheet(
                    builder: (context, scrollController) {
                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        padding: const EdgeInsets.only(
                          left: 16,
                          top: 16,
                          right: 16,
                        ),
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: SingleChildScrollView(
                                controller: scrollController,
                                physics: const ScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      viewModel.detailMovie!.title,
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      _showGenres(
                                          viewModel.detailMovie!.genres!),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      _showDuration(
                                          viewModel.detailMovie!.runtime),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    Row(
                                      children: [
                                        RatingBarIndicator(
                                          rating: viewModel
                                                  .detailMovie!.voteAverage /
                                              2,
                                          itemCount: 5,
                                          itemBuilder: (context, index) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemSize: 24,
                                        ),
                                        Text(
                                          '${viewModel.detailMovie!.voteAverage}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      'Overview',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      viewModel.detailMovie!.overview,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(height: 16),
                                    ...List.generate(
                                        6,
                                        (index) => Card(
                                              child: Text('Data $index'),
                                            ))
                                    // const Text(
                                    //   'Recommendations',
                                    //   style: TextStyle(
                                    //       fontSize: 18,
                                    //       fontWeight: FontWeight.w600,
                                    //       color: Colors.white),
                                    // ),
                                    // const SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                color: Colors.white,
                                height: 4,
                                width: 48,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    foregroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                )
              ],
            );
            //
          },
        ),
      ),
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
