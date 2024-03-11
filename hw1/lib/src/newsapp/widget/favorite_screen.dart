import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hw1/src/newsapp/likes_module.dart';
import '../bloc/likes_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'row_item.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<FavoriteScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            "Likes",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
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
            ],
            onTap: (index) {
              _scrollController.jumpTo(0);
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
  LikesModule module = LikesModule();

  final _newsBloc = LikesBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikesBloc, LikesState>(
        bloc: _newsBloc,
        builder: (context, state) {
          if (state is LikesInitialState) {
            _newsBloc.add(GetLikesEvent());
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadingLikesState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedLikesState) {
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
          } else if (state is ErrorLikesState) {
            // Error state
            return const Center(child: Text("Fetching News Error!"));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
