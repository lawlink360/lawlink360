import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VerificationWebViewScreen extends StatefulWidget {
  final String title;
  final String url;

  const VerificationWebViewScreen({
    super.key,
    required this.title,
    required this.url,
  });

  @override
  State<VerificationWebViewScreen> createState() =>
      _VerificationWebViewScreenState();
}

class _VerificationWebViewScreenState
    extends State<VerificationWebViewScreen> {
  late final WebViewController _controller;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFFFFFFF))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (_) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: _controller,
          ),

          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}