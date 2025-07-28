import 'package:bingoadmin/api_service/api_service.dart';
import 'package:bingoadmin/screens/tabbed_screen.dart';
import 'package:bingoadmin/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show TextInputFormatter, FilteringTextInputFormatter;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController baseUrlController = TextEditingController(
    text: Common.BASE_URL,
  );
  final TextEditingController bbIdController = TextEditingController(
    text: "1025505023",
  );
  Map<String, dynamic>? playerInfo;
  Map<String, dynamic>? playerData;
  String? errorMessage;
  dynamic rawApiResponse;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      baseUrlController.text = prefs.getString('baseUrl') ?? Common.BASE_URL;
      bbIdController.text = prefs.getString('bbId') ?? "1025505023";
    });
  }

  Future<void> _saveData(String baseUrl, String bbId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('baseUrl', baseUrl);
    await prefs.setString('bbId', bbId);
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 600;
    final double fieldWidth = isWide ? 400 : double.infinity;
    return Scaffold(
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
                          Icon(
                            Icons.search,
                            color: Colors.blueAccent,
                            size: 32,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Player Info Search',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'API Settings',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: fieldWidth,
                        child: TextField(
                          controller: baseUrlController,
                          decoration: const InputDecoration(
                            labelText: 'Base URL',
                            hintText: 'e.g. http://149.28.62.120:3000/',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.link),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Player Details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: fieldWidth,
                        child: TextField(
                          controller: bbIdController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'bbId',
                            hintText: 'Enter bbId',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: fieldWidth,
                        height: 56,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            final baseUrl = baseUrlController.text.trim();
                            final bbId = bbIdController.text.trim();
                            await _saveData(baseUrl, bbId);
                            setState(() {
                              errorMessage = null;
                              playerData = null;
                              playerInfo = null;
                              rawApiResponse = null;
                            });
                            var result = await PostService.playerDataFetch(
                              reqBody: {
                                "payload": {"bbId": bbId},
                              },
                              baseUrl: baseUrl,
                            );
                            if (result != null &&
                                result["data"] != null &&
                                result["data"]["playerInfo"] != null) {
                              setState(() {
                                playerData = result["data"];
                                playerInfo = result["data"]["playerInfo"];
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TabbedScreen(playerData: playerData),
                                ),
                              );
                            } else if (result != null) {
                              setState(() {
                                rawApiResponse = result;
                                errorMessage =
                                    "Player info not found in response. Showing raw response.";
                              });
                            } else {
                              setState(() {
                                errorMessage =
                                    "Something went wrong! Retry Again";
                              });
                              Fluttertoast.showToast(
                                msg: "Something went wrong! Retry Again",
                                gravity: ToastGravity.CENTER,
                              );
                            }
                          },
                          icon: const Icon(Icons.search, color: Colors.white),
                          label: const Text(
                            'Search',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      if (errorMessage != null) ...[
                        const SizedBox(height: 24),
                        Text(
                          errorMessage!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (rawApiResponse != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              rawApiResponse.toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                      ],
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
