import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkCubit extends Cubit<bool> {
  final Connectivity connectivity;
  StreamSubscription? subscription;

  NetworkCubit(this.connectivity) : super(true) {
    _init(); // 👈 أضف هذا
  }

  Future<void> _init() async {
    // 🔥 أول فحص حقيقي
    final hasInternet = await InternetConnectionChecker().hasConnection;
    emit(hasInternet);

    // 🔥 الاستماع للتغير
    subscription = connectivity.onConnectivityChanged.listen((_) async {
      final hasInternet = await InternetConnectionChecker().hasConnection;
      emit(hasInternet);
    });
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}