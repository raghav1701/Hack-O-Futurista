import 'dart:math';

import 'package:bugbusters/application.dart';
import 'package:flutter/material.dart';

class _ItemType {
  static const int border = 0;
  static const int vacant = 1;
  static const int occupied = 2;
  static const int elevator = 3;
  static const int stairs = 4;
  static const int empty = 5;
  static const int entry = 6;
  static const int exit = 7;
  static const int selected = 8;
}

class BookSlot extends StatefulWidget {
  final List<dynamic> map;
  final String tid;
  final String pid;
  final bool viewOnly;
  final List<int> slot;

  const BookSlot({
    Key? key,
    this.map = const [
      "0110330110",
      "4555555553",
      "4551151553",
      "3551152551",
      "3551152551",
      "5551152551",
      "1551152551",
      "1551152551",
      "1551152551",
      "1551152551",
      "1551151551",
      "5551151551",
      "0660000770",
    ],
    required this.tid,
    required this.pid,
    required this.slot,
    this.viewOnly = false,
  }) : super(key: key);

  @override
  State<BookSlot> createState() => _BookSlotState();
}

class _BookSlotState extends State<BookSlot> {
  late final ProgressDialog progressDialog;
  String slotNumber = 'None';
  int selectedIndex = -1;

  void handleForward() {
    if (selectedIndex == -1) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('Select a Slot First')));
      return;
    }
    int row = selectedIndex ~/ pMap[0].length;
    int col = selectedIndex % pMap[0].length;

    showConfirmDialog(
      context: context,
      title: 'Book Slot',
      content: 'Selected Slot is $slotNumber',
      onAccept: () async {
        Navigator.of(context).pop();
        await progressDialog.show();
        await FirebaseFunctionService()
            .bookSlot(tid: widget.tid, parkId: widget.pid, slot: [row, col]);
        await progressDialog.hide();
        Navigator.of(context).pop();
      },
    );
  }

  void handleAutoSelect() {
    //TODO:
  }

  late List<String> pMap = [];

  @override
  void initState() {
    super.initState();
    slotNumber = widget.viewOnly
        ? (widget.slot[1] != -1
            ? '${alphabets[widget.slot[1]]}${widget.slot[0]}'
            : 'NA')
        : 'None';
    pMap = widget.map.cast<String>();
    selectedIndex = widget.viewOnly ? widget.slot[0] * pMap[0].length + widget.slot[1] : -1;
    progressDialog = ProgressDialog(
      context,
      isDismissible: false,
      type: ProgressDialogType.normal,
      customBody: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 24.0,
        ),
        child: Row(
          children: const [
            CircularProgressIndicator(),
            SizedBox(width: 16.0),
            Text('Booking Slot...'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Slot'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Slot Selected: $slotNumber',
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          Expanded(
            child: Card(
              margin: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0,
                    color: Colors.grey,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                ),
                padding: const EdgeInsets.all(8.0),
                child: InteractiveViewer(
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: pMap[0].length,
                    ),
                    itemCount: pMap[0].length * pMap.length,
                    itemBuilder: (context, index) {
                      var row = index ~/ pMap[0].length;
                      var col = index % pMap[0].length;
                      var val = int.parse(pMap[row][col]);
                      if (selectedIndex == index) {
                        return GridTile(
                          key: Key('$index'),
                          child: buildImageContainer(
                              context, _ItemType.selected, row, col),
                        );
                      } else if (val >= 1 && val <= 2) {
                        return GridTile(
                          key: Key('$index'),
                          child: buildImageContainer(context, val, row, col),
                        );
                      } else {
                        return GridTile(
                          key: Key('$index'),
                          child: buildItemContainer(context, val),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: buildLegendImage(
                          context, Assets.carGreen, 'Available')),
                  Expanded(
                      child:
                          buildLegendImage(context, Assets.carRed, 'Occupied')),
                  Expanded(
                      child: buildLegendImage(
                          context, Assets.carYellow, 'Selected')),
                ],
              ),
            ),
          ),
          Visibility(
            visible: !widget.viewOnly,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text('Auto Select'),
                    onPressed: handleAutoSelect,
                  ),
                ),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Row(
                      children: const [
                        Text('Submit'),
                        Icon(Icons.arrow_forward),
                      ],
                    ),
                    onPressed: handleForward,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLegendImage(BuildContext context, String img, String text) {
    return Row(
      children: [
        Flexible(
          child: Transform.rotate(
            angle: -pi / 2,
            child: Image.asset(img),
          ),
        ),
        Text(text),
        const SizedBox(width: 6.0),
      ],
    );
  }

  Widget buildImageContainer(
      BuildContext context, int value, int row, int col) {
    String img = value == _ItemType.vacant
        ? Assets.carGreen
        : value == _ItemType.occupied
            ? Assets.carRed
            : Assets.carYellow;

    int nxtCol = 0;
    try {
      nxtCol = int.parse(pMap[row][col - 1]);
    } catch (_) {}

    double transformation = row == 0
        ? -pi / 2
        : col == 0 || ((col > 0) && (nxtCol == 1 || nxtCol == 2))
            ? -pi
            : 0.0;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: InkWell(
        onTap: widget.viewOnly ? null : () {
          if (value == 1) {
            setState(() {
              selectedIndex = row * pMap[0].length + col;
              slotNumber = '${alphabets[col]}$row';
            });
          }
        },
        child: Center(
          child: Transform.rotate(
            angle: transformation,
            child: Image.asset(img),
          ),
        ),
      ),
    );
  }

  Widget buildItemContainer(BuildContext context, int value) {
    String text = value == _ItemType.elevator
        ? 'Elevator'
        : value == _ItemType.stairs
            ? 'Stairs'
            : value == _ItemType.entry
                ? 'Entry'
                : value == _ItemType.exit
                    ? 'Exit'
                    : '';

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: Center(
          child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.visible,
        style: const TextStyle(
          fontSize: 8.0,
        ),
      )),
    );
  }
}
