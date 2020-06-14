import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:reaction/game/factories/color_factory.dart';
import 'package:reaction/util/device_not_found.dart';
import 'package:reaction/util/method_not_supported.dart';

class BluetoothHandler {
  static BluetoothHandler _bluetoothHandler;

  FlutterBlue flutterBlue = FlutterBlue.instance;
  StreamSubscription<BluetoothDeviceState> _deviceConnection;
  BluetoothDevice _device;
  BluetoothDeviceState _state = BluetoothDeviceState.disconnected;
  StreamSubscription<ScanResult> scanSubscription;

  static BluetoothHandler singleton() {
    if (_bluetoothHandler == null) {
      _bluetoothHandler = BluetoothHandler._of();
    }
    return _bluetoothHandler;
  }

  BluetoothHandler._of() {
    if (_device == null) {
      _device = BluetoothDevice(id: DeviceIdentifier("C9:F7:C0:1A:FA:15"));
      _device.state.then((state) {
        _state = state;
        if (state != BluetoothDeviceState.connected) {
          connectDevice(device: _device);
        } else {}
      });
      return;
    }

    /// Stop scanning
    ///
  }

  void scan({Duration scanningTime}) {
    if (_state == BluetoothDeviceState.connected) {
      return;
    }
    scanSubscription =
        flutterBlue.scan(timeout: scanningTime).listen((scanResult) {
      if (scanResult.device.id.id == "C9:F7:C0:1A:FA:15") {
        print(scanResult.toString());
        scanResult.device.state.then((state) {
          _state = state;
          if (state == BluetoothDeviceState.connected) {
            _device = scanResult.device;
            _registerCallerOnDevice();
          } else {
            connectDevice(device: scanResult.device);
          }
        });
      }
    });
  }

  void connectDevice({BluetoothDevice device}) {
    if (_state == BluetoothDeviceState.connected) {
      return;
    }
    if (device == null) {
      device = _device;
    }
    _deviceConnection =
        flutterBlue.connect(device, timeout: Duration(seconds: 5)).listen((s) {
      _state = s;
      if (s == BluetoothDeviceState.connected) {
        print("connected");
        _device = device;
        _registerCallerOnDevice();
      } else {
        print("not connected");
      }
    });
  }

  int _frequency = 0xF0;
  var services;

  Future writeCharacteristic(Finger finger) async {
    if (services == null) {
      try {
        services = await _device.discoverServices();
      } catch (e) {
        if (_onDisconnected != null) {
          _onDisconnected();
        }
        return;
      }
    }
    var values = [0x00, 0x00, 0x00, 0x00];
    if (finger != null) {
      switch (finger) {
        case Finger.INDEX_FINGER:
          values = [_frequency, 0x00, 0x00, 0x00];
          break;
        case Finger.MIDDLE_FINGER:
          values = [0x00, _frequency, 0x00, 0x00];
          break;
        case Finger.RING_FINGER:
          values = [0x00, 0x00, _frequency, 0x00];
          break;
        case Finger.BABY_FINGER:
          values = [0x00, 0x00, 0x00, _frequency];
          break;
        default:
          throw new MethodNotSupportedException();
      }
    }
    _device.writeCharacteristic(services[2].characteristics[0], values);
  }

  Function _onData;
  Function _onDisconnected;

  set onData(Function value) {
    if (_device != null) {
      _device.onStateChanged().listen((state) {
        if (state == BluetoothDeviceState.connected) {
          _onData();
        }
      });
    }
    _onData = value;
  }

  void _registerCallerOnDevice() {
    if (_device == null) {
      scanSubscription.onDone(() {
        _device.onStateChanged().listen((state) {
          _state = state;
          if (state == BluetoothDeviceState.connected) {
            if (_onData != null) {
              _onData();
            }
          } else {
            if (_onDisconnected != null) {
              _onDisconnected();
            }
          }
        });
      });
    } else {
      _device.onStateChanged().listen((state) {
        _state = state;
        if (state == BluetoothDeviceState.connected) {
          if (_onData != null) {
            _onData();
          }
        } else {
          if (_onDisconnected != null) {
            _onDisconnected();
          }
        }
      });
    }
  }

  set onDisconnected(Function value) {
    if (_device != null) {
      _device.onStateChanged().listen((state) {
        if (state == BluetoothDeviceState.disconnected) {
          value();
        }
      });
    }
    _onDisconnected = value;
  }

  bool connected() {
    return _state == BluetoothDeviceState.connected && _device != null;
  }

  void disconnect() {
    _deviceConnection.cancel();
  }
}
