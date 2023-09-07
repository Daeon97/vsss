// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:vsss/resources/numbers.dart';

class ScreenScaffold extends StatelessWidget {
  const ScreenScaffold({
    required Widget child,
    bool useScaffold = true,
    bool useSafeArea = true,
    bool useScrollView = true,
    bool centerViewVertically = true,
    EdgeInsetsGeometry? edgeInsetsGeometry,
    FloatingActionButton? floatingActionButton,
    Widget? appBarTitle,
    Widget? appBarLeading,
    super.key,
  })  : _child = child,
        _useScaffold = useScaffold,
        _useSafeArea = useSafeArea,
        _useScrollView = useScrollView,
        _centerViewVertically = centerViewVertically,
        _edgeInsetsGeometry = edgeInsetsGeometry,
        _floatingActionButton = floatingActionButton,
        _appBarTitle = appBarTitle,
        _appBarLeading = appBarLeading;

  final Widget _child;
  final bool _useScaffold;
  final bool _useSafeArea;
  final bool _useScrollView;
  final bool _centerViewVertically;
  final EdgeInsetsGeometry? _edgeInsetsGeometry;
  final FloatingActionButton? _floatingActionButton;
  final Widget? _appBarTitle;
  final Widget? _appBarLeading;

  @override
  Widget build(BuildContext context) => switch (_useScaffold) {
        true => Scaffold(
            appBar: switch (_appBarTitle) {
              null => null,
              _ => AppBar(
                  leading: _appBarLeading,
                  title: _appBarTitle,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.vertical(
                      bottom: Radius.circular(
                        largeSpacing,
                      ),
                    ),
                  ),
                )
            },
            body: _body1,
            floatingActionButton: _floatingActionButton,
          ),
        false => _body1
      };

  Widget get _body1 => switch (_useSafeArea) {
        true => SafeArea(
            child: _body2,
          ),
        false => _body2
      };

  Widget get _body2 => switch (_centerViewVertically) {
        true => Center(
            child: _body3,
          ),
        false => _body3
      };

  Widget get _body3 => switch (_useScrollView) {
        true => SingleChildScrollView(
            child: _body4,
          ),
        false => _body4
      };

  Widget get _body4 => Padding(
        padding: _edgeInsetsGeometry ??
            const EdgeInsetsDirectional.symmetric(
              vertical: largeSpacing,
              horizontal: spacing,
            ),
        child: _child,
      );
}
