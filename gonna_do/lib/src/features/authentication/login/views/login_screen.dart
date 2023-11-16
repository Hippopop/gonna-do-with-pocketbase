import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gonna_do/src/features/authentication/login/views/oni/rive_oni.dart';
import 'package:rive/rive.dart' as rive;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.artboard});
  final rive.Artboard artboard;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late rive.RiveAnimationController _oniController;
  FocusNode _node = FocusNode();
  final _controller = TextEditingController();

  InputDecoration decoration = InputDecoration(
    isDense: true,
    border: OutlineInputBorder(
      borderSide: const BorderSide(width: 1.5, color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white, width: 2.5),
      borderRadius: BorderRadius.circular(8),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 1.5, color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    ),
    iconColor: Colors.grey,
    // floatingLabelStyle: TextStyles.normalTextBoldStyle()
    // .copyWith(color: Colors.grey, fontSize: 24),
    // labelStyle:
    // TextStyles.smallTextStyle().copyWith(color: ColorResources.colorBlack),
    suffixIconColor: Colors.grey,
    filled: true,
  );

  @override
  void initState() {
    super.initState();
    _node.addListener(() {
      if (_node.hasFocus) {
        log(_node.offset.toString());
        oni.move(_node.offset);
        _controller.addListener(
          () {
            oni.updateOffset(_controller.selection.extentOffset == 0
                ? 1
                : _controller.selection.extentOffset);
            log("Updating");
          },
        );
      }
    });
  }

  late RiveOni oni;

  @override
  Widget build(BuildContext context) {
    oni = RiveOni(widget.artboard);

    return Scaffold(
      backgroundColor: const Color(0xffE380DD),
      body: SizedBox.expand(
        child: AspectRatio(
          aspectRatio: 9 / 16,
          child: Center(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Color(0xffE380DD),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: MouseRegion(
                      onHover: (event) => oni.move(event.localPosition),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: GestureDetector(
                          onTapDown: (_) => oni.onTapDown,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox.square(
                              child: rive.Rive(
                                artboard: widget.artboard,
                                // useArtboardSize: true,
                              ),
                            ),
                          ),
                        )
                        /* RiveAnimation.asset(
                          controllers: [
                            // _oniController,
                          ],
                          'assets/rive_assets/oni/oni-fan-art.riv',
                                    
                        ) */
                        ,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Text('Testing'),
                        SizedBox(height: 12),
                        TextField(
                          focusNode: _node,
                          controller: _controller,
                          decoration: decoration,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (_controller.text != "password") {
                                oni.onTapDown();
                              }
                            },
                            child: Text("Enter"))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
