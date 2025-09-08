import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bingoadmin/api_service/api_service.dart';
import 'package:bingoadmin/screens/tabbed_screen.dart';
import 'package:bingoadmin/utils/common.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
  final List<String> baseUrlOptions = [
    Common.BASE_URL,
    'http://149.28.62.120:3000/',
    'http://139.84.145.171:3000/',
  ];
  Map<String, dynamic>? playerInfo;
  Map<String, dynamic>? playerData;
  String? errorMessage;
  dynamic rawApiResponse;
  bool isLoading = false;

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
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB), // Light background
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Card(
                elevation: 12,
                margin: const EdgeInsets.all(24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // App Name/Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.sports_esports,
                            color: Colors.blueAccent,
                            size: 36,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Bingo Admin',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      // API Settings Section
                      Row(
                        children: [
                          Icon(Icons.settings, color: Colors.blueGrey[400]),
                          const SizedBox(width: 8),
                          Text(
                            'API Settings',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[700],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: fieldWidth,
                        child: TextField(
                          controller: baseUrlController,
                          decoration: InputDecoration(
                            labelText: 'Base URL',
                            hintText: 'e.g. http://149.28.62.120:3000/',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.link),
                            suffixIcon: PopupMenuButton<String>(
                              icon: const Icon(Icons.arrow_drop_down),
                              tooltip: 'Select Base URL',
                              onSelected: (String selectedUrl) {
                                setState(() {
                                  baseUrlController.text = selectedUrl;
                                  baseUrlController.selection =
                                      TextSelection.collapsed(
                                        offset: selectedUrl.length,
                                      );
                                });
                              },
                              itemBuilder: (BuildContext context) {
                                return baseUrlOptions
                                    .map(
                                      (option) => PopupMenuItem<String>(
                                        value: option,
                                        child: Text(option),
                                      ),
                                    )
                                    .toList();
                              },
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      // Player Details Section
                      Row(
                        children: [
                          Icon(Icons.person, color: Colors.blueGrey[400]),
                          const SizedBox(width: 8),
                          Text(
                            'Player Details',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[700],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: fieldWidth,
                        child: TextField(
                          controller: bbIdController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            labelText: 'bbId',
                            hintText: 'Enter bbId',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.numbers),
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                        ),
                      ),
                      const SizedBox(height: 36),
                      // Search Button
                      SizedBox(
                        width: fieldWidth,
                        height: 56,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: isLoading
                              ? null
                              : () async {
                                  FocusScope.of(context).unfocus();
                                  final baseUrl = baseUrlController.text.trim();
                                  final bbId = bbIdController.text.trim();
                                  await _saveData(baseUrl, bbId);
                                  setState(() {
                                    errorMessage = null;
                                    playerData = null;
                                    playerInfo = null;
                                    rawApiResponse = null;
                                    isLoading = true;
                                  });
                                  var result =
                                      await PostService.playerDataFetch(
                                        reqBody: {
                                          "payload": {"bbId": bbId},
                                        },
                                        baseUrl: baseUrl,
                                      );
                                  setState(() {
                                    isLoading = false;
                                  });
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
                                        builder: (context) => TabbedScreen(
                                          playerData: playerData,
                                        ),
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
                          icon: isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : const Icon(Icons.search, color: Colors.white),
                          label: Text(
                            isLoading ? 'Searching...' : 'Search',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      // Error/Feedback Section
                      if (errorMessage != null) ...[
                        const SizedBox(height: 28),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.redAccent),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.error_outline,
                                    color: Colors.redAccent,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      errorMessage!,
                                      style: const TextStyle(
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
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
                          ),
                        ),
                      ],
                      // ... Add more feedback or success UI here if needed ...
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
