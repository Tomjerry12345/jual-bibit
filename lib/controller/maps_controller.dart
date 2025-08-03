import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapsController extends GetxController {
  final latLng = Rx<LatLng?>(null);

  reset() {
    latLng.value = null;
  }

  setLatlng(LatLng p) {
    latLng.value = p;
  }
}
