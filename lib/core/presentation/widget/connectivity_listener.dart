import 'package:deck_share/core/application/providers/connectivity_provider.dart';
import 'package:deck_share/core/application/providers/sync_service_provider.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConnectivityListener extends ConsumerStatefulWidget {
  final Widget child;

  const ConnectivityListener({super.key, required this.child});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return ConnectivityListenerState();
  }
}

class ConnectivityListenerState extends ConsumerState<ConnectivityListener> {
  bool? _previousConnectivityState;

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<bool>>(isConnectedProvider, (previous, next) {
      next.whenData((isConnected) {
        print("Listening");
        if (_previousConnectivityState == false && isConnected == true) {
          _onConnectionRestored();
        }
        if (_previousConnectivityState == true && isConnected == false) {
          print("Listening");
          _onConnectionLost();
        }
        _previousConnectivityState = isConnected;
      });
    });
    return widget.child;
  }

  void _onConnectionRestored() {
    ref.read(syncServiceProvider).syncShareCards();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AtomText(
            data: 'Connexion rétablie - Synchronisation des données en cours',
          ),
          backgroundColor: AppColors.success,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _onConnectionLost() {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AtomText(
            data: 'Connexion perdue - Mode hors ligne activé',
          ),
          backgroundColor: AppColors.warning,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
