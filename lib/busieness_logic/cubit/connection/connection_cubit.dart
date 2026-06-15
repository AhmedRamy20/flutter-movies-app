import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectionCubit extends Cubit<bool> {
  final Connectivity _connectivity = Connectivity();

  ConnectionCubit() : super(true) {
    _init();
  }

  void _init() {
    _connectivity.onConnectivityChanged.listen((result) {
      final isOnline = result != ConnectivityResult.none;
      emit(isOnline);
    });
  }
}
