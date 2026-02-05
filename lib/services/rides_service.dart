import '../dummy_data/dummy_data.dart';
import '../model/ride/locations.dart';
import '../model/ride/ride.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {
  static List<Ride> availableRides = fakeRides; // TODO for now fake data

  static List<Ride> filterByDeparture(List<Ride> rides, Location departure) {
    return rides.where((ride) => ride.departureLocation == departure).toList();
  }

  static List<Ride> filterBySeatRequested(
    List<Ride> rides,
    Location departure,
  ) {
    return rides.where((ride) => ride.departureLocation == departure).toList();
  }

  static List<Ride> filterBy({Location? departure, int? seatRequested}) {
    return [];
  }
}
