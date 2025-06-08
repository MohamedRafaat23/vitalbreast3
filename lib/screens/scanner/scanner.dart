import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:vitalbreast3/widgets/custom_elevated_button.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() {
          _errorMessage = 'No cameras found on device';
        });
        return;
      }

      final backCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      _cameraController = CameraController(
        backCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _cameraController?.initialize();
      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
          _errorMessage = null;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to initialize camera: $e';
        });
      }
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.only(top: 30, bottom: 20),
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: const Text(
              'Scanner',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),

          const Divider(height: 1, color: Color.fromARGB(255, 116, 116, 116)),

          // Scanner Area
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (_errorMessage != null)
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, size: 48, color: Colors.red),
                          const SizedBox(height: 16),
                          Text(
                            _errorMessage!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    )
                  else if (_isCameraInitialized)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CameraPreview(_cameraController!),
                    )
                  else
                    const Center(child: CircularProgressIndicator()),

                  // Scanner frame
                  if (_isCameraInitialized)
                    CustomPaint(
                      size: const Size(250, 250),
                      painter: ScannerFramePainter(),
                    ),
                ],
              ),
            ),
          ),

          // Upload Button Area
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.pink[50],
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.cloud_upload_outlined,
                  size: 30,
                  color: Colors.black,
                ),
                const SizedBox(height: 16),
                CustomElevatedButton(
                  text: 'Take Picture',
                  onTap: () async {
                    if (_cameraController != null && _cameraController!.value.isInitialized) {
                      try {
                        final XFile file = await _cameraController!.takePicture();
                        debugPrint('Picture saved to: ${file.path}');
                        // TODO: Handle the captured image
                        // You might want to navigate to a preview screen or process the image
                      } catch (e) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error taking picture: $e')),
                          );
                        }
                      }
                    } else {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Camera not initialized')),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ScannerFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.black
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;

    final width = size.width;
    final height = size.height;
    final cornerSize = 30.0;

    // Top-left corner
    canvas.drawLine(const Offset(0, 0), Offset(cornerSize, 0), paint);
    canvas.drawLine(const Offset(0, 0), Offset(0, cornerSize), paint);

    // Top-right corner
    canvas.drawLine(Offset(width - cornerSize, 0), Offset(width, 0), paint);
    canvas.drawLine(Offset(width, 0), Offset(width, cornerSize), paint);

    // Middle horizontal line
    canvas.drawLine(Offset(0, height / 2), Offset(width, height / 2), paint);

    // Bottom-left corner
    canvas.drawLine(Offset(0, height - cornerSize), Offset(0, height), paint);
    canvas.drawLine(Offset(0, height), Offset(cornerSize, height), paint);

    // Bottom-right corner
    canvas.drawLine(
      Offset(width - cornerSize, height),
      Offset(width, height),
      paint,
    );
    canvas.drawLine(
      Offset(width, height - cornerSize),
      Offset(width, height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
