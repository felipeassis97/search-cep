import 'package:flutter_test/flutter_test.dart';
import 'package:search_cep_project/app/modules/home/presenter/stores/home_store.dart';

void main() {
  late HomeStore store;

  setUpAll(() {
    store = HomeStore();
  });

  test('increment count', () async {
    expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));
  });
}
