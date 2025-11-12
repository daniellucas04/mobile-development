import 'package:geolocator/geolocator.dart';

class Localizacao {
  String? latitude;
  String? longitude;

  pegaLocalizacaoAtual() async {
    LocationPermission permissao = await Geolocator.checkPermission();

    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permissao == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );

    this.latitude = position.latitude.toString();
    this.longitude = position.longitude.toString();
  }
}
