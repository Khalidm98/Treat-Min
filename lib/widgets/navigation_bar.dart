import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class NavigationBar extends StatefulWidget {
  final ValueChanged<int> onTap;
  final int index;
  final List<Widget> items;
  final List<Widget> activeItems;

  NavigationBar({
    Key key,
    @required this.onTap,
    @required this.index,
    @required this.items,
    this.activeItems,
  })  : assert(items.length >= 2 && items.length <= 5),
        assert(activeItems == null ? true : items.length == activeItems.length),
        super(key: key);

  @override
  State createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  double width;
  Color indicatorColor;
  int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (width == null) {
      width = MediaQuery.of(context).size.width;
      indicatorColor = Theme.of(context).accentColor;
    }
  }

  _select(int index) {
    widget.onTap(index);
    setState(() => currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 2,
            child: Row(
              children: widget.items.map((item) {
                final int index = widget.items.indexOf(item);
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _select(index),
                  child: Container(
                    height: 30,
                    width: width / widget.items.length,
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.center,
                    child: widget.activeItems == null
                        ? item
                        : AnimatedCrossFade(
                            duration: const Duration(milliseconds: 300),
                            crossFadeState: index == currentIndex
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                            firstChild: widget.activeItems[index],
                            secondChild: item,
                          ),
                  ),
                );
              }).toList(),
            ),
          ),
          Positioned(
            top: 0,
            width: width,
            child: AnimatedAlign(
              // icons count = 4
              // x: -1 ... 1
              // icon width = total width / 4
              // icon width in x: 0.5
              // indicator width = icon with / 3
              // indicator width in x: 0.17
              // x alignment = -1 + 0.17 + index * 2 * (1 - 0.17) / (count - 1)
              alignment: Alignment(-0.825 + currentIndex * 0.55, 0),
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear,
              child: Container(
                color: indicatorColor,
                width: width / widget.items.length / 3,
                height: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
