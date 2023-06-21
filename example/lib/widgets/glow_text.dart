// ignore_for_file: overridden_fields

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GlowText extends Text {
  const GlowText({
    this.text,
    Key? key,
    this.style,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textSpan,
    required this.glowColor,
  }) : super(text ?? 'data', key: key);

  final String? text;

  @override
  final InlineSpan? textSpan;

  @override
  final TextStyle? style;

  @override
  final TextAlign? textAlign;

  @override
  final bool? softWrap;

  @override
  final TextOverflow? overflow;

  @override
  final int? maxLines;

  final Color glowColor;

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context);
    var effectiveTextStyle = style;
    if (style == null || style!.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(style);
    }
    if (style == null || style!.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(style);
    }
    if (MediaQuery.boldTextOverride(context)) {
      effectiveTextStyle = effectiveTextStyle!
          .merge(const TextStyle(fontWeight: FontWeight.bold));
    }

    effectiveTextStyle = effectiveTextStyle!.merge(
      TextStyle(
        shadows: <Shadow>[
          Shadow(
            color: glowColor,
            offset: const Offset(0, 1),
            blurRadius: 8,
          ),
          Shadow(
            color: glowColor,
            offset: const Offset(0, -1),
            blurRadius: 8,
          ),
        ],
      ),
    );

    Widget result = RichText(
      textAlign: textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap ?? defaultTextStyle.softWrap,
      overflow: overflow ?? defaultTextStyle.overflow,
      textScaleFactor: textScaleFactor ?? MediaQuery.textScaleFactorOf(context),
      maxLines: maxLines ?? defaultTextStyle.maxLines,
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis ?? defaultTextStyle.textWidthBasis,
      text: TextSpan(
        style: effectiveTextStyle,
        text: text,
        children:
            (textSpan != null ? <TextSpan>[(textSpan as TextSpan)] : null),
      ),
    );
    if (semanticsLabel != null) {
      result = Semantics(
        textDirection: textDirection,
        label: semanticsLabel,
        child: ExcludeSemantics(
          child: result,
        ),
      );
    }
    return result;
  }
}
