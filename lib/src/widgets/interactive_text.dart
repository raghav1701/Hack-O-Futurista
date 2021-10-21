import 'package:flutter/material.dart';

class InteractiveText extends InkWell {
  InteractiveText(
    String data, {
    Key? key,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    Color? textColor = const Color(0xFF0B4AAA),
    FontWeight? fontWeight = FontWeight.bold,
    GestureTapCallback? onTap,
    GestureTapCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onHighlightChanged,
  }) : super(
          key: key,
          splashColor: Colors.transparent,
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          focusColor: Colors.transparent,
          child: Text(
            data,
            style: style ??
                TextStyle(
                  color: textColor,
                  fontWeight: fontWeight,
                ),
            strutStyle: strutStyle,
            textAlign: textAlign,
            textDirection: textDirection,
            locale: locale,
            softWrap: softWrap,
            overflow: overflow ?? TextOverflow.ellipsis,
            textScaleFactor: textScaleFactor,
            maxLines: maxLines,
            semanticsLabel: semanticsLabel,
            textWidthBasis: textWidthBasis,
            textHeightBehavior: textHeightBehavior,
          ),
          onTap: onTap,
          onLongPress: onLongPress,
          onHover: onHover,
          onHighlightChanged: onHighlightChanged,
        );
}
