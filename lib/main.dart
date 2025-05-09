import 'package:flutter/material.dart';

void main() => runApp(const EstifanosHobbies());

class EstifanosHobbies extends StatelessWidget {
  const EstifanosHobbies({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estifanos Hobbies',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
        cardTheme: const CardTheme(
          elevation: 4,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
        ),
      ),
      home: const HobbiesPage(),
    );
  }
}

class HobbiesPage extends StatefulWidget {
  const HobbiesPage({super.key});

  @override
  State<HobbiesPage> createState() => _HobbiesPageState();
}

class _HobbiesPageState extends State<HobbiesPage> {
  int _currentIndex = 0;
  final Set<String> _favorites = {};

  final List<Map<String, dynamic>> hobbies = [
    {'name': 'Anime', 'icon': Icons.live_tv, 'color': Colors.blue},
    {'name': 'Gym', 'icon': Icons.fitness_center, 'color': Colors.red},
    {'name': 'Drawing', 'icon': Icons.brush, 'color': Colors.green},
    {'name': 'Game', 'icon': Icons.videogame_asset, 'color': Colors.purple},
    {'name': 'Coding', 'icon': Icons.code, 'color': Colors.orange},
    {'name': 'Food', 'icon': Icons.fastfood, 'color': Colors.teal},
    {'name': 'YouTube', 'icon': Icons.play_circle_filled, 'color': Colors.pink},
  ];

  void _toggleFavorite(String hobby) {
    setState(() {
      if (_favorites.contains(hobby)) {
        _favorites.remove(hobby);
      } else {
        _favorites.add(hobby);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Hobbies'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [IconButton(icon: const Icon(Icons.settings), onPressed: () {})],
      ),
      body: _currentIndex == 0
          ? ListView.builder(
              itemCount: hobbies.length,
              itemBuilder: (context, index) {
                final hobby = hobbies[index];
                final isFavorite = _favorites.contains(hobby['name']);
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          hobby['icon'],
                          color: hobby['color'],
                          size: 30,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            hobby['name'],
                            style: TextStyle(
                              fontSize: 16,
                              color: hobby['color'],
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,
                          ),
                          onPressed: () => _toggleFavorite(hobby['name']),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : _favorites.isEmpty
              ? const Center(child: Text('No favorites yet!', style: TextStyle(fontSize: 18, color: Colors.grey)))
              : ListView.builder(
                  itemCount: _favorites.length,
                  itemBuilder: (context, index) {
                    final hobbyName = _favorites.elementAt(index);
                    final hobby = hobbies.firstWhere((h) => h['name'] == hobbyName);
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Icon(
                              hobby['icon'],
                              color: hobby['color'],
                              size: 30,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                hobby['name'],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: hobby['color'],
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                              onPressed: () => _toggleFavorite(hobby['name']),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.amber,
        backgroundColor: Colors.indigo,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}