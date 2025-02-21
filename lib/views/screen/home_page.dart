import 'package:flutter/material.dart';
import 'package:media_player_pr/components/audio_player_component.dart';
import 'package:media_player_pr/components/carousel_slider.dart';
import 'package:media_player_pr/components/video_player_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

//1).Manual type of Tabbar view

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Media Player App"),
        centerTitle: true,
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              icon: Icon(Icons.audiotrack),
              text: "Audio",
            ),
            Tab(
              icon: Icon(Icons.video_collection),
              text: "Video",
            ),
            Tab(
              icon: Icon(Icons.apps),
              text: "Carousel",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          AudioPlayerComponent(),
          VideoPlayerComponent(),
          CarouselSliderComponent(),
        ],
      ),
    );
  }
}

//2).Automatic type of Tabbar view
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Media Player App"),
//           centerTitle: true,
//           bottom: TabBar(
//             tabs: [
//               Tab(
//                 icon: Icon(Icons.people),
//                 text: "Users",
//               ),
//               Tab(
//                 icon: Icon(Icons.message),
//                 text: "Chat",
//               ),
//               Tab(
//                 icon: Icon(Icons.settings),
//                 text: "Settings",
//               ),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             Container(
//               color: Colors.blueAccent,
//               child: Text("Users"),
//               alignment: Alignment.center,
//             ),
//             Container(
//               color: Colors.redAccent,
//               child: Text("Chat"),
//               alignment: Alignment.center,
//             ),
//             Container(
//               color: Colors.greenAccent,
//               child: Text("Settings"),
//               alignment: Alignment.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
