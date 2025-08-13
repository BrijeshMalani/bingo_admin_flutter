import 'package:bingoadmin/utils/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../api_service/api_service.dart';

class Playerdata extends StatefulWidget {
  final Map<String, dynamic>? playerData;

  const Playerdata({Key? key, required this.playerData}) : super(key: key);

  @override
  State<Playerdata> createState() => _PlayerdataState();
}

class _PlayerdataState extends State<Playerdata> {
  late TextEditingController bbIdController;
  late TextEditingController usernameController;
  late TextEditingController creditesController;
  late TextEditingController gemsController;
  late TextEditingController coinsController;
  late TextEditingController xpController;
  late TextEditingController levelController;
  late TextEditingController powerups1Controller;
  late TextEditingController powerups2Controller;
  late TextEditingController powerups3Controller;
  late TextEditingController powerups4Controller;
  late TextEditingController powerups5Controller;
  late TextEditingController powerups6Controller;
  late TextEditingController powerups7Controller;
  late TextEditingController powerups8Controller;
  late TextEditingController powerups9Controller;
  late TextEditingController daycurrentDayController;
  late TextEditingController weekcurrentWeekController;
  late TextEditingController maxAdswheelController;
  late TextEditingController remainingAdswheelController;
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    final playerData = widget.playerData!;
    bbIdController = TextEditingController(
      text: playerData["playerInfo"]!["bbId"].toString(),
    );
    usernameController = TextEditingController(
      text: playerData["playerInfo"]?["username"] ?? "",
    );
    creditesController = TextEditingController(
      text: (playerData["playerInfo"]?["balance"]?["credites"] ?? 0).toString(),
    );
    gemsController = TextEditingController(
      text: (playerData["playerInfo"]?["balance"]?["gems"] ?? 0).toString(),
    );
    coinsController = TextEditingController(
      text: (playerData["playerInfo"]?["balance"]?["coins"] ?? 0).toString(),
    );
    xpController = TextEditingController(
      text: (playerData["playerInfo"]?["gameState"]?["xp"] ?? 0).toString(),
    );
    levelController = TextEditingController(
      text: (playerData["playerInfo"]?["gameState"]?["level"] ?? 0).toString(),
    );
    powerups1Controller = TextEditingController(
      text: (playerData["playerInfo"]?["powerups"]?["1"] ?? 0).toString(),
    );
    powerups2Controller = TextEditingController(
      text: (playerData["playerInfo"]?["powerups"]?["2"] ?? 0).toString(),
    );
    powerups3Controller = TextEditingController(
      text: (playerData["playerInfo"]?["powerups"]?["3"] ?? 0).toString(),
    );
    powerups4Controller = TextEditingController(
      text: (playerData["playerInfo"]?["powerups"]?["4"] ?? 0).toString(),
    );
    powerups5Controller = TextEditingController(
      text: (playerData["playerInfo"]?["powerups"]?["5"] ?? 0).toString(),
    );
    powerups6Controller = TextEditingController(
      text: (playerData["playerInfo"]?["powerups"]?["6"] ?? 0).toString(),
    );
    powerups7Controller = TextEditingController(
      text: (playerData["playerInfo"]?["powerups"]?["7"] ?? 0).toString(),
    );
    powerups8Controller = TextEditingController(
      text: (playerData["playerInfo"]?["powerups"]?["8"] ?? 0).toString(),
    );
    powerups9Controller = TextEditingController(
      text: (playerData["playerInfo"]?["powerups"]?["9"] ?? 0).toString(),
    );
    daycurrentDayController = TextEditingController(
      // text:
      //     (playerData["playerInfo"]!["rewardStatus"]!["day"]?["currentDay"] ??
      //             0)
      //         .toString(),
    );
    weekcurrentWeekController = TextEditingController(
      // text:
      //     (playerData["playerInfo"]!["rewardStatus"]!["week"]?["currentWeek"] ??
      //             0)
      //         .toString(),
    );
    maxAdswheelController = TextEditingController(
      text:
          (playerData["playerInfo"]!["wheelStatus"]!["adsWheelStatus"]?["maxAdsWheel"] ??
                  0)
              .toString(),
    );
    remainingAdswheelController = TextEditingController(
      text:
          (playerData["playerInfo"]!["wheelStatus"]!["adsWheelStatus"]?["remainingAdsWheel"] ??
                  0)
              .toString(),
    );
    isSwitched = playerData["playerInfo"]?["staticballs"];
  }

  @override
  void dispose() {
    bbIdController.dispose();
    usernameController.dispose();
    creditesController.dispose();
    gemsController.dispose();
    coinsController.dispose();
    xpController.dispose();
    levelController.dispose();
    powerups1Controller.dispose();
    powerups2Controller.dispose();
    powerups3Controller.dispose();
    powerups4Controller.dispose();
    powerups5Controller.dispose();
    powerups6Controller.dispose();
    powerups7Controller.dispose();
    powerups8Controller.dispose();
    powerups9Controller.dispose();
    daycurrentDayController.dispose();
    weekcurrentWeekController.dispose();
    maxAdswheelController.dispose();
    remainingAdswheelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppTheme.primaryColor, // 👈 change to match your theme
        statusBarIconBrightness: Brightness.light,
      ),
    );
    final playerData = widget.playerData;
    final isWide = MediaQuery.of(context).size.width > 600;
    final double fieldWidth = isWide ? 300 : double.infinity;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 700),
                  child: Card(
                    elevation: 4,
                    margin: const EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: playerData?['playerInfo'] != null
                          ? Column(
                              // <-- change from ListView to Column
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Player Info Section
                                Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: Colors.blueAccent,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Player Info',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(thickness: 2),
                                Wrap(
                                  spacing: 16,
                                  runSpacing: 8,
                                  children: [
                                    SizedBox(
                                      width: fieldWidth,
                                      child: TextField(
                                        controller: bbIdController,
                                        decoration: InputDecoration(
                                          labelText: 'BBID',
                                          prefixIcon: Icon(Icons.badge),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: fieldWidth,
                                      child: TextField(
                                        controller: usernameController,
                                        decoration: InputDecoration(
                                          labelText: 'UserName',
                                          prefixIcon: Icon(
                                            Icons.account_circle,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                // Balance Section
                                Row(
                                  children: [
                                    Icon(
                                      Icons.account_balance_wallet,
                                      color: Colors.green,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Balance',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(thickness: 2),
                                Wrap(
                                  spacing: 16,
                                  runSpacing: 8,
                                  children: [
                                    SizedBox(
                                      width: fieldWidth,
                                      child: TextField(
                                        controller: creditesController,
                                        decoration: InputDecoration(
                                          labelText: 'Credites',
                                          prefixIcon: Icon(Icons.credit_card),
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    SizedBox(
                                      width: fieldWidth,
                                      child: TextField(
                                        controller: gemsController,
                                        decoration: InputDecoration(
                                          labelText: 'Gems',
                                          prefixIcon: Icon(Icons.diamond),
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    SizedBox(
                                      width: fieldWidth,
                                      child: TextField(
                                        controller: coinsController,
                                        decoration: InputDecoration(
                                          labelText: 'Coins',
                                          prefixIcon: Icon(
                                            Icons.monetization_on,
                                          ),
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                // Game State Section
                                Row(
                                  children: [
                                    Icon(
                                      Icons.sports_esports,
                                      color: Colors.deepPurple,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Game State',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(thickness: 2),
                                Wrap(
                                  spacing: 16,
                                  runSpacing: 8,
                                  children: [
                                    SizedBox(
                                      width: fieldWidth,
                                      child: TextField(
                                        controller: xpController,
                                        decoration: InputDecoration(
                                          labelText: 'XP',
                                          prefixIcon: Icon(Icons.star),
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    SizedBox(
                                      width: fieldWidth,
                                      child: TextField(
                                        controller: levelController,
                                        decoration: InputDecoration(
                                          labelText: 'Level',
                                          prefixIcon: Icon(Icons.leaderboard),
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                // PowerUps Section
                                Row(
                                  children: [
                                    Icon(Icons.flash_on, color: Colors.orange),
                                    const SizedBox(width: 8),
                                    Text(
                                      'PowerUps',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(thickness: 2),
                                GridView.count(
                                  crossAxisCount: isWide ? 3 : 2,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  childAspectRatio: 3.5,
                                  children: [
                                    TextField(
                                      controller: powerups1Controller,
                                      decoration: InputDecoration(
                                        labelText: 'Single Duab',
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                    TextField(
                                      controller: powerups2Controller,
                                      decoration: InputDecoration(
                                        labelText: 'Peti',
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                    TextField(
                                      controller: powerups3Controller,
                                      decoration: InputDecoration(
                                        labelText: 'XP',
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                    TextField(
                                      controller: powerups4Controller,
                                      decoration: InputDecoration(
                                        labelText: 'Duble Duab',
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                    TextField(
                                      controller: powerups5Controller,
                                      decoration: InputDecoration(
                                        labelText: 'x2',
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                    TextField(
                                      controller: powerups6Controller,
                                      decoration: InputDecoration(
                                        labelText: 'Instant Win',
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                    TextField(
                                      controller: powerups7Controller,
                                      decoration: InputDecoration(
                                        labelText: 'Super Charge',
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                    TextField(
                                      controller: powerups8Controller,
                                      decoration: InputDecoration(
                                        labelText: 'Tripple Duab',
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                    TextField(
                                      controller: powerups9Controller,
                                      decoration: InputDecoration(
                                        labelText: 'Wild Duab',
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                // Toggle Button Section
                                Row(
                                  children: [
                                    Text(
                                      'Static Ball: ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    Switch(
                                      value: isSwitched,
                                      onChanged: (bool value) async {
                                        setState(() {
                                          isSwitched =
                                              value; // Update the state
                                        });
                                        FocusScope.of(context).unfocus();
                                        var result =
                                            await PostService.updatePlayerInformation(
                                              reqBody: {
                                                "payload": {
                                                  "bbId": bbIdController.text
                                                      .trim(),
                                                  "staticballs": isSwitched,
                                                },
                                              },
                                            );
                                        Fluttertoast.showToast(
                                          msg:
                                              "Static Ball: ${value ? 'ON' : 'OFF'}",
                                          gravity: ToastGravity.CENTER,
                                        );
                                      },
                                      activeColor: Colors.green,
                                      inactiveThumbColor: Colors.grey,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                // Wheel Status Section
                                Row(
                                  children: [
                                    Icon(Icons.casino, color: Colors.teal),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Daily Reward Bonus',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(thickness: 2),
                                Wrap(
                                  spacing: 16,
                                  runSpacing: 8,
                                  children: [
                                    SizedBox(
                                      width: fieldWidth,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller:
                                                  daycurrentDayController,
                                              decoration: InputDecoration(
                                                labelText: 'Current Day',
                                                prefixIcon: Icon(
                                                  Icons.calendar_today,
                                                ),
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0,
                                            ),
                                            child: Text(
                                              '${playerData?['playerInfo']?['rewardStatus']?['day']?['currentDay'] ?? '-'}',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: fieldWidth,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller:
                                                  weekcurrentWeekController,
                                              decoration: InputDecoration(
                                                labelText: 'Current Week',
                                                prefixIcon: Icon(
                                                  Icons.calendar_view_week,
                                                ),
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0,
                                            ),
                                            child: Text(
                                              '${playerData?['playerInfo']?['rewardStatus']?['week']?['currentWeek'] ?? '-'}',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                Row(
                                  children: [
                                    Icon(Icons.casino, color: Colors.teal),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Wheel Status',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(thickness: 2),
                                Wrap(
                                  spacing: 16,
                                  runSpacing: 8,
                                  children: [
                                    SizedBox(
                                      width: fieldWidth,
                                      child: TextField(
                                        controller: maxAdswheelController,
                                        decoration: InputDecoration(
                                          labelText: 'Max Ads Wheel',
                                          prefixIcon: Icon(
                                            Icons.calendar_today,
                                          ),
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    SizedBox(
                                      width: fieldWidth,
                                      child: TextField(
                                        controller: remainingAdswheelController,
                                        decoration: InputDecoration(
                                          labelText: 'Remaining Ads Wheel',
                                          prefixIcon: Icon(
                                            Icons.calendar_view_week,
                                          ),
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Center(
                                  child: Container(
                                    width: fieldWidth,
                                    height: 43,
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        backgroundColor: Colors.blueAccent,
                                      ),
                                      onPressed: () async {
                                        FocusScope.of(context).unfocus();
                                        var result =
                                            await PostService.updatePlayerInformation(
                                              reqBody: {
                                                "payload": {
                                                  "bbId": bbIdController.text
                                                      .trim(),
                                                  "credites": creditesController
                                                      .text
                                                      .trim(),
                                                  "gems": gemsController.text
                                                      .trim(),
                                                  "coins": coinsController.text
                                                      .trim(),
                                                  "level": levelController.text
                                                      .trim(),
                                                  "xpValue": xpController
                                                      .text
                                                      .trim(),
                                                  "power1": powerups1Controller
                                                      .text
                                                      .trim(),
                                                  "power2": powerups2Controller
                                                      .text
                                                      .trim(),
                                                  "power3": powerups3Controller
                                                      .text
                                                      .trim(),
                                                  "power4": powerups4Controller
                                                      .text
                                                      .trim(),
                                                  "power5": powerups5Controller
                                                      .text
                                                      .trim(),
                                                  "power6": powerups6Controller
                                                      .text
                                                      .trim(),
                                                  "power7": powerups7Controller
                                                      .text
                                                      .trim(),
                                                  "power8": powerups8Controller
                                                      .text
                                                      .trim(),
                                                  "power9": powerups9Controller
                                                      .text
                                                      .trim(),
                                                  if (daycurrentDayController
                                                      .text
                                                      .isNotEmpty)
                                                    "rewardStatusDayCurrentDay":
                                                        daycurrentDayController
                                                            .text
                                                            .trim(),
                                                  if (weekcurrentWeekController
                                                      .text
                                                      .isNotEmpty)
                                                    "rewardStatusWeekCurrentWeek":
                                                        weekcurrentWeekController
                                                            .text
                                                            .trim(),
                                                  "maxAdsWheel":
                                                      maxAdswheelController.text
                                                          .trim(),
                                                  "remainingAdsWheel":
                                                      remainingAdswheelController
                                                          .text
                                                          .trim(),
                                                },
                                              },
                                            );
                                        if (result["code"] == "SUCCESS") {
                                          Navigator.pop(context);
                                        }
                                        Fluttertoast.showToast(
                                          msg: result["message"],
                                          gravity: ToastGravity.CENTER,
                                        );
                                      },
                                      icon: Icon(
                                        Icons.save,
                                        color: Colors.white,
                                      ),
                                      label: Text(
                                        'Save',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Center(
                                  child: Container(
                                    width: fieldWidth,
                                    height: 43,
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        textStyle: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onPressed: () async {
                                        FocusScope.of(context).unfocus();
                                        var result =
                                            await PostService.deletePlayer(
                                              reqBody: {
                                                "payload": {
                                                  "bbId": bbIdController.text
                                                      .trim(),
                                                },
                                              },
                                            );
                                        if (result["code"] == "SUCCESS") {
                                          Navigator.pop(context);
                                        }
                                        Fluttertoast.showToast(
                                          msg: result["message"],
                                          gravity: ToastGravity.CENTER,
                                        );
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                      label: Text(
                                        'Delete User',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const Center(child: Text('No player info found.')),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
