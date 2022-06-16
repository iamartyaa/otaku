import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:otaku/models/categories.dart';
import 'package:otaku/models/data.dart';
import 'package:provider/provider.dart';

class TopAnime extends StatefulWidget {
  static const routeName = '/top-anime';

  @override
  State<TopAnime> createState() => _TopAnimeState();
}

class _TopAnimeState extends State<TopAnime> {
  late Category myCategory;
  var isloading = false;

  void initState() {
    setState(() {
      isloading = true;
    });
    Future.delayed(Duration.zero).then(
      (value) {
        Provider.of<Animes>(context, listen: false)
            .fetchAndSetAnimes()
            .then((value) {
          setState(() {
            isloading = false;
          });
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    myCategory = ModalRoute.of(context)!.settings.arguments as Category;
    List<MyTopAnime> myAnimes = Provider.of<Animes>(context).animes;

    return DraggableHome(
      leading: const Icon(Icons.arrow_back_ios),
      title: Text(myCategory.name),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
      ],
      headerWidget: headerWidget(context),
      headerBottomBar: headerBottomBarWidget(),
      body: [
        isloading == true
            ? const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              )
            : ListView.builder(
                padding: const EdgeInsets.only(top: 0),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: myAnimes.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {},
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        children: [
                          Container(
                            height: 250,
                            width: 350,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(myAnimes[index].imgUrl ??
                                      "https://png.pngtree.com/thumb_back/fh260/background/20200612/pngtree-error-page-not-found-404-background-image_338689.jpg"),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Text(myAnimes[index].rank.toString()),
                            ),
                            title: Text(myAnimes[index].title ?? "Unknown"),
                            subtitle:
                                Text(myAnimes[index].titleEnglish ?? "Unknown"),
                            trailing: Column(
                              children: [
                                Text('Episodes'),
                                CircleAvatar(
                                  child: Text(myAnimes[index].episodes.toString()),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ],
      fullyStretchable: true,
      // expandedBody: const CameraPreview(),
      backgroundColor: Colors.white,
      appBarColor: Colors.teal,
    );
  }

  Row headerBottomBarWidget() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Icon(
          Icons.settings,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget headerWidget(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Text(
          myCategory.name,
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(color: Colors.white70),
        ),
      ),
    );
  }
}
