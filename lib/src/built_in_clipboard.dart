import 'package:flutter/services.dart' as p show Clipboard, ClipboardData;
import 'package:zam_clipboard/zam_clipboard.dart';

class BuiltInClipboard extends Clipboard {
  @override
  Future<ClipboardData> getData() {
    final response = p.Clipboard.getData(p.Clipboard.kTextPlain);
    return response.then(_decode);
  }

  @override
  Future<void> setData(ClipboardData data) {
    final request = _encode(data);
    return p.Clipboard.setData(request);
  }

  p.ClipboardData _encode(ClipboardData data) {
    return p.ClipboardData(
      text: data.text,
    );
  }

  ClipboardData _decode(p.ClipboardData? data) {
    return ClipboardData(data?.text ?? '');
  }
}
