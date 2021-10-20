import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget {
  /// Default theme for this switch button is very similar to one, comes
  /// prebuilt with flutter.
  ///
  /// See Also:
  /// * SwitchButton.icon
  /// * SwitchButton.packed
  /// * SwitchButton.packedIcon
  /// * SwitchButton.packedAndBordered
  const SwitchButton({
    Key? key,
    this.width = 38.0,
    this.height = 22.0,
    this.margin,
    this.togglerSize,
    this.borderWidth,
    this.showIcon = false,
    this.elevateToggler = true,
    this.iconSize = 18.0,
    this.activeIcon,
    this.activeIconColor,
    this.activeTrackColor,
    this.activeBorderColor,
    this.activeTogglerColor,
    this.inactiveIcon,
    this.inactiveIconColor,
    this.inactiveTrackColor,
    this.inactiveBorderColor,
    this.inactiveTogglerColor,
    this.showText = false,
    this.activeText,
    this.inactiveText,
    this.activeTextStyle,
    this.inactiveTextStyle,
    this.togglerMargin,
    this.trackMargin,
    this.togglerPadding,
    required this.value,
    required this.onTap,
  })  : assert(width > 0 && height > 0),
        assert(!showIcon || iconSize > 0),
        super(key: key);

  /// Width of the switch button.
  ///
  /// Defaults to `38.0`
  final double width;

  /// Height of the switch button.
  ///
  /// Defaults to `22.0`
  final double height;

  /// Margin around track container.
  ///
  /// Defaults to `horizontal: 10.0` and `vertical: 8.0`
  final EdgeInsetsGeometry? margin;

  /// Size of the `toggler` container, which wraps an `icon` widget also
  /// which can be made visible by setting the property [showIcon] as true.
  ///
  /// Default size for toggler is `20.0` whereas iconSize defaults to `18.0`,
  /// iconSize should be neccessarily less than togglerSize.
  final double? togglerSize;

  /// Width of border around track container.
  ///
  /// Defaults to `0.0`
  final double? borderWidth;

  /// Determines whether to show an `icon` widget, wrapped inside `toggler` container, or not.
  final bool showIcon;

  /// Size of the `icon` widget, wrapped inside `toggler` container.
  ///
  /// It defaults to `18.0` whereas size of `toggler` container defaults to `20.0`,
  /// which is greater and necessary in order to make everything work well.
  final double iconSize;

  /// Determines if toggler is elevated or not
  final bool elevateToggler;

  /// The icon to be shown inside `toggler` when the switch is on.
  ///
  /// This parameter is only necessary when [showIcon] property is set to true.
  final IconData? activeIcon;

  /// The color to use on the icon when the switch is on.
  /// This parameter is only necessary when [showIcon] property is set to true.
  ///
  /// Defaults to `Color(0xFFF8E3A1)`
  final Color? activeIconColor;

  /// The color to use on the active track when the switch is on.
  ///
  /// Defaults to `Colors.blue.shade200`
  final Color? activeTrackColor;

  /// The color to use on the active track when the switch is on.
  ///
  /// Defaults to [activeTrackColor]
  final Color? activeBorderColor;

  /// The color to use on the toggler or icon background, when the switch is on.
  ///
  /// Defaults to `Colors.blue`
  final Color? activeTogglerColor;

  /// The icon to be shown inside `toggler` when the switch is off.
  /// This parameter is only necessary when [showIcon] property is set to true.
  final IconData? inactiveIcon;

  /// The color to use on the icon when the switch is off.
  /// This parameter is only necessary when [showIcon] property is set to true.
  ///
  /// Defaults to `Color(0xFFFFDF5D)`
  final Color? inactiveIconColor;

  /// The color to use on the inactive track when the switch is off.
  ///
  /// Defaults to `Colors.grey`
  final Color? inactiveTrackColor;

  /// The color to use on the inactive track when the switch is off.
  ///
  /// Defaults to [inactiveTrackColor]
  final Color? inactiveBorderColor;

  /// The color to use on the toggler or icon background, when the switch is off.
  ///
  /// Defaults to `Colors.white`
  final Color? inactiveTogglerColor;

  /// Determines whether to show some text inside `track` container,
  /// depending upon the value of switch.
  ///
  /// If switch value is true the value to be shown as text defaults to `On` else `Off`.
  ///
  /// These values can be override by using following properties-
  ///
  /// * [activeText]: Text to be shown when switch value is set to true
  /// * [inactiveText]: Text to be shown when switch value is set to false
  ///
  /// In order to change style for above text values use following properties-
  ///
  /// * [activeTextStyle]: Text Style for activeText
  /// * [inactiveTextStyle]: Text Style for inactiveText
  final bool showText;

  /// The text to display when the switch is on.
  /// This parameter is only necessary when [showText] property is true.
  ///
  /// Defaults to 'On' if no value was given.
  ///
  /// To change text style, use [activeTextStyle]
  final String? activeText;

  /// The text to display when the switch is off.
  /// This parameter is only necessary when [showText] property is true.
  ///
  /// Defaults to 'Off' if no value was given.
  ///
  /// To change text style, use [inactiveTextStyle]
  final String? inactiveText;

  /// The text style to use on the text value when the switch is on.
  /// This parameter is only necessary when [showText] property is true.
  /// Defaults to
  /// ```dart
  /// TextStyle(
  ///   fontSize: 8.0,
  /// );
  /// ```
  final TextStyle? activeTextStyle;

  /// The text style to use on the text value when the switch is off.
  /// This parameter is only necessary when [showText] property is true.
  /// Defaults to
  /// ```dart
  /// TextStyle(
  ///   fontSize: 8.0,
  /// );
  /// ```
  final TextStyle? inactiveTextStyle;

  /// Margin to be used around `toggler` container.
  /// This property can be used to push the toggler inside track.
  ///
  /// Defaults to `0.0`
  final EdgeInsetsGeometry? togglerMargin;

  /// Padding between `toggler` container and `icon` inside it.
  ///
  /// Defaults to `0.0`
  final EdgeInsetsGeometry? togglerPadding;

  /// Margin around `track` container.
  /// This property gives benefit when used with [elevateIcon] property.
  ///
  /// When margin is not null and [elevateIcon] is set true then it will
  /// create a illusion where we will see `toggler` above `track` container
  /// with a little bit of shadow. Margin can be used to decrease the height
  /// of `track` container only and [elevateIcon] = true, will give some
  /// elevation to `toggler`.
  ///
  /// Defaults to `horizontal: 2.0` and `vertical: 4.0`
  final EdgeInsetsGeometry? trackMargin;

  /// Determines if the switch is on or off.
  ///
  /// This property is required.
  final bool value;

  /// Called when the user toggles the switch.
  ///
  /// This property is required.
  ///
  /// [onTap] should update the state of the parent [StatefulWidget]
  /// using the [setState] method, so that the parent gets rebuilt; for example:
  ///
  /// ```dart
  /// SwitchButton(
  ///   value: _switchValue,
  ///   onTap: (val) {
  ///     setState(() {
  ///        _switchValue = val;
  ///     });
  ///   },
  /// ),
  /// ```
  final Function onTap;

  /// Default theme for this switch button is very similar to one, we can
  /// see on GitHub desktop website. For Example
  ///
  /// ```dart
  /// SwitchButton(
  ///   width: 50.0,
  ///   height: 30.0,
  ///   togglerSize: 30.0,
  ///   borderWidth: 2.0,
  ///   showIcon: true,
  ///   elevateToggler: false,
  ///   iconSize: 20.0,
  ///   activeIcon: Icons.nightlight_round,
  ///   activeIconColor: Color(0xFFF8E3A1),
  ///   activeTrackColor: Color(0xFF271052),
  ///   activeBorderColor: Color(0xFF3C1E70),
  ///   activeTogglerColor: Color(0xFF6E40C9),
  ///   inactiveIcon: Icons.wb_sunny_rounded,
  ///   inactiveIconColor: Color(0xFFFFDF5D),
  ///   inactiveTrackColor: Color(0xFFFFFFFF),
  ///   inactiveBorderColor: Color(0xFFD1D5DA),
  ///   inactiveTogglerColor: Color(0xFF2F363D),
  ///   value: switchValue,
  ///   onTap: (val) {
  ///     setState(() {
  ///       switchValue = val;
  ///     });
  ///   },
  /// )
  /// ```
  ///
  /// See Also:
  /// * SwitchButton.packed
  /// * SwitchButton.packedIcon
  /// * SwitchButton.packedAndBordered
  const factory SwitchButton.icon({
    Key key,
    double width,
    double height,
    EdgeInsetsGeometry margin,
    double togglerSize,
    double borderWidth,
    bool elevateToggler,
    double iconSize,
    IconData activeIcon,
    Color activeIconColor,
    Color activeTrackColor,
    Color activeBorderColor,
    Color activeTogglerColor,
    IconData inactiveIcon,
    Color inactiveIconColor,
    Color inactiveTrackColor,
    Color inactiveBorderColor,
    Color inactiveTogglerColor,
    bool showText,
    String activeText,
    String inactiveText,
    TextStyle activeTextStyle,
    TextStyle inactiveTextStyle,
    EdgeInsetsGeometry togglerMargin,
    EdgeInsetsGeometry trackMargin,
    EdgeInsetsGeometry togglerPadding,
    required bool value,
    required Function toggle,
  }) = SwitchButtonWithIcon;

  /// This wraps the toggler inside the `track` container. For Example
  ///
  /// ```dart
  /// SwitchButton(
  ///   width: 40.0,
  ///   height: 20.0,
  ///   togglerSize: 16.0,
  ///   elevateToggler: false,
  ///   iconSize: 12.0,
  ///   activeTrackColor: Colors.blue,
  ///   activeTogglerColor: Colors.white,
  ///   inactiveTrackColor: Colors.grey,
  ///   inactiveBorderColor: Colors.blue,
  ///   inactiveTogglerColor: Colors.white,
  ///   togglerMargin: const EdgeInsets.all(3.0),
  ///   trackMargin: const EdgeInsets.all(0.0),
  ///   value: switchValue,
  ///   onTap: (val) {
  ///     setState(() {
  ///       switchValue = val;
  ///     });
  ///   },
  /// )
  /// ```
  ///
  /// See Also:
  /// * SwitchButton.icon
  /// * SwitchButton.packedIcon
  /// * SwitchButton.packedAndBordered
  const factory SwitchButton.packed({
    Key key,
    double width,
    double height,
    EdgeInsetsGeometry margin,
    double togglerSize,
    double borderWidth,
    bool elevateToggler,
    double iconSize,
    IconData activeIcon,
    Color activeIconColor,
    Color activeTrackColor,
    Color activeBorderColor,
    Color activeTogglerColor,
    IconData inactiveIcon,
    Color inactiveIconColor,
    Color inactiveTrackColor,
    Color inactiveBorderColor,
    Color inactiveTogglerColor,
    bool showText,
    String activeText,
    String inactiveText,
    TextStyle activeTextStyle,
    TextStyle inactiveTextStyle,
    EdgeInsetsGeometry togglerMargin,
    EdgeInsetsGeometry trackMargin,
    EdgeInsetsGeometry togglerPadding,
    required bool value,
    required Function toggle,
  }) = SwitchButtonWithPackedToggler;

  /// This wraps the toggler with an `icon` inside the `track` container. For Example
  ///
  /// ```dart
  /// SwitchButton(
  ///   width: 50.0,
  ///   height: 30.0,
  ///   togglerSize: 25.0,
  ///   borderWidth: 3.0,
  ///   showIcon: true,
  ///   elevateToggler: false,
  ///   iconSize: 18.0,
  ///   activeIcon: Icons.nightlight_round,
  ///   activeIconColor: Color(0xFFF8E3A1),
  ///   activeTrackColor: Color(0xFF271052),
  ///   activeBorderColor: Color(0xFF3C1E70),
  ///   activeTogglerColor: Color(0xFF6E40C9),
  ///   inactiveIcon: Icons.wb_sunny_rounded,
  ///   inactiveIconColor: Color(0xFFFFDF5D),
  ///   inactiveTrackColor: Color(0xFFFFFFFF),
  ///   inactiveBorderColor: Color(0xFFD1D5DA),
  ///   inactiveTogglerColor: Color(0xFF2F363D),
  ///   togglerMargin: const EdgeInsets.all(3.0),
  ///   trackMargin: const EdgeInsets.all(0.0),
  ///   value: switchValue,
  ///   onTap: (val) {
  ///     setState(() {
  ///       switchValue = val;
  ///     });
  ///   },
  /// )
  /// ```
  ///
  /// See Also:
  /// * SwitchButton.icon
  /// * SwitchButton.packed
  /// * SwitchButton.packedAndBordered
  const factory SwitchButton.packedIcon({
    Key key,
    double width,
    double height,
    EdgeInsetsGeometry margin,
    double togglerSize,
    double borderWidth,
    bool showIcon,
    bool elevateToggler,
    double iconSize,
    IconData activeIcon,
    Color activeIconColor,
    Color activeTrackColor,
    Color activeBorderColor,
    Color activeTogglerColor,
    IconData inactiveIcon,
    Color inactiveIconColor,
    Color inactiveTrackColor,
    Color inactiveBorderColor,
    Color inactiveTogglerColor,
    bool showText,
    String activeText,
    String inactiveText,
    TextStyle activeTextStyle,
    TextStyle inactiveTextStyle,
    EdgeInsetsGeometry togglerMargin,
    EdgeInsetsGeometry trackMargin,
    EdgeInsetsGeometry togglerPadding,
    required bool value,
    required Function toggle,
  }) = SwitchButtonWithPackedIconToggler;

  /// This creates a border around the toggler which is inside the `track` container. For Example
  ///
  /// ```dart
  /// SwitchButton(
  ///   width: 50.0,
  ///   height: 30.0,
  ///   togglerSize: 24.0,
  ///   borderWidth: 3.0,
  ///   showIcon: true,
  ///   elevateToggler: false,
  ///   iconSize: 20.0,
  ///   activeIcon: Icons.circle,
  ///   activeIconColor: Colors.white,
  ///   activeBorderColor: Colors.blue,
  ///   activeTogglerColor: Colors.blue,
  ///   inactiveIcon: Icons.circle,
  ///   inactiveIconColor: Colors.white,
  ///   inactiveBorderColor: Colors.teal,
  ///   inactiveTogglerColor: Colors.teal,
  ///   togglerMargin: const EdgeInsets.all(4.0),
  ///   trackMargin: const EdgeInsets.all(0.0),
  ///   value: switchValue,
  ///   onTap: (val) {
  ///     setState(() {
  ///       switchValue = val;
  ///     });
  ///   },
  /// )
  /// ```
  ///
  /// See Also:
  /// * SwitchButton.icon
  /// * SwitchButton.packed
  /// * SwitchButton.packedIcon
  const factory SwitchButton.packedAndBordered({
    Key key,
    double width,
    double height,
    EdgeInsetsGeometry margin,
    double togglerSize,
    double borderWidth,
    bool showIcon,
    bool elevateToggler,
    double iconSize,
    IconData activeIcon,
    Color activeIconColor,
    Color activeTrackColor,
    Color activeBorderColor,
    Color activeTogglerColor,
    IconData inactiveIcon,
    Color inactiveIconColor,
    Color inactiveTrackColor,
    Color inactiveBorderColor,
    Color inactiveTogglerColor,
    bool showText,
    String activeText,
    String inactiveText,
    TextStyle activeTextStyle,
    TextStyle inactiveTextStyle,
    EdgeInsetsGeometry togglerMargin,
    EdgeInsetsGeometry trackMargin,
    EdgeInsetsGeometry togglerPadding,
    required bool value,
    required Function toggle,
  }) = SwitchButtonWithWrappedAndBorderedToggler;

  @override
  _SwitchButtonState createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation _toggleAnimation;

  void handleToggle() {
    if (widget.value) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    widget.onTap(!widget.value);
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 60),
      value: widget.value ? 1.0 : 0.0,
    );
    _toggleAnimation = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SwitchButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value == widget.value) return;
    widget.value
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    bool value = widget.value;
    bool showIcon = widget.showIcon;
    double width = widget.width;
    double height = widget.height;
    IconData? icon = value ? widget.activeIcon! : widget.inactiveIcon!;
    EdgeInsetsGeometry margin =
        widget.margin ?? const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0);
    Color iconColor = value
        ? widget.activeIconColor ?? const Color(0xFFF8E3A1)
        : widget.inactiveIconColor ?? const Color(0xFFFFDF5D);
    Color iconBackground = value
        ? widget.activeTogglerColor ?? Colors.blue
        : widget.inactiveTogglerColor ?? Colors.white;
    Color trackColor = value
        ? widget.activeTrackColor ?? Colors.blue.shade200
        : widget.inactiveTrackColor ?? Colors.grey;
    Color borderColor = value
        ? widget.activeBorderColor ?? trackColor
        : widget.inactiveBorderColor ?? trackColor;
    EdgeInsetsGeometry trackMargin = widget.trackMargin ??
        const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0);
    EdgeInsetsGeometry togglerMargin =
        widget.togglerMargin ?? const EdgeInsets.all(0.0);
    EdgeInsetsGeometry togglerPadding = widget.showIcon
        ? widget.togglerPadding ?? const EdgeInsets.all(0.0)
        : const EdgeInsets.all(0.0);
    double togglerSize = widget.togglerSize ?? 20.0;
    double borderWidth = widget.borderWidth ?? 0.0;
    bool elevateToggler = widget.elevateToggler;
    double iconSize = showIcon ? widget.iconSize : 0.0;
    BoxBorder? border = widget.borderWidth == 0.0
        ? null
        : Border.all(
            width: borderWidth,
            color: borderColor,
          );
    List<BoxShadow>? iconShadow = elevateToggler
        ? [
            BoxShadow(
              blurRadius: 1.0,
              color: Colors.grey.shade400,
              offset: const Offset(-0.1, 2.0),
            ),
          ]
        : null;

    bool showText = widget.showText;
    String text = value
      ? widget.activeText ?? "On"
      : widget.inactiveText ?? "Off";
    TextStyle textStyle = value
      ? widget.activeTextStyle ?? const TextStyle(
        fontSize: 8.0,
      )
      : widget.inactiveTextStyle ?? const TextStyle(
        fontSize: 8.0,
      );

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return InkWell(
          splashColor: Colors.transparent,
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          focusColor: Colors.transparent,
          enableFeedback: false,
          onTap: handleToggle,
          child: Container(
            width: width,
            height: height,
            margin: margin,
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: trackMargin,
                        decoration: BoxDecoration(
                          border: border,
                          borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                          color: trackColor,
                        ),
                        child: showText ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment:  _toggleAnimation.value == Alignment.centerLeft
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0,),
                              child: Text(
                                text,
                                style: textStyle,
                                textAlign: _toggleAnimation.value == Alignment.centerLeft
                                  ? TextAlign.right
                                  : TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ) : null,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Align(
                        alignment: _toggleAnimation.value,
                        child: Container(
                          width: togglerSize,
                          height: togglerSize,
                          padding: togglerPadding,
                          margin: togglerMargin,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: iconBackground,
                            boxShadow: iconShadow,
                          ),
                          child: Visibility(
                            visible: showIcon,
                            child: Center(
                              child: Icon(
                                icon,
                                size: iconSize,
                                color: iconColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

@protected
class SwitchButtonWithIcon extends SwitchButton {
  const SwitchButtonWithIcon({
    Key? key,
    double width = 50.0,
    double height = 30.0,
    EdgeInsetsGeometry? margin,
    double? togglerSize = 30.0,
    double? borderWidth = 2.0,
    bool showIcon = true,
    bool elevateToggler = false,
    double iconSize = 20.0,
    IconData? activeIcon = Icons.nightlight_round,
    Color? activeIconColor = const Color(0xFFF8E3A1),
    Color? activeTrackColor = const Color(0xFF271052),
    Color? activeBorderColor = const Color(0xFF3C1E70),
    Color? activeTogglerColor = const Color(0xFF6E40C9),
    IconData? inactiveIcon = Icons.wb_sunny_rounded,
    Color? inactiveIconColor = const Color(0xFFFFDF5D),
    Color? inactiveTrackColor = const Color(0xFFFFFFFF),
    Color? inactiveBorderColor = const Color(0xFFD1D5DA),
    Color? inactiveTogglerColor = const Color(0xFF2F363D),
    bool showText = false,
    String? activeText,
    String? inactiveText,
    TextStyle? activeTextStyle,
    TextStyle? inactiveTextStyle,
    EdgeInsetsGeometry? togglerMargin,
    EdgeInsetsGeometry? trackMargin,
    EdgeInsetsGeometry? togglerPadding,
    required bool value,
    required Function toggle,
  }) : super(
          key: key,
          width: width,
          height: height,
          margin: margin,
          showIcon: showIcon,
          elevateToggler: elevateToggler,
          iconSize: iconSize,
          activeIcon: activeIcon,
          activeIconColor: activeIconColor,
          activeTrackColor: activeTrackColor,
          activeBorderColor: activeBorderColor,
          activeTogglerColor: activeTogglerColor,
          inactiveIcon: inactiveIcon,
          inactiveIconColor: inactiveIconColor,
          inactiveTrackColor: inactiveTrackColor,
          inactiveBorderColor: inactiveBorderColor,
          inactiveTogglerColor: inactiveTogglerColor,
          togglerSize: togglerSize,
          borderWidth: borderWidth,
          togglerMargin: togglerMargin,
          togglerPadding: togglerPadding,
          trackMargin: trackMargin,
          showText: showText,
          activeText: activeText,
          inactiveText: inactiveText,
          activeTextStyle: activeTextStyle,
          inactiveTextStyle: inactiveTextStyle,
          value: value,
          onTap: toggle,
        );
}

@protected
class SwitchButtonWithPackedToggler extends SwitchButton {
  const SwitchButtonWithPackedToggler({
    Key? key,
    double width = 40.0,
    double height = 20.0,
    EdgeInsetsGeometry? margin,
    double? togglerSize = 16.0,
    double? borderWidth = 0.0,
    bool showIcon = false,
    bool elevateToggler = false,
    double iconSize = 12.0,
    IconData? activeIcon = Icons.nightlight_round,
    Color? activeIconColor,
    Color? activeTrackColor = Colors.blue,
    Color? activeBorderColor,
    Color? activeTogglerColor = Colors.white,
    IconData? inactiveIcon = Icons.wb_sunny_rounded,
    Color? inactiveIconColor,
    Color? inactiveTrackColor = Colors.grey,
    Color? inactiveBorderColor = Colors.blue,
    Color? inactiveTogglerColor = Colors.white,
    bool showText = false,
    String? activeText,
    String? inactiveText,
    TextStyle? activeTextStyle,
    TextStyle? inactiveTextStyle,
    EdgeInsetsGeometry? togglerMargin = const EdgeInsets.all(3.0),
    EdgeInsetsGeometry? trackMargin = const EdgeInsets.all(0.0),
    EdgeInsetsGeometry? togglerPadding,
    required bool value,
    required Function toggle,
  }) : super(
          key: key,
          width: width,
          height: height,
          margin: margin,
          showIcon: showIcon,
          elevateToggler: elevateToggler,
          iconSize: iconSize,
          activeIcon: activeIcon,
          activeIconColor: activeIconColor,
          activeTrackColor: activeTrackColor,
          activeBorderColor: activeBorderColor,
          activeTogglerColor: activeTogglerColor,
          inactiveIcon: inactiveIcon,
          inactiveIconColor: inactiveIconColor,
          inactiveTrackColor: inactiveTrackColor,
          inactiveBorderColor: inactiveBorderColor,
          inactiveTogglerColor: inactiveTogglerColor,
          togglerSize: togglerSize,
          borderWidth: borderWidth,
          togglerMargin: togglerMargin,
          togglerPadding: togglerPadding,
          trackMargin: trackMargin,
          showText: showText,
          activeText: activeText,
          inactiveText: inactiveText,
          activeTextStyle: activeTextStyle,
          inactiveTextStyle: inactiveTextStyle,
          value: value,
          onTap: toggle,
        );
}

@protected
class SwitchButtonWithPackedIconToggler extends SwitchButton {
  const SwitchButtonWithPackedIconToggler({
    Key? key,
    double width = 50.0,
    double height = 30.0,
    EdgeInsetsGeometry? margin,
    double? togglerSize = 25.0,
    double? borderWidth = 3.0,
    bool showIcon = true,
    bool elevateToggler = false,
    double iconSize = 18.0,
    IconData? activeIcon = Icons.nightlight_round,
    Color? activeIconColor = const Color(0xFFF8E3A1),
    Color? activeTrackColor = const Color(0xFF271052),
    Color? activeBorderColor = const Color(0xFF3C1E70),
    Color? activeTogglerColor = const Color(0xFF6E40C9),
    IconData? inactiveIcon = Icons.wb_sunny_rounded,
    Color? inactiveIconColor = const Color(0xFFFFDF5D),
    Color? inactiveTrackColor = const Color(0xFFFFFFFF),
    Color? inactiveBorderColor = const Color(0xFFD1D5DA),
    Color? inactiveTogglerColor = const Color(0xFF2F363D),
    EdgeInsetsGeometry? togglerMargin = const EdgeInsets.all(3.0),
    EdgeInsetsGeometry? trackMargin = const EdgeInsets.all(0.0),
    EdgeInsetsGeometry? togglerPadding,
    bool showText = false,
    String? activeText,
    String? inactiveText,
    TextStyle? activeTextStyle,
    TextStyle? inactiveTextStyle,
    required bool value,
    required Function toggle,
  }) : super(
          key: key,
          width: width,
          height: height,
          margin: margin,
          showIcon: showIcon,
          elevateToggler: elevateToggler,
          iconSize: iconSize,
          activeIcon: activeIcon,
          activeIconColor: activeIconColor,
          activeTrackColor: activeTrackColor,
          activeBorderColor: activeBorderColor,
          activeTogglerColor: activeTogglerColor,
          inactiveIcon: inactiveIcon,
          inactiveIconColor: inactiveIconColor,
          inactiveTrackColor: inactiveTrackColor,
          inactiveBorderColor: inactiveBorderColor,
          inactiveTogglerColor: inactiveTogglerColor,
          togglerSize: togglerSize,
          borderWidth: borderWidth,
          togglerMargin: togglerMargin,
          togglerPadding: togglerPadding,
          trackMargin: trackMargin,
          showText: showText,
          activeText: activeText,
          inactiveText: inactiveText,
          activeTextStyle: activeTextStyle,
          inactiveTextStyle: inactiveTextStyle,
          value: value,
          onTap: toggle,
        );
}

@protected
class SwitchButtonWithWrappedAndBorderedToggler extends SwitchButton {
  const SwitchButtonWithWrappedAndBorderedToggler({
    Key? key,
    double width = 50.0,
    double height = 30.0,
    EdgeInsetsGeometry? margin,
    double? togglerSize = 24.0,
    double? borderWidth = 3.0,
    bool showIcon = true,
    bool elevateToggler = false,
    double iconSize = 20.0,
    IconData? activeIcon = Icons.circle,
    Color? activeIconColor = Colors.white,
    Color? activeTrackColor,
    Color? activeBorderColor = Colors.blue,
    Color? activeTogglerColor = Colors.blue,
    IconData? inactiveIcon = Icons.circle,
    Color? inactiveIconColor = Colors.white,
    Color? inactiveTrackColor,
    Color? inactiveBorderColor = Colors.teal,
    Color? inactiveTogglerColor = Colors.teal,
    EdgeInsetsGeometry? togglerMargin = const EdgeInsets.all(4.0),
    EdgeInsetsGeometry? trackMargin = const EdgeInsets.all(0.0),
    EdgeInsetsGeometry? togglerPadding,
    bool showText = false,
    String? activeText,
    String? inactiveText,
    TextStyle? activeTextStyle,
    TextStyle? inactiveTextStyle,
    required bool value,
    required Function toggle,
  }) : super(
          key: key,
          width: width,
          height: height,
          margin: margin,
          showIcon: showIcon,
          elevateToggler: elevateToggler,
          iconSize: iconSize,
          activeIcon: activeIcon,
          activeIconColor: activeIconColor,
          activeTrackColor: activeTrackColor,
          activeBorderColor: activeBorderColor,
          activeTogglerColor: activeTogglerColor,
          inactiveIcon: inactiveIcon,
          inactiveIconColor: inactiveIconColor,
          inactiveTrackColor: inactiveTrackColor,
          inactiveBorderColor: inactiveBorderColor,
          inactiveTogglerColor: inactiveTogglerColor,
          togglerSize: togglerSize,
          borderWidth: borderWidth,
          togglerMargin: togglerMargin,
          togglerPadding: togglerPadding,
          trackMargin: trackMargin,
          showText: showText,
          activeText: activeText,
          inactiveText: inactiveText,
          activeTextStyle: activeTextStyle,
          inactiveTextStyle: inactiveTextStyle,
          value: value,
          onTap: toggle,
        );
}
