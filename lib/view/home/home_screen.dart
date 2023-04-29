import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../view_models/movie_view_model.dart';
import '../search_screen.dart';
import 'component/now_playing.dart';
import 'component/popular_movie.dart';
import 'component/top_rated_movie.dart';
import 'component/upcoming_movie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    initMovieList();
  }

  initMovieList() {
    var provider = Provider.of<MovieViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      provider.getNowPlayingMovies().then((value) => provider
          .getPopularMovie()
          .then((value) => provider.getTopRatedMovies())
          .then((value) => provider.getUpcomingMovies()));
    });
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<MovieViewModel>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Text(
              'Movie',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
            ),
            Text(
              'Ku',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.red, fontSize: 24),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen()));
              },
              icon: const Icon(Icons.search))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return viewModel.getNowPlayingMovies().then((value) => viewModel
              .getPopularMovie()
              .then((value) => viewModel.getTopRatedMovies())
              .then((value) => viewModel.getUpcomingMovies()));
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(13, 0, 13, 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                NowPlayingMovie(size: size, viewModel: viewModel),
                const SizedBox(
                  height: 10,
                ),
                PopularMovie(viewModel: viewModel, size: size),
                const SizedBox(
                  height: 10,
                ),
                TopRatedMovie(
                  size: size,
                  viewModel: viewModel,
                ),
                const SizedBox(
                  height: 10,
                ),
                UpcomingMovie(
                  size: size,
                  viewModel: viewModel,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
