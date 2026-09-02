import 'package:flutter/material.dart';

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
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.dark(),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  Widget build(BuildContext context) {
    List<int> valorantFriends = [0, 1, 2];
    List<int> riotFriends = [3, 4];
    List<String> friends = [
      "MissYouLikeKrazy",
      "bread",
      "The14th",
      "Carlvendish",
      "D1yah",
    ];
    Card socialCard = Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2.0,
      child: const Text("Social"),
    );
    Card tabsCard = Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Friends"),
          const Text("Messages"),
          const Text("Requests"),
        ],
      ),
    );
    Card searchBarCard = Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [const Text("Search")],
      ),
    );
    Card gameCard = Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [const Text("Valorant"), Text("${valorantFriends.length}")],
      ),
    );
    Card gameFriendsCard = valorantFriends.isNotEmpty
        ? Card(
            clipBehavior: Clip.antiAlias,
            elevation: 2.0,
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                itemCount: valorantFriends.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(friends[valorantFriends[index]]),
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
              height: 50,
              child: ListView.builder(
                itemCount: riotFriends.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(friends[riotFriends[index]]),
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Hello World"),
      ),
      body: Column(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        //
        // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
        // action in the IDE, or press "p" in the console), to see the
        // wireframe for each widget.
        mainAxisAlignment: .center,
        children: [
          socialCard,
          const SizedBox(height: 5),
          tabsCard,
          const SizedBox(height: 5),
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
