//* this for the overlay loading screen to avoid poping any other screen :)

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movies_app/core/confg/colors/app_colors.dart';
import 'package:movies_app/core/extension/sized_box.dart';
import 'package:movies_app/helpers/loading_controller.dart';

class LoadingScreen {
  factory LoadingScreen() => _shared;
  static final _shared = LoadingScreen._sharedInstance();
  LoadingScreen._sharedInstance();

  // Keep hold of our loading screen controller
  LoadingScreenController? controller;

  // if there is no controller we should based on the show method give that controller an overlay
  void show({required BuildContext context, required String text}) {
    if (controller?.update(text) ?? false) {
      return;
    } else {
      controller = showOverLay(context: context, text: text);
    }
  }

  // if there is a controller we should based on the hide method close that controller and reset it to null
  void hide() {
    controller?.close();
    controller = null;
  }

  LoadingScreenController showOverLay({
    required BuildContext context,
    // overlay loading screen can note be made without text
    required String text,
  }) {
    // string that come from the loadingScreenController
    final _text = StreamController<String>();
    _text.add(text);

    // will need the state of the overlay to display our overlay
    final state = Overlay.of(context);
    // Exract the available size that the overlay can not have on screen
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overLay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: size.width * 0.8,
                maxHeight: size.height * 0.8,
                minWidth: size.width * 0.5,
              ),
              decoration: BoxDecoration(
                // color: Colors.white,
                // borderRadius: BorderRadius.circular(10.0),
                color: Colors.black.withOpacity(0.85),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      10.hight,
                      const CircularProgressIndicator(color: AppColors.primary),
                      20.hight,
                      // cause the text in stream and could change we will use stream builder
                      StreamBuilder(
                        stream: _text.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data as String,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    state?.insert(overLay);

    return LoadingScreenController(
      close: () {
        _text.close();
        overLay.remove();
        return true;
      },
      update: (text) {
        _text.add(text);
        return true;
      },
    );
  }
}
