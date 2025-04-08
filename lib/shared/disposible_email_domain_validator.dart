import 'package:flutter/services.dart';

class DisposableEmailValidator {
  Set<String> _domains = {};

  Future<void> loadDomains() async {
    final raw =
        await rootBundle.loadString('assets/email_block_domain_list.conf');
    _domains = raw
        .split('\n')
        .map((line) => line.trim().toLowerCase())
        .where((line) => line.isNotEmpty && !line.startsWith('#'))
        .toSet();
  }

  bool isDisposable(String email) {
    final domain = email.split('@').last.toLowerCase();
    return _domains.contains(domain);
  }
}
