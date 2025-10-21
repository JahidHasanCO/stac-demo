/// Lightweight shim for SduiState used in example action parsers.
/// If the real stac runtime provides SduiState, prefer that. This shim
/// stores values in a simple in-memory map for demo/testing.

class SduiState {
  static final Map<String, dynamic> _store = {};

  static dynamic get(String key) => _store[key];

  static void set(String key, dynamic value) => _store[key] = value;
}
