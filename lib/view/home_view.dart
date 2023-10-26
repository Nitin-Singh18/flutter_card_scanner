import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ml_card_scanner/ml_card_scanner.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isCamera = true;
  final ScannerWidgetController _controller = ScannerWidgetController();
  CardInfo? cardInfo;

  @override
  void initState() {
    controllerMethod();
    super.initState();
  }

  void controllerMethod() {
    if (!isCamera) {
      cardInfo = null;
      isCamera = true;
      setState(() {});
    }
    _controller
      ..setCardListener((value) {
        setState(() {
          cardInfo = value;
        });
        if (cardInfo != null) {
          _controller.disableCameraPreview();
          isCamera = false;
        }
      })
      ..setErrorListener((exception) {
        if (kDebugMode) {
          print('Error: ${exception.message}');
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Debit Card'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isCamera)
              Expanded(
                child: ScannerWidget(
                  controller: _controller,
                  overlayOrientation: CardOrientation.landscape,
                ),
              ),
            if (!isCamera)
              ElevatedButton(
                  onPressed: () {
                    controllerMethod();
                  },
                  child: const Text('Scan Camera')),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(cardInfo?.number.toString() ?? 'No Card Details'),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
