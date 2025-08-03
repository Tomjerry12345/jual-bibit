import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:qurban_mart/controller/maps_controller.dart';
import 'package:qurban_mart/values/navigate_utils.dart';

class MapsScreen extends StatelessWidget {
  const MapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mapsController = Get.put(MapsController());
    final latLng =
        mapsController.latLng.value ?? LatLng(-4.5094675, 121.5148604);

    return Obx(
      () => FlutterMap(
        options: MapOptions(
          center: latLng, // Menetapkan pusat awal peta
          maxZoom: 18.0, // Zoom maksimal
          onTap: (tapPosition, point) {
            mapsController.setLatlng(point);
            navigatePop(context);
            // page.changePage(tambahProductScreenRoute);
          },
          bounds: LatLngBounds.fromPoints([
            latLng,
          ]),
        ),
        nonRotatedChildren: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          if (mapsController.latLng.value != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: latLng,
                  builder: (ctx) => const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
