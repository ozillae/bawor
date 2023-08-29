import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:auto_start_flutter/auto_start_flutter.dart';
// Import for Android features.
// import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

void main() {
  const materialApp = MaterialApp(
      //theme: ThemeData().light(),
      //darkTheme: ThemeData().dark(),
      home: WebViewApp(),
    );
  runApp(
    materialApp,
  );
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  Future<void> initAutoStart() async {
    try {
      //check auto-start availability.
      var test = await (isAutoStartAvailable as FutureOr<bool>);
      print(test);
      //if available then navigate to auto-start setting page.
      if (test) await getAutoStartPermission();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
  }

  @override
  bool get wantKeepAlive => true;
  //late final WebViewController controller;

  // late final PlatformWebViewControllerCreationParams params;
  // if (WebViewPlatform.instance is WebKitWebViewPlatform) {
  //   params = WebKitWebViewControllerCreationParams(
  //     allowsInlineMediaPlayback: true,
  //     mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
  //   );
  // } else {
  //   params = const PlatformWebViewControllerCreationParams();
  // }

  // final WebViewController controller =
  //     WebViewController.fromPlatformCreationParams(params);
  // // ···
  // if (controller.platform is AndroidWebViewController) {
  //   AndroidWebViewController.enableDebugging(true);
  //   (controller.platform as AndroidWebViewController)
  //       .setMediaPlaybackRequiresUserGesture(false);
  // }

  late final WebViewController controller;
  
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(false)
      ..loadRequest(
        Uri.parse('https://reklame.purwosejati.com/display'),
      );
  }

  @override
  Widget build(BuildContext context) {
    //mediaPlaybackRequiresUserGesture: false;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Bawor'),
      // ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}