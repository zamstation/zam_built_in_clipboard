import '_.imports.dart';

class MockClipboard extends Clipboard {
  ClipboardData _data = const ClipboardData.initialized();

  @override
  Future<ClipboardData> getData() async {
    return _data;
  }

  @override
  Future<void> setData(ClipboardData data) async {
    _data = data;
  }
}
