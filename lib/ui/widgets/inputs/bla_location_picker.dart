import 'package:blabla/services/location_service.dart';
import 'package:blabla/ui/theme/theme.dart';
import 'package:flutter/material.dart';

import '../../../model/ride/locations.dart';

class BlaLocationPicker extends StatefulWidget {
  final Location? initialLocation;
  const BlaLocationPicker({super.key, this.initialLocation});

  @override
  _BlaLocationPickerState createState() => _BlaLocationPickerState();
}

class _BlaLocationPickerState extends State<BlaLocationPicker> {
  List<Location> filterLocations = [];
  @override
  void initState() {
    super.initState();
    filterLocations = LocationsService.availableLocations;
  }

  void onBack() {
    Navigator.of(context).pop();
  }

  void onLocationSelected(Location location) {
    Navigator.of(context).pop(location);
  }

  void onChanged(String query) {
    setState(() {
      filterLocations = query.length > 1
          ? LocationsService.availableLocations
                .where(
                  (location) =>
                      location.name.toUpperCase().contains(query.toUpperCase()),
                )
                .toList()
          : LocationsService.availableLocations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsetsGeometry.only(
          left: BlaSpacings.m,
          right: BlaSpacings.m,
          top: BlaSpacings.s,
        ),
        child: Column(
          children: [
            BlaSearchBar(onSearch: onChanged, onCancel: onBack),
            Expanded(
              child: ListView.builder(
                itemCount: filterLocations.length,
                itemBuilder: (context, index) => Locationtile(
                  location: filterLocations[index],
                  onSelected: (Location location) {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Locationtile extends StatelessWidget {
  final Location location;
  final Function(Location location) onSelected;
  const Locationtile({
    super.key,
    required this.location,
    required this.onSelected,
  });

  String get title => location.name;
  String get subTitle => location.country.name;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onSelected(location),
      title: Text(
        title,
        style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal),
      ),
      subtitle: Text(
        subTitle,
        style: BlaTextStyles.body.copyWith(color: BlaColors.textLight),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: BlaColors.primary,
        size: 16,
      ),
    );
  }
}

class BlaSearchBar extends StatefulWidget {
  final Function(String text) onSearch;
  final VoidCallback? onCancel;
  const BlaSearchBar({super.key, required this.onSearch, this.onCancel});

  @override
  State<BlaSearchBar> createState() => _BlaSearchBarState();
}

class _BlaSearchBarState extends State<BlaSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool get SearchNotEmpty => _controller.text.isNotEmpty;

  void onSearchChange(String newText) {
    widget.onSearch(newText);
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BlaColors.backgroundAccent,
        borderRadius: BorderRadius.circular(BlaSpacings.radius),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsetsGeometry.symmetric(
              horizontal: BlaSpacings.s,
            ),
            child: IconButton(
              onPressed: widget.onCancel,
              icon: Icon(
                Icons.arrow_back_ios,
                color: BlaColors.iconNormal,
                size: 16,
              ),
            ),
          ),
          Expanded(
            child: TextField(
              focusNode: _focusNode,
              onChanged: onSearchChange,
              controller: _controller,
              style: TextStyle(color: BlaColors.textLight),
              decoration: InputDecoration(
                hintText: "Any city, ...",
                border: InputBorder.none,
                filled: false,
              ),
            ),
          ),
          SearchNotEmpty
              ? IconButton(
                  icon: Icon(Icons.close),
                  color: BlaColors.iconNormal,
                  onPressed: () {
                    _controller.clear();
                    _focusNode.requestFocus();
                    onSearchChange("");
                  },
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
