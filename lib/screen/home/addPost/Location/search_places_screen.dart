import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';


class SearchPlacesScreen extends StatefulWidget {
  const SearchPlacesScreen({Key? key}) : super(key: key);

  @override
  State<SearchPlacesScreen> createState() => _SearchPlacesScreenState();
}

const kGoogleApiKey = 'AIzaSyCckhVmNilRBCInrm087ZQr0WxR1u3AbhU';

class _SearchPlacesScreenState extends State<SearchPlacesScreen> {

  final Mode _mode = Mode.overlay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Choose place that you visit"),
      ),
      body: ElevatedButton(onPressed: _handlePressButton, child: const Text("Choose place")),
    );
  }

  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        mode: _mode,
        language: 'en',
        strictbounds: false,
        types: [""],
        components: [Component(Component.country,"SA"),Component(Component.country,"usa")]
    );
  }
}