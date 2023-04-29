import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/enums.dart';
import '../../common/fade_animation.dart';
import '../../view_models/movie_view_model.dart';
import '../../widgets/content_card.dart';
import '../detail/detail_movie_screen.dart';
import '../../widgets/item_shimmer.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({required this.title, super.key});
  final String title;

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      return Provider.of<MovieViewModel>(context, listen: false)
          .getPopularMovie();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var viewModel = Provider.of<MovieViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<MovieViewModel>(builder: (context, state, child) {
                if (state.state == WidgetState.loading) {
                  return const ItemShimmer(
                    isSmallCount: false,
                  );
                } else if (state.state == WidgetState.error) {
                  return const Center(
                    child: Text('Gagal Mendapatkan Data'),
                  );
                }
                return GridView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.6,
                            crossAxisCount: 3),
                    itemCount: widget.title.toLowerCase() == 'now playing'
                        ? viewModel.nowPlayingMovieList.length
                        : widget.title.toLowerCase() == 'popular'
                            ? viewModel.popularMovieList.length
                            : widget.title.toLowerCase() == 'top rated'
                                ? viewModel.topRatedMovieList.length
                                : viewModel.upcomingMovieList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: FadeAnimation(
                          child: ContentCard(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailMovieScreen(
                                          idMovie: widget.title.toLowerCase() ==
                                                  'now playing'
                                              ? viewModel
                                                  .nowPlayingMovieList[index].id
                                              : widget.title.toLowerCase() ==
                                                      'popular'
                                                  ? viewModel
                                                      .popularMovieList[index]
                                                      .id
                                                  : widget.title
                                                              .toLowerCase() ==
                                                          'top rated'
                                                      ? viewModel
                                                          .topRatedMovieList[
                                                              index]
                                                          .id
                                                      : viewModel
                                                          .upcomingMovieList[
                                                              index]
                                                          .id)));
                            },
                            imgPath: widget.title.toLowerCase() == 'now playing'
                                ? viewModel
                                    .nowPlayingMovieList[index].posterPath
                                : widget.title.toLowerCase() == 'popular'
                                    ? viewModel
                                        .popularMovieList[index].posterPath
                                    : widget.title.toLowerCase() == 'top rated'
                                        ? viewModel
                                            .topRatedMovieList[index].posterPath
                                        : viewModel.upcomingMovieList[index]
                                            .posterPath,
                            title: widget.title.toLowerCase() == 'now playing'
                                ? viewModel.nowPlayingMovieList[index].title
                                : widget.title.toLowerCase() == 'popular'
                                    ? viewModel.popularMovieList[index].title
                                    : widget.title.toLowerCase() == 'top rated'
                                        ? viewModel
                                            .topRatedMovieList[index].title
                                        : viewModel
                                            .upcomingMovieList[index].title,
                            size: size,
                          ),
                        ),
                      );
                    });
              })
            ],
          ),
        ),
      ),
    );
  }
}
