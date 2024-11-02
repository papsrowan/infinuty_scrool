import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:infinuty/models/post_model.dart';
import 'package:infinuty/repository_api/pagination_repository.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const _pageSize = 5;

  final PagingController<int, Post> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final PaginationRepository paginationRepository = PaginationRepository();
      final newItems = await paginationRepository.getPostPerPage(pageKey);

      if (newItems.isEmpty) {
        _pagingController.appendLastPage([]);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  Widget cardPost(
      {required String texte,
      required String profile,
      required String username,
      required String time,
      required String media}) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            
            leading: CircleAvatar(
              backgroundImage: NetworkImage(profile),
            ),
            title: Text(username,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            subtitle: Text(time,
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(texte,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.left),
          ),
          if (media.isNotEmpty)
            Container(
              constraints: const BoxConstraints(
                maxHeight: 300,
              ),
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: media,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.thumb_up_outlined),
                  label: const Text('J\'aime'),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.comment_outlined),
                  label: const Text('Commenter'),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.share_outlined),
                  label: const Text('Partager'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fil d\'actualité'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _pagingController.refresh();
        },
        child: PagedListView<int, Post>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Post>(
            itemBuilder: (context, item, index) => cardPost(
              texte: item.title,
              profile: item.author.profilePic,
              username: item.author.name,
              time: item.createdAt.toString(),
              media: item.url,
            ),
            firstPageErrorIndicatorBuilder: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Une erreur est survenue'),
                  ElevatedButton(
                    onPressed: () => _pagingController.refresh(),
                    child: const Text('Réessayer'),
                  ),
                ],
              ),
            ),
            noItemsFoundIndicatorBuilder: (context) => const Center(
              child: Text('Aucun post disponible'),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
