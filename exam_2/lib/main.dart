import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to center the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.dark(),
      ),
      routes: {
        "/": (ctx) => const MyHomePage(),
        "/user-message": (ctx) => const UserMessage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: "Search");
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<int> valorantFriends = [0, 1, 2];
    List<int> inactiveFriends = [3, 4];
    List<String> friends = [
      "MissYouLikeKrazy",
      "bread",
      "The14th",
      "Carlvendish",
      "D1yah",
    ];
    List<bool> isPlaying = [false, true, true];
    Card searchBarCard = Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Flexible(child: TextField(controller: _searchController))],
      ),
    );
    Card gameCard = Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [const Text("Valorant"), const SizedBox(width: 10,), Text("${valorantFriends.length}")],
      ),
    );
    Card gameFriendsCard = valorantFriends.isNotEmpty
        ? Card(
            clipBehavior: Clip.antiAlias,
            elevation: 2.0,
            child: SizedBox(
              height: 120,
              child: ListView.builder(
                itemCount: valorantFriends.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            "/user-message",
                            arguments: {
                              "user-name": friends[valorantFriends[index]],
                              "is-active": true,
                              "is-playing": !isPlaying[valorantFriends[index]]
                                  ? false
                                  : true,
                            },
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              maxRadius: 20.0,
                              backgroundColor: Color.from(
                                alpha: 1.0,
                                red: 0.2,
                                green: 0.2,
                                blue: 0.2,
                              ),
                              // foregroundImage: ImageProvider,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(friends[valorantFriends[index]]),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.computer),
                                    Text(
                                      !isPlaying[valorantFriends[index]]
                                          ? "Online"
                                          : "Playing",
                                    ),
                                    const Text(" - Valorand"),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                    // title: Text(friends[valorantFriends[index]]),
                  );
                },
              ),
            ),
          )
        : Card(
            clipBehavior: Clip.antiAlias,
            elevation: 2.0,
            child: SizedBox(height: 0),
          );
    Card onlineCard = Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [const Text("Online"), Text("${friends.length}")],
      ),
    );
    Card onlineFriendsCard = friends.isNotEmpty
        ? Card(
            clipBehavior: Clip.antiAlias,
            elevation: 2.0,
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                itemCount: inactiveFriends.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            "/user-message",
                            arguments: {
                              "user-name": friends[inactiveFriends[index]],
                              "is-active": false,
                              "is-playing": false,
                            },
                          );
                        },
                        child: Row(
                          mainAxisAlignment: .center,
                          children: [
                            CircleAvatar(
                              maxRadius: 20.0,
                              backgroundColor: Color.from(
                                alpha: 1.0,
                                red: 0.2,
                                green: 0.2,
                                blue: 0.2,
                              ),
                              // foregroundImage: ImageProvider,
                            ),
                            Column(
                              mainAxisAlignment: .center,
                              children: [
                                Text(friends[inactiveFriends[index]]),
                                Row(
                                  mainAxisAlignment: .center,
                                  children: [
                                    Icon(Icons.phone_android),
                                    const Text("Away - Riot Mobile"),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                    // title: Text(friends[valorantFriends[index]]),
                  );
                },
              ),
            ),
          )
        : Card(
            clipBehavior: Clip.antiAlias,
            elevation: 2.0,
            child: SizedBox(height: 0),
          );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Column(
          // mainAxisAlignment: .center,
          crossAxisAlignment: .start,
          children: [
            const Text("Social"),
            Row(
              children: [
                TextButton(onPressed: () {}, child: const Text("Friends")),
                TextButton(onPressed: () {}, child: const Text("Messages")),
                TextButton(onPressed: () {}, child: const Text("Requests")),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: .start,
        children: [
          searchBarCard,
          const SizedBox(height: 5),
          gameCard,
          const SizedBox(height: 5),
          gameFriendsCard,
          const SizedBox(height: 5),
          onlineCard,
          const SizedBox(height: 5),
          onlineFriendsCard,
        ],
      ),
    );
  }
}

class UserMessage extends StatefulWidget {
  const UserMessage({super.key});

  @override
  State<UserMessage> createState() => _UserMessageState();
}

class _UserMessageState extends State<UserMessage> {
  late final TextEditingController _msgController;

  @override
  void initState() {
    super.initState();
    _msgController = TextEditingController(text: "Send a Message");
  }

  @override
  void dispose() {
    _msgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    var userName = args["user-name"] as String;
    var isActive = args["is-active"] as bool;
    var isPlaying = args["is-playing"] as bool;

    Row userStatus;
    if (isActive) {
      if (isPlaying) {
        userStatus = Row(
          mainAxisAlignment: .center,
          children: [Icon(Icons.computer), const Text("Playing - Valorant")],
        );
      } else {
        userStatus = Row(
          mainAxisAlignment: .center,
          children: [Icon(Icons.computer), const Text("Online - Valorant")],
        );
      }
    } else {
      userStatus = Row(
        mainAxisAlignment: .center,
        children: [Icon(Icons.phone_android), const Text("Away - Riot Mobile")],
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          mainAxisAlignment: .center,
          children: [
            const CircleAvatar(
              maxRadius: 20.0,
              backgroundColor: Color.from(
                alpha: 1.0,
                red: 0.2,
                green: 0.2,
                blue: 0.2,
              ),
              // foregroundImage: ImageProvider,
            ),
            Column(
              mainAxisAlignment: .center,
              children: [Text(userName), userStatus],
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [TextField(controller: _msgController)],
        ),
      ),
    );
  }
}
