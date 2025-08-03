import 'package:admin_qurban_mart/components/text/text_component.dart';
import 'package:admin_qurban_mart/controllers/maps_controller.dart';
import 'package:admin_qurban_mart/values/navigate_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class MapsScreen extends StatelessWidget {
  const MapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mapsController = Get.put(MapsController());
    final latLng =
        mapsController.latLng.value ?? LatLng(-4.5094675, 121.5148604);

    return Obx(
      () => Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: latLng,
              maxZoom: 18.0,
              onTap: (tapPosition, point) {
                mapsController.setLatlng(point);
                navigatePop(context);
              },
              bounds: LatLngBounds.fromPoints([
                latLng,
              ]),
            ),
            nonRotatedChildren: [
              TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
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
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  final latitude = latLng.latitude;
                  final longitude = latLng.longitude;
                  final googleMapsUrl =
                      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
                  if (!await launchUrl(Uri.parse(googleMapsUrl))) {
                    throw Exception('Could not launch $googleMapsUrl');
                  }
                  // if (await launchUrl(Uri.parse(googleMapsUrl))) {
                  //   await launchUrl(
                  //     Uri.parse(googleMapsUrl),
                  //     webOnlyWindowName:
                  //         '_blank', // Ini agar buka di tab baru pada Web
                  //   );
                  // } else {
                  //   Get.snackbar("Gagal", "Tidak bisa membuka Google Maps");
                  // }
                },
                icon: const Icon(
                  Icons.map,
                  color: Colors.white,
                ),
                label: const TextComponent(
                  "Buka google maps",
                  color: Colors.white,
                  size: 12,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
