import 'package:flutter/material.dart';
import 'package:ar_view/ar_view.dart'; // Assuming you're using ar_view for AR functionalities

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter AR App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePageWidget(),
    );
  }
}

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple, // Replacing FlutterFlowTheme
          title: const Text(
            'Augmented Reality',
            style: TextStyle(
              fontFamily: 'Inter Tight', // Replacing the theme override
              color: Colors.white,
              fontSize: 22,
              letterSpacing: 0.0,
            ),
          ),
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Center(
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () async {
                await openingARV(context); // AR View Opening Function
              },
              child: Container(
                width: 394,
                height: 93,
                decoration: BoxDecoration(
                  color: Colors.white, // Replacing secondaryBackground
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    await openingARV(context); // AR View Opening Function
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.deepPurple, // Replacing primary color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Launch AR',
                    style: TextStyle(
                      fontFamily: 'Inter Tight',
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> openingARV(BuildContext context) async {
    // Assuming this method opens the AR view. Adjust this method accordingly.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AugmentedRealityView()),
    );
  }
}
