import 'package:flutter/material.dart';

class MultiSelectDropdown extends StatefulWidget {
  final List<String> items;
  final List<String> selectedItems;
  final ValueChanged<List<String>> onSelectionChanged;

  MultiSelectDropdown({
    required this.items,
    required this.selectedItems,
    required this.onSelectionChanged,
  });

  @override
  _MultiSelectDropdownState createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  late List<String> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = widget.selectedItems;
  }

  void _showMenu(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy + renderBox.size.height,
        position.dx + renderBox.size.width,
        position.dy,
      ),
      items: widget.items.map((String item) {
        return PopupMenuItem<String>(
          value: item,
          child: ListTile(
            title: Text(item),
            leading: _selectedItems.contains(item)
                ? Icon(Icons.check_box)
                : Icon(Icons.check_box_outline_blank),
            onTap: () {
              setState(() {
                if (_selectedItems.contains(item)) {
                  _selectedItems.remove(item);
                } else {
                  _selectedItems.add(item);
                }
                widget.onSelectionChanged(_selectedItems);
                Navigator.of(context).pop(); // Close the current menu to rebuild it
                _showMenu(context);  // Show the menu again with the updated state
              });
            },
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showMenu(context),
      child: Row(
        children: [
          Expanded(child: Text(_selectedItems.join(', '))),
          Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }
}









