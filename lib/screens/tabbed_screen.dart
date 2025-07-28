import 'package:bingoadmin/screens/IslandProgress.dart';
import 'package:flutter/material.dart';
import 'package:bingoadmin/screens/playerData.dart';
import 'package:bingoadmin/screens/dummy_screens.dart';

class TabbedScreen extends StatefulWidget {
  final Map<String, dynamic>? playerData;

  const TabbedScreen({Key? key, this.playerData}) : super(key: key);

  @override
  _TabbedScreenState createState() => _TabbedScreenState();
}

class _TabbedScreenState extends State<TabbedScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Define screens and their corresponding navigation metadata
    final List<Map<String, dynamic>> _navigation = [
      {
        'screen': Playerdata(playerData: widget.playerData),
        'label': 'Player Data',
        'icon': Icons.person,
      },
      {
        'screen': Islandprogress(playerData: widget.playerData),
        'label': 'Progress',
        'icon': Icons.area_chart,
      },
      {'screen': DummyScreen2(), 'label': 'Tab 2', 'icon': Icons.tab},
      {'screen': DummyScreen3(), 'label': 'Tab 3', 'icon': Icons.tab},
    ];

    final bool isWide = MediaQuery.of(context).size.width >= 600;

    if (isWide) {
      // Desktop/Tablet layout
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: _currentIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              destinations: _navigation.map((item) {
                return NavigationRailDestination(
                  icon: Icon(item['icon']),
                  label: Text(item['label']),
                );
              }).toList(),
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: _navigation[_currentIndex]['screen']),
          ],
        ),
      );
    } else {
      // Mobile layout
      return Scaffold(
        appBar: AppBar(
          title: Text(_navigation[_currentIndex]['label']),
          backgroundColor: Colors.blueAccent,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blueAccent),
                child: Text(
                  'Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              for (int i = 0; i < _navigation.length; i++)
                ListTile(
                  leading: Icon(_navigation[i]['icon']),
                  title: Text(_navigation[i]['label']),
                  selected: _currentIndex == i,
                  onTap: () {
                    setState(() {
                      _currentIndex = i;
                    });
                    Navigator.pop(context); // Close the drawer
                  },
                ),
            ],
          ),
        ),
        body: _navigation[_currentIndex]['screen'],
      );
    }
  }
}
