import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roasters/core/network/network_cubit.dart';

mixin NetworkRetryMixin<T extends StatefulWidget> on State<T> {
  bool wasDisconnected = false;
  StreamSubscription? sub;

  void listenNetwork(VoidCallback onReconnect) {
    Future.microtask(() {
      sub = BlocProvider.of<NetworkCubit>(context).stream.listen((isConnected) {
        if (!isConnected) {
          wasDisconnected = true;
        }

        if (isConnected && wasDisconnected) {
          wasDisconnected = false;
          onReconnect();
        }
      });
    });
  }

  @override
  void dispose() {
    sub?.cancel();
    super.dispose();
  }
}