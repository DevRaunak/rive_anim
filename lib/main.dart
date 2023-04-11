import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SMIInput<bool>? myInputCheck;
  StateMachineController? mController;
  Artboard? mArtBoard;

  @override
  void initState() {
    super.initState();

    rootBundle.load('assets/rive/star.riv').then((data) {
      final file = RiveFile.import(data);

      var artBoard = file.mainArtboard;

      mController = StateMachineController.fromArtboard(artBoard, 'favBtn');

      if (mController != null) {
        artBoard.addController(mController!);
        myInputCheck = mController!.findInput('check');

        mArtBoard = artBoard;

        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rive'),
      ),
      body: mArtBoard != null
          ? Center(
              child: SizedBox(
                  width: 200,
                  height: 200,
                  child: GestureDetector(
                      onTap: () {
                        if (myInputCheck!.value == false &&
                            myInputCheck!.controller.isActive == false) {
                          myInputCheck!.value = true;
                        } else if (myInputCheck!.value == true &&
                            myInputCheck!.controller.isActive == false) {
                          myInputCheck!.value = false;
                        }
                      },
                      child: Rive(
                        artboard: mArtBoard!,
                      ))),
            )
          : SizedBox(),
    );
  }
}
