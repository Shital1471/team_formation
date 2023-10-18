import 'package:flutter/material.dart';

class FilterChips extends StatefulWidget {
  final Map<String, List<String>> filters;
  final ValueChanged onChanged;

  FilterChips({
    required this.filters,
    required this.onChanged,
  });

  @override
  _FilterChipsState createState() => _FilterChipsState();
}
class _FilterChipsState extends State<FilterChips> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FilterChip(
            label: Text("Available"),
            selected: widget.filters['available']!.contains('true'),
            onSelected: (selected) {
              setState(() {
                if (selected) {
                  widget.filters['available']!.add('true');
                } else {
                  widget.filters['available']!.remove('true');
                }
                widget.onChanged;
              });
            },
          ),
          SizedBox(width: 10),
          FilterChip(
            label: Text("Not Available"),
            selected: widget.filters['available']!.contains('false'),
            onSelected: (selected) {
              setState(() {
                if (selected) {
                  widget.filters['available']!.add('false');
                } else {
                  widget.filters['available']!.remove('false');
                }
                widget.onChanged;
              });
            },
          ),
           SizedBox(width: 10),
          FilterChip(
            label: Text("Male"),
            selected: widget.filters['gender']!.contains('male'),
            onSelected: (selected) {
              setState(() {
                if (selected) {
                  widget.filters['gender']!.add('male');
                } else {
                  widget.filters['gender']!.remove('male');
                }
                widget.onChanged;
              });
            },
          ),
           SizedBox(width: 10),
          FilterChip(
            label: Text("Female"),
            selected: widget.filters['gender']!.contains('female'),
            onSelected: (selected) {
              setState(() {
                if (selected) {
                  widget.filters['gender']!.add('female');
                } else {
                  widget.filters['gender']!.remove('female');
                }
                widget.onChanged;
              });
            },
          ),
           SizedBox(width: 10),
          FilterChip(
            label: Text("Marketing"),
            selected: widget.filters['domain']!.contains('marketing'),
            onSelected: (selected) {
              setState(() {
                if (selected) {
                  widget.filters['domain']!.add('marketing');
                } else {
                  widget.filters['domain']!.remove('marketing');
                }
                widget.onChanged;
              });
            },
          ),
           SizedBox(width: 10),
          FilterChip(
            label: Text("Sales"),
            selected: widget.filters['domain']!.contains('sales'),
            onSelected: (selected) {
              setState(() {
                if (selected) {
                  widget.filters['domain']!.add('sales');
                } else {
                  widget.filters['domain']!.remove('sales');
                }
                widget.onChanged;
              });
            },
          ),
           SizedBox(width: 10),
          FilterChip(
            label: Text("Finance"),
            selected: widget.filters['domain']!.contains('finance'),
            onSelected: (selected) {
              setState(() {
                if (selected) {
                  widget.filters['domain']!.add('finance');
                } else {
                  widget.filters['domain']!.remove('finance');
                }
                widget.onChanged;
              });
            },
          ),
        ],
      ),
    );
  }
}

