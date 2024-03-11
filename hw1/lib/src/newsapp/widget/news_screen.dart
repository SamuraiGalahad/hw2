import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hw1/src/newsapp/bloc/news_bloc.dart';
import 'package:hw1/src/newsapp/theme/theme_provider.dart';
import 'package:hw1/src/newsapp/widget/favorite_screen.dart';
import 'package:provider/provider.dart';
import 'row_item.dart';

class NewsScreen extends StatefulWidget {
  final ValueChanged<ThemeMode> onThemeChanged;

  const NewsScreen({super.key, required this.onThemeChanged});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            "Big Brother News",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          actions: [
            Switch(
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (value) {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              },
              activeColor: Colors.indigo,
            ),
          ],
          centerTitle: true,
          backgroundColor: HexColor("#00807f"),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              height: 5.0,
            ),
          ),
        ),
        body: BodyWidget(
          scrollController: _scrollController,
        ),
        bottomNavigationBar: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                icon: Icon(Icons.upgrade_sharp, color: HexColor("#00807f")),
              ),
              Tab(
                icon: Icon(
                  CupertinoIcons.heart_solid,
                  color: HexColor("#00807f"),
                ),
              )
            ],
            onTap: (index) {
              if (index == 0) {
                _scrollController.jumpTo(0);
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FavoriteScreen()),
                );
              }
            }),
      );
}

class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  final _newsBloc = NewsBloc();

  @override
  void initState() {
    super.initState();
    // getNews();
    widget.scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
        bloc: _newsBloc,
        builder: (context, state) {
          if (state is InitialNewsState) {
            _newsBloc.add(FetchNewsEvent());
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadingNewsState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedNewsState) {
            return ListView.separated(
              itemBuilder: (context, index) =>
                  ColumnItem(state.newsList[index]),
              controller: widget.scrollController,
              separatorBuilder: (context, index) => const Divider(
                height: 70,
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
              itemCount: state.newsList.length,
            );
          } else if (state is ErrorNewsState) {
            // Error state
            return const Center(child: Text("Fetching News Error!"));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  void _scrollListener() {
    if (widget.scrollController.position.pixels ==
        widget.scrollController.position.maxScrollExtent) {
      _newsBloc.add(FetchNewsEvent());
      setState(() {});
    }
  }
}
