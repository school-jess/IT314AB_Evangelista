import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My First Flutter Application',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1F2430),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFF9940),
          onPrimary: Color(0xFF1F2430),
          surface: Color(0xFF1F2430),
          onSurface: Color(0xFFCBCCC6),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2D3640),
          foregroundColor: Color(0xFFCBCCC6),
          elevation: 0,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFFCBCCC6)),
          bodyMedium: TextStyle(color: Color(0xFFCBCCC6)),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String date =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    Card profileCard = Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2.0,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/wp4162286-celeste-game-wallpapers.png',
              height: 150,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 24),
            const Text(
              'Jess Mathew Pacquiao Evangelista',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('BSIT-3', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            const Text(
              '"My First Flutter Application"',
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 16),
            Text(date, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            const Text('Playing Chess', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('DoomZ', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 16),
                const Text('Artmage', style: TextStyle(fontSize: 18)),
              ],
            ),
          ],
        ),
      ),
    );
    Card favoriteGamesCard = Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2.0,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'My favorite games',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Celeste', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 16),
                const Text('Ultrakill', style: TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Humba', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            const Text('Artmage', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );

    Card ctf2 = Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          profileCard,
          // const SizedBox(height: 16),
          Divider(
            color: Color.from(alpha: 1.0, red: 1.0, green: 0.0, blue: 0.0),
          ),
          favoriteGamesCard,
        ],
      ),
    );

    var profiles = {
      "names": [null, "Maria", "Jess", "Jan", "Jake"],
      "courseSection": ["BSIT-3", null, "BSIT-3", "BSIT-3", "BSIT-3"],
      "age": [21, 22, null, 23, 21],
      "hobby": ["Gaming", "Basketball", "Soccer", null, "Reading"],
    };
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('My First Flutter Application'),
      ),
      body: ListView.builder(
        itemCount: profiles["names"]?.length,
        itemBuilder: (ctx, ind) {
          return Column(
            children: [
              Text(profiles["names"]?[ind]?.toString() ?? "Not provided"),
              const SizedBox(height: 16),
              Text(profiles["courseSection"]?[ind]?.toString() ?? "Not provided"),
              const SizedBox(height: 16),
              Text(profiles["age"]?[ind]?.toString() ?? "Not provided"),
              const SizedBox(height: 16),
              Text(profiles["hobby"]?[ind]?.toString() ?? "Not provided"),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}
