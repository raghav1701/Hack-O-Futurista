import 'package:flutter/material.dart';
import 'package:portfolio/application.dart';

class _TnCBody extends StatelessWidget {
  final double fontSize;
  final TextStyle? textStyle;
  final TextStyle? headerStyle;

  const _TnCBody({
    this.textStyle,
    this.headerStyle,
    this.fontSize = 14.0,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTextItem('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Erat nam at lectus urna duis convallis convallis tellus. Et ultrices neque ornare aenean euismod elementum nisi quis eleifend. Malesuada fames ac turpis egestas. Viverra ipsum nunc aliquet bibendum enim facilisis gravida.'),
          buildHeaderText('Our Privacy Policy'),
          buildTextItem('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Erat nam at lectus urna duis convallis convallis tellus. Et ultrices neque ornare aenean euismod elementum nisi quis eleifend. Malesuada fames ac turpis egestas. Viverra ipsum nunc aliquet bibendum enim facilisis gravida.'),
          buildTextItem('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Erat nam at lectus urna duis convallis convallis tellus. Et ultrices neque ornare aenean euismod elementum nisi quis eleifend. Malesuada fames ac turpis egestas. Viverra ipsum nunc aliquet bibendum enim facilisis gravida.'),
        ],
      ),
    );
  }

  Widget buildTextItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8.0,
      ),
      child: Text(
        text,
        style: textStyle ?? TextStyle(
          fontSize: fontSize,
        ),
      ),
    );
  }

  Widget buildHeaderText(String text) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8.0,
      ),
      child: Text(
        text,
        style: headerStyle ?? TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class TnCScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Terms and Conditions',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: currentAppTheme.isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 16.0,
        ),
        child: _TnCBody(),
      ),
    );
  }
}

class TnCDialog extends AlertDialog {
  TnCDialog({
    Key? key,
    required Function() onDecline,
    required Function() onAccept,
  }) : super(
          key: key,
          title: const Text('Terms and Conditions'),
          actions: [
            _TnCDialogActions(
              onDecline: onDecline,
              onAccept: onAccept,
              textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Please read our terms and conditions carefully, and agree to continue.',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 8.0,
              ),
              Expanded(child: _TnCBody()),
            ],
          ),
        );
}

class _TnCDialogActions extends StatefulWidget {
  final void Function() onDecline;
  final void Function() onAccept;
  final TextStyle textStyle;

  const _TnCDialogActions({
    required this.onDecline,
    required this.onAccept,
    required this.textStyle,
  });

  @override
  _TnCDialogActionsState createState() => _TnCDialogActionsState();
}

class _TnCDialogActionsState extends State<_TnCDialogActions> {
  bool accepted = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Checkbox(
              value: accepted,
              onChanged: (val) {
                if (mounted) {
                  setState(() => accepted = val ?? false);
                }
              },
            ),
            const Expanded(
              child: Text('I have read and agree to the terms and conditions'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              child: Text(
                'Decline',
                style: widget.textStyle
              ),
              onPressed: widget.onDecline,
            ),
            TextButton(
              child: Text(
                'Accept',
                style: widget.textStyle,
              ),
              onPressed: accepted ? widget.onAccept : null,
            ),
          ],
        ),
      ],
    );
  }
}
