import 'package:flutter/material.dart';
import 'package:bugbusters/application.dart';

class SocialMediaButton extends InkWell {
  SocialMediaButton(
    SocialMediaIcons iconData, {
    Key? key,
    String? url,
    bool mini = false,
    bool constrainMinWidth = true,
    double? iconSize,
    double? iconBorderRadius,
    double? splashRadius,
    double? splashBorderRadius,
    TextStyle? textStyle,
    GestureTapCallback? onTap,
    GestureTapCallback? onLongPress,
    ValueChanged<bool>? onHighlightChanged,
    ValueChanged<bool>? onHover,
  }) : super(
          key: key,
          borderRadius:
              BorderRadius.all(Radius.circular(splashBorderRadius ?? 4.0)),
          child: Builder(builder: (_) {
            String icon;
            switch (iconData) {
              case SocialMediaIcons.facebook:
                icon = 'Facebook';
                break;
              case SocialMediaIcons.github:
                icon = 'GitHub';
                break;
              case SocialMediaIcons.instagram:
                icon = 'Instagram';
                break;
              case SocialMediaIcons.linkedIn:
                icon = 'LinkedIn';
                break;
              case SocialMediaIcons.medium:
                icon = 'Medium';
                break;
              case SocialMediaIcons.twitter:
                icon = 'Twitter';
                break;
              case SocialMediaIcons.youtube:
                icon = 'YouTube';
                break;
            }
            return ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constrainMinWidth ? 120.0 : 0.0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: ClipRRect(
                      borderRadius: BorderRadius.all(
                          Radius.circular(iconBorderRadius ?? 4.0)),
                      child: Image(
                          image: AssetImage(
                              '${Assets.icons}/${icon.toLowerCase()}.png')),
                    ),
                    iconSize: iconSize ?? 24.0,
                    splashRadius: splashRadius,
                    onPressed: null,
                  ),
                  Visibility(
                    visible: !mini,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        icon,
                        style: textStyle ??
                            const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          onTap: onTap ??
              (url == null
                  ? null
                  : () async {
                      await launchURL(url);
                    }),
          onLongPress: onLongPress,
          onHover: onHover,
          onHighlightChanged: onHighlightChanged,
        );
}

enum SocialMediaIcons {
  facebook,
  instagram,
  github,
  linkedIn,
  medium,
  twitter,
  youtube,
}
