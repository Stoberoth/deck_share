import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  // Stream pour écouter les changement de connectivité en temps réel
  Stream<bool> get isConnectedStream {
    return _connectivity.onConnectivityChanged.map((results) {
      return results.any((result) => result != ConnectivityResult.none) ;
    });
  }

  // Vérification ponctuelle de la connectivité
  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    return results.any((result) => result != ConnectivityResult.none);
  }

  // Vérification avancée avec ping Firebase car wifi ne veux pas dire internet
  Future<bool> hasInternetAccess() async {
    try {
      final results = await _connectivity.checkConnectivity();
      if (results.every((result) => result == ConnectivityResult.none) ) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
