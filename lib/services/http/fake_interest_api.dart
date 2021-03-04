import 'package:langame/protos/api.pb.dart';

import 'interest_api.dart';

class FakeInterestApi implements InterestApi {
  @override
  Future<List<Interest>> getInterests() async {
    List<Interest> list = [];
    list.add(Interest(value: "Foo"));
    list.add(Interest(value: "Foo"));
    list.add(Interest(value: "Bar"));
    list.add(Interest(value: "Baz"));
    return list;
  }
}
