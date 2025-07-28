import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../api_service/api_service.dart';
import '../utils/AppTheme.dart';

class Islandprogress extends StatefulWidget {
  final Map<String, dynamic>? playerData;

  const Islandprogress({Key? key, required this.playerData}) : super(key: key);

  @override
  State<Islandprogress> createState() => _IslandprogressState();
}

class _IslandprogressState extends State<Islandprogress> {
  int? selectedIslandId;
  int? selectedCityId;
  String? selectedItemId;
  int? selectedCardModeId;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppTheme.primaryColor, // 👈 change to match your theme
        statusBarIconBrightness: Brightness.light,
      ),
    );
    final playerData = widget.playerData;
    final BBID = playerData?['playerInfo']?['bbId'] ?? [];
    final String currentActiveCityRoom =
        playerData?['playerProgress']?['currentActiveCityRoom'].toString() ??
        "";
    final List islands = playerData?['islands'] ?? [];
    final List cityRoomsAll = playerData?['cityRooms'] ?? [];
    final List cardModes = playerData?['cardModes'] ?? [];

    // Find the selected island
    final selectedIsland = islands.firstWhere(
      (island) => island['islandId'] == selectedIslandId,
      orElse: () => null,
    );

    // Get cityIds for the selected island
    final List selectedCityIds = selectedIsland != null
        ? (selectedIsland['citiesRooms'] ?? [])
        : [];

    // Filter cityRooms for the selected island
    final List cityRooms = selectedCityIds.isNotEmpty
        ? cityRoomsAll
              .where((room) => selectedCityIds.contains(room['cityId']))
              .toList()
        : cityRoomsAll;

    // Find the selected city room
    final selectedCityRoom = cityRooms.firstWhere(
      (room) => room['cityId'] == selectedCityId,
      orElse: () => null,
    );

    // Get itemCollections for the selected city
    final List itemCollections = selectedCityRoom != null
        ? (selectedCityRoom['itemCollections'] ?? [])
        : [];

    final isWide = MediaQuery.of(context).size.width > 600;
    final double fieldWidth = isWide ? 400 : double.infinity;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 500),
              child: Card(
                elevation: 8,
                margin: const EdgeInsets.all(24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.map, color: Colors.blueAccent, size: 32),
                          const SizedBox(width: 12),
                          Text(
                            'Island Progress',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Current City:' + currentActiveCityRoom,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Select Island',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: fieldWidth,
                        child: DropdownButtonFormField<int>(
                          value: selectedIslandId,
                          hint: Text('Choose an island'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.landscape),
                          ),
                          isExpanded: true,
                          items: islands.map<DropdownMenuItem<int>>((island) {
                            return DropdownMenuItem<int>(
                              value: island['islandId'],
                              child: Text(
                                '${island['islandId']} - ${island['island_name']}',
                              ),
                            );
                          }).toList(),
                          onChanged: (int? newValue) {
                            setState(() {
                              selectedIslandId = newValue;
                              selectedCityId = null;
                              selectedItemId = null;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Select City Room',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: fieldWidth,
                        child: DropdownButtonFormField<int>(
                          value: selectedCityId,
                          hint: Text('Choose a city'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.location_city),
                          ),
                          isExpanded: true,
                          items: cityRooms.map<DropdownMenuItem<int>>((room) {
                            return DropdownMenuItem<int>(
                              value: room['cityId'],
                              child: Text(
                                '${room['cityId']} - ${room['city_name']}',
                              ),
                            );
                          }).toList(),
                          onChanged: (int? newValue) {
                            setState(() {
                              selectedCityId = newValue;
                              selectedItemId = null;
                            });
                          },
                        ),
                      ),
                      if (selectedCityRoom != null) ...[
                        const SizedBox(height: 24),
                        Text(
                          'Select Item',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: fieldWidth,
                          child: DropdownButtonFormField<String>(
                            value: selectedItemId,
                            hint: Text('Choose an item'),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.widgets),
                            ),
                            isExpanded: true,
                            items: itemCollections
                                .map<DropdownMenuItem<String>>((item) {
                                  return DropdownMenuItem<String>(
                                    value: item['itemId'],
                                    child: Text(item['itemId']),
                                  );
                                })
                                .toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedItemId = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),
                      Text(
                        'Select Card Mode',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: fieldWidth,
                        child: DropdownButtonFormField<int>(
                          value: selectedCardModeId,
                          hint: Text('Choose a card mode'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.style),
                          ),
                          isExpanded: true,
                          items: cardModes.map<DropdownMenuItem<int>>((mode) {
                            return DropdownMenuItem<int>(
                              value: mode['modeId'],
                              child: Text(
                                '${mode['modeId']} - ${mode['modeType']}',
                              ),
                            );
                          }).toList(),
                          onChanged: (int? newValue) {
                            setState(() {
                              selectedCardModeId = newValue;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: Colors.blueAccent,
                          ),
                          onPressed:
                              // Enable if only modeId is selected
                              ((selectedCardModeId != null &&
                                      selectedIslandId == null &&
                                      selectedCityId == null &&
                                      selectedItemId == null)
                                  // Or if all three (islandId, cityId, itemId) are selected
                                  ||
                                  (selectedIslandId != null &&
                                      selectedCityId != null &&
                                      selectedItemId != null))
                              ? () async {
                                  FocusScope.of(context).unfocus();
                                  Map<String, dynamic> payload = {};
                                  // If only modeId is selected
                                  if (selectedCardModeId != null &&
                                      selectedIslandId == null &&
                                      selectedCityId == null &&
                                      selectedItemId == null) {
                                    payload = {
                                      'bbId': BBID,
                                      'modeId': selectedCardModeId,
                                    };
                                  }
                                  // If all three (islandId, cityId, itemId) are selected
                                  else if (selectedIslandId != null &&
                                      selectedCityId != null &&
                                      selectedItemId != null) {
                                    payload = {
                                      'bbId': BBID,
                                      'islandId': selectedIslandId,
                                      'cityId': selectedCityId,
                                      'itemId': selectedItemId,
                                    };
                                  }
                                  var result =
                                      await PostService.updatePlayerProgress(
                                        reqBody: {'payload': payload},
                                      );
                                  if (result["code"] == "SUCCESS") {
                                    Navigator.pop(context);
                                  }
                                  Fluttertoast.showToast(
                                    msg: result["message"],
                                    gravity: ToastGravity.CENTER,
                                  );
                                }
                              : null,
                          icon: Icon(Icons.save, color: Colors.white),
                          label: Text(
                            'Save',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
