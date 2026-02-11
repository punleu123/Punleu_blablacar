import 'package:flutter/material.dart';

import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';
import '../../../../utils/date_time_utils.dart';
import '../../../theme/theme.dart';
import '../../../widgets/actions/bla_button.dart';
import '../../../widgets/display/bla_divider.dart';
import '../../../widgets/inputs/bla_location_picker.dart';
import 'ride_prefs_input_tile.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;
  final Function(RidePref)? onSubmit;

  const RidePrefForm({super.key, this.initRidePref, this.onSubmit});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    final initRidePref = widget.initRidePref;
    if (initRidePref != null) {
      departure = initRidePref.departure;
      departureDate = initRidePref.departureDate;
      arrival = initRidePref.arrival;
      requestedSeats = initRidePref.requestedSeats;
    } else {
      departure = null;
      arrival = null;
      departureDate = DateTime.now();
      requestedSeats = 1;
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  void onDeparturePressed() async {
    final selectedLocation = await Navigator.of(context).push<Location>(
      MaterialPageRoute(builder: (ctx) => const BlaLocationPicker()),
    );

    if (selectedLocation != null) {
      setState(() => departure = selectedLocation);
    }
  }

  void onArrivalPressed() async {
    final selectedLocation = await Navigator.of(context).push<Location>(
      MaterialPageRoute(builder: (ctx) => const BlaLocationPicker()),
    );

    if (selectedLocation != null) {
      setState(() => arrival = selectedLocation);
    }
  }

  void onSwappingLocationPressed() {
    if (departure != null && arrival != null) {
      setState(() {
        final temp = departure!;
        departure = Location.copy(arrival!);
        arrival = Location.copy(temp);
      });
    }
  }

  void onSubmit() {
    //TODO
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  String get departureLabel => departure?.name ?? "Leaving from";
  String get arrivalLabel => arrival?.name ?? "Going to";
  String get dateLabel => DateTimeUtils.formatDateTime(departureDate);
  String get numberLabel => requestedSeats.toString();

  bool get showDeparturePlaceholder => departure == null;
  bool get showArrivalPlaceholder => arrival == null;
  bool get switchVisible => departure != null && arrival != null;

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.m),
          child: Column(
            children: [
              RidePrefsInputTile(
                title: departureLabel,
                leftIcon: Icons.radio_button_checked,
                isPlaceholder: showDeparturePlaceholder,
                onPressed: onDeparturePressed,
                rightIcon: Icons.swap_vert,
                onRightIconPressed: onSwappingLocationPressed,
              ),
              BlaDivider(),
              RidePrefsInputTile(
                isPlaceholder: showArrivalPlaceholder,
                title: arrivalLabel,
                leftIcon: Icons.radio_button_checked,
                onPressed: onArrivalPressed,
              ),
              BlaDivider(),
              RidePrefsInputTile(
                title: dateLabel,
                leftIcon: Icons.calendar_today_outlined,
                isPlaceholder: false,
                onPressed: () {},
              ),
              BlaDivider(),
              RidePrefsInputTile(
                title: numberLabel,
                leftIcon: Icons.person_2_sharp,
              ),
            ],
          ),
        ),
        SizedBox(height: BlaSpacings.m),
        BlaButton(text: 'Submit', onPressed: onSubmit),
      ],
    );
  }
}
