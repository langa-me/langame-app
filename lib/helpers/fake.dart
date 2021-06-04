import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart';

User getSteveJobs() => User(
    tag: 'steveApp',
    uid: 's',
    displayName: 'Steve Jobs',
    photoUrl:
        'https://www.journaldugeek.com/content/uploads/2019/07/stevejobs.jpg');

User getMarkZuckerberg() => User(
    tag: 'markBook',
    uid: 'm',
    displayName: 'Mark Zuckerberg',
    photoUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/Mark_Zuckerberg_F8_2019_Keynote_%2832830578717%29_%28cropped%29.jpg/1200px-Mark_Zuckerberg_F8_2019_Keynote_%2832830578717%29_%28cropped%29.jpg');

User getLarryPage() => User(
    tag: 'larryGo',
    uid: 'l',
    displayName: 'Larry Page',
    photoUrl:
        'https://thumbor.forbes.com/thumbor/fit-in/416x416/filters%3Aformat%28jpg%29/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F5c76bcaaa7ea43100043c836%2F0x0.jpg%3Fbackground%3D000000%26cropX1%3D227%26cropX2%3D2022%26cropY1%3D22%26cropY2%3D1817');

List<User> faang = [getSteveJobs(), getMarkZuckerberg(), getLarryPage()];

MockUser getMockUser() => MockUser(
      isAnonymous: false,
      uid: 'someuid',
      email: 'bob@somedomain.com',
      displayName: 'Bob',
    );
