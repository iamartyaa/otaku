import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:otaku/models/categories.dart';
import 'package:otaku/models/data.dart';
import 'package:otaku/screens/top_anime.dart';
import 'package:otaku/screens/top_characters.dart';
import 'package:otaku/screens/top_manga.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: ((context) => Animes()),
          ),
      ],
      child: MaterialApp(
        title: "Otaku",
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        routes: {
          TopAnime.routeName:(context) => TopAnime(),
          TopManga.routeName:(context) => TopManga(),
          TopCharacters.routeName:(context) => TopCharacters(),
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      leading: const Icon(Icons.arrow_back_ios),
      title: const Text("OneStop for Anime Hunters"),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
      ],
      headerWidget: headerWidget(context),
      headerBottomBar: headerBottomBarWidget(),
      body: [
        listView(),
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
          "OTAKU",
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(color: Colors.white70),
        ),
      ),
    );
  }
  var myRoutes = [
    TopAnime.routeName,
    TopManga.routeName,
    TopCharacters.routeName,
    TopAnime.routeName,
  ];
  ListView listView() {
    return ListView.builder(
      // padding: const EdgeInsets.only(top: 0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      shrinkWrap: true,
      itemBuilder: (context, index) => InkWell(
        onTap: (){
          Navigator.of(context).pushNamed(myRoutes[index],arguments: categories[index]);
        },
        child: Column(
          children: [
            Container(
              height: 250,
              width: 350,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(categories[index].imgUrl),
                    fit: BoxFit.cover),
              ),
            ),
            Container(
              width: 350,
              child: ListTile(
                leading: CircleAvatar(
                  child: Text("$index"),
                ),
                title: Text(categories[index].name),
                subtitle: const Text("Subtitile"),
              ),
            ),
            const SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }
}
