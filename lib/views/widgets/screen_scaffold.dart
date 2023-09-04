// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:vsss/resources/numbers.dart';

class ScreenScaffold extends StatelessWidget {
  const ScreenScaffold({
    required Widget child,
    bool useScaffold = true,
    bool useSafeArea = true,
    bool centerScrollViewVertically = true,
    EdgeInsetsGeometry? edgeInsetsGeometry,
    super.key,
  })  : _child = child,
        _useScaffold = useScaffold,
        _useSafeArea = useSafeArea,
        _centerScrollViewVertically = centerScrollViewVertically,
        _edgeInsetsGeometry = edgeInsetsGeometry;

  final Widget _child;
  final bool _useScaffold;
  final bool _useSafeArea;
  final bool _centerScrollViewVertically;
  final EdgeInsetsGeometry? _edgeInsetsGeometry;

  @override
  Widget build(BuildContext context) => switch (_useScaffold) {
        true => Scaffold(
            body: _body1,
          ),
        false => _body1
      };

  Widget get _body1 => switch (_useSafeArea) {
        true => SafeArea(
            child: _body2,
          ),
        false => _body2
      };

  Widget get _body2 => switch (_centerScrollViewVertically) {
        true => Center(
            child: _body3,
          ),
        false => _body3
      };

  Widget get _body3 => SingleChildScrollView(
        padding: _edgeInsetsGeometry ??
            const EdgeInsetsDirectional.symmetric(
              vertical: largeSpacing,
              horizontal: spacing,
            ),
        child: _child,
      );
}
