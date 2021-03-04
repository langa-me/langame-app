import 'package:langame/protos/api.pb.dart';

abstract class InterestApi {
  Future<List<Interest>> getInterests();
}
