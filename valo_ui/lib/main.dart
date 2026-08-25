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
      theme: ThemeData(colorScheme: const ColorScheme.dark()),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final title = "";

  const MyHomePage({super.key, title});

  @override
  Widget build(BuildContext context) {
    var teamKills = 12;
    var enemyKills = 14;
    var matchStatus = false;
    var rank = "assets/img/ranks/gold-1.webp";
    var mapName = "Ascent";
    var gameMode = "Competitive";
    var gameDate = "22/08/2026";
    var gameTime = "42:01 Min";
    var teamProfiles = {
      "heroImg": [
        'assets/img/agents/phoenix.webp',
        'assets/img/agents/sova.webp',
        'assets/img/agents/chamber.webp',
        'assets/img/agents/clove.webp',
        'assets/img/agents/reyna.webp',
      ],
      "name": [
        "Team Mate 1",
        "Team Mate 2",
        "Team Mate 3",
        "Team Mate 4",
        "Team Mate 5",
      ],
      "rating": [261, 190, 89, 298, 259],
      "kills": [23, 17, 9, 28, 21],
      "deaths": [21, 21, 8, 23, 21],
      "assists": [6, 8, 1, 6, 10],
      "isMatchMVP": [false, false, false, true, false],
    };
    var opponentProfiles = {
      "heroImg": [
        'assets/img/agents/sova.webp',
        'assets/img/agents/reyna.webp',
        'assets/img/agents/raze.webp',
        'assets/img/agents/cypher.webp',
        'assets/img/agents/brimstone.webp',
      ],
      "name": [
        "Opponent 1",
        "Opponent 2",
        "Opponent 3",
        "Opponent 4",
        "Opponent 5",
      ],
      "rating": [219, 191, 203, 246, 159],
      "kills": [20, 18, 19, 23, 13],
      "deaths": [18, 21, 19, 21, 19],
      "assists": [5, 2, 4, 5, 9],
      "isMatchMVP": [false, false, false, true, false],
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("first"),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("<"), Text("Match Details")],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("My Team"),
              // todo
              SizedBox(width: 15),
              Text("$teamKills"),
              SizedBox(width: 15),
              Text("$enemyKills"),
              SizedBox(width: 15),
              Text("Opponent"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/img/map/ascent.jpg'),
                    ),
                  ),
                  height: 100,
                  child: Row(
                    children: [
                      Image.asset(rank),
                      Column(
                        children: [
                          Text("$mapName - $gameMode"),
                          Text("$gameDate $gameTime"),
                        ],
                      ),
                      Text(matchStatus ? "Victory" : "Defeat"),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("My Team"),
              // todo
            ],
          ),
          Column(
            children: [
              Card(
                child: Row(
                  children: [
                    Image.asset(
                      teamProfiles["heroImg"]?[0].toString() ?? "",
                      width: 50,
                    ),
                    Column(
                      children: [
                        Text(teamProfiles["name"]?[0].toString() ?? ''),
                        Text(
                          teamProfiles["isMatchMVP"]?[0].toString() == "true"
                              ? "TEAM MVP"
                              : "",
                        ),
                      ],
                    ),
                    Text(teamProfiles["rating"]?[0].toString() ?? ''),
                    Text(
                      '${teamProfiles["kills"]?[0].toString() ?? ''}/${teamProfiles["deaths"]?[0].toString() ?? ''}/${teamProfiles["assists"]?[0].toString() ?? ''}',
                    ),
                  ],
                ),
              ),
              Card(
                child: Row(
                  children: [
                    Image.asset(
                      teamProfiles["heroImg"]?[1].toString() ?? "",
                      width: 50,
                    ),
                    Column(
                      children: [
                        Text(teamProfiles["name"]?[1].toString() ?? ''),
                        Text(
                          teamProfiles["isMatchMVP"]?[1].toString() == "true"
                              ? "TEAM MVP"
                              : "",
                        ),
                      ],
                    ),
                    Text(teamProfiles["rating"]?[1].toString() ?? ''),
                    Text(
                      '${teamProfiles["kills"]?[1].toString() ?? ''}/${teamProfiles["deaths"]?[1].toString() ?? ''}/${teamProfiles["assists"]?[1].toString() ?? ''}',
                    ),
                  ],
                ),
              ),
              Card(
                child: Row(
                  children: [
                    Image.asset(
                      teamProfiles["heroImg"]?[2].toString() ?? "",
                      width: 50,
                    ),
                    Column(
                      children: [
                        Text(teamProfiles["name"]?[2].toString() ?? ''),
                        Text(
                          teamProfiles["isMatchMVP"]?[2].toString() == "true"
                              ? "TEAM MVP"
                              : "",
                        ),
                      ],
                    ),
                    Text(teamProfiles["rating"]?[2].toString() ?? ''),
                    Text(
                      '${teamProfiles["kills"]?[2].toString() ?? ''}/${teamProfiles["deaths"]?[2].toString() ?? ''}/${teamProfiles["assists"]?[2].toString() ?? ''}',
                    ),
                  ],
                ),
              ),
              Card(
                child: Row(
                  children: [
                    CircleImage.asset(
                      teamProfiles["heroImg"]?[3].toString() ?? "",
                      width: 50,
                    ),
                    Column(
                      children: [
                        Text(teamProfiles["name"]?[3].toString() ?? ''),
                        Text(
                          teamProfiles["isMatchMVP"]?[3].toString() == "true"
                              ? "TEAM MVP"
                              : "",
                        ),
                      ],
                    ),
                    Text(teamProfiles["rating"]?[3].toString() ?? ''),
                    Text(
                      '${teamProfiles["kills"]?[3].toString() ?? ''}/${teamProfiles["deaths"]?[3].toString() ?? ''}/${teamProfiles["assists"]?[3].toString() ?? ''}',
                    ),
                  ],
                ),
              ),
              Card(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(teamProfiles["heroImg"]?[4].toString() ?? ""),
                      radius: 50,
                    ),
                    Column(
                      children: [
                        Text(teamProfiles["name"]?[4].toString() ?? ''),
                        Text(
                          teamProfiles["isMatchMVP"]?[4].toString() == "true"
                              ? "TEAM MVP"
                              : "",
                        ),
                      ],
                    ),
                    Text(teamProfiles["rating"]?[4].toString() ?? ''),
                    Text(
                      '${teamProfiles["kills"]?[4].toString() ?? ''}/${teamProfiles["deaths"]?[4].toString() ?? ''}/${teamProfiles["assists"]?[4].toString() ?? ''}',
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Opponent"),
              // todo
            ],
          ),
          Column(
            children: [
              Card(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        opponentProfiles["heroImg"]?[0].toString() ?? "",
                      ),
                      radius: 50,
                    ),
                    Column(
                      children: [
                        Text(opponentProfiles["name"]?[0].toString() ?? ''),
                        Text(
                          teamProfiles["isMatchMVP"]?[0].toString() == "true"
                              ? "TEAM MVP"
                              : "",
                        ),
                      ],
                    ),
                    Text(opponentProfiles["rating"]?[0].toString() ?? ''),
                    Text(
                      '${opponentProfiles["kills"]?[0].toString() ?? ''}/${opponentProfiles["deaths"]?[0].toString() ?? ''}/${opponentProfiles["assists"]?[0].toString() ?? ''}',
                    ),
                  ],
                ),
              ),
              Card(
                child: Row(
                  children: [
                    Image.asset(
                      opponentProfiles["heroImg"]?[1].toString() ?? "",
                      width: 50,
                    ),
                    Column(
                      children: [
                        Text(opponentProfiles["name"]?[1].toString() ?? ''),
                        Text(
                          teamProfiles["isMatchMVP"]?[1].toString() == "true"
                              ? "TEAM MVP"
                              : "",
                        ),
                      ],
                    ),
                    Text(opponentProfiles["rating"]?[1].toString() ?? ''),
                    Text(
                      '${opponentProfiles["kills"]?[1].toString() ?? ''}/${opponentProfiles["deaths"]?[1].toString() ?? ''}/${opponentProfiles["assists"]?[1].toString() ?? ''}',
                    ),
                  ],
                ),
              ),
              Card(
                child: Row(
                  children: [
                    Image.asset(
                      opponentProfiles["heroImg"]?[2].toString() ?? "",
                      width: 50,
                    ),
                    Column(
                      children: [
                        Text(opponentProfiles["name"]?[2].toString() ?? ''),
                        Text(
                          teamProfiles["isMatchMVP"]?[2].toString() == "true"
                              ? "TEAM MVP"
                              : "",
                        ),
                      ],
                    ),
                    Text(opponentProfiles["rating"]?[2].toString() ?? ''),
                    Text(
                      '${opponentProfiles["kills"]?[2].toString() ?? ''}/${opponentProfiles["deaths"]?[2].toString() ?? ''}/${opponentProfiles["assists"]?[2].toString() ?? ''}',
                    ),
                  ],
                ),
              ),
              Card(
                child: Row(
                  children: [
                    Image.asset(
                      opponentProfiles["heroImg"]?[3].toString() ?? "",
                      width: 50,
                    ),
                    Column(
                      children: [
                        Text(opponentProfiles["name"]?[3].toString() ?? ''),
                        Text(
                          teamProfiles["isMatchMVP"]?[3].toString() == "true"
                              ? "TEAM MVP"
                              : "",
                        ),
                      ],
                    ),
                    Text(opponentProfiles["rating"]?[3].toString() ?? ''),
                    Text(
                      '${opponentProfiles["kills"]?[3].toString() ?? ''}/${opponentProfiles["deaths"]?[3].toString() ?? ''}/${opponentProfiles["assists"]?[3].toString() ?? ''}',
                    ),
                  ],
                ),
              ),
              Card(
                child: Row(
                  children: [
                    Image.asset(
                      opponentProfiles["heroImg"]?[4].toString() ?? "",
                      width: 50,
                    ),
                    Column(
                      children: [
                        Text(opponentProfiles["name"]?[4].toString() ?? ''),
                        Text(
                          teamProfiles["isMatchMVP"]?[4].toString() == "true"
                              ? "TEAM MVP"
                              : "",
                        ),
                      ],
                    ),
                    Text(opponentProfiles["rating"]?[4].toString() ?? ''),
                    Text(
                      '${opponentProfiles["kills"]?[4].toString() ?? ''}/${opponentProfiles["deaths"]?[4].toString() ?? ''}/${opponentProfiles["assists"]?[4].toString() ?? ''}',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
