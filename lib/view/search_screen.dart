import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../common/enums.dart';
import '../view_models/movie_view_model.dart';
import '../widgets/content_card.dart';
import '../widgets/item_shimmer.dart';
import 'detail/detail_movie_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchCtrl = TextEditingController();

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<MovieViewModel>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              viewModel.searchResultMovieList.clear();
            },
            icon: const Icon(Icons.arrow_back_outlined)),
        title: TextField(
          controller: searchCtrl,
          onEditingComplete: () {
            if (searchCtrl.text.isNotEmpty) {
              viewModel.searchMovie(query: searchCtrl.text);
            }
          },
          decoration: const InputDecoration(
              label: Text('cari film'), hintText: 'ex: spiderman'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
        child: Consumer<MovieViewModel>(builder: (context, state, child) {
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.6,
                  crossAxisCount: 3),
              itemCount: viewModel.searchResultMovieList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ContentCard(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailMovieScreen(
                                  idMovie: viewModel
                                      .searchResultMovieList[index].id)));
                    },
                    imgPath: viewModel.searchResultMovieList[index].posterPath,
                    title: viewModel.searchResultMovieList[index].title,
                    size: size,
                  ),
                );
              });
        }),
      ),
    );
  }
}
