import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/views/colors/colors.dart';
import 'package:langame/views/users/other_profile_page.dart';
import 'package:langame/views/users/self_profile_page.dart';
import 'package:provider/provider.dart';

Widget buildUserCircle(BuildContext context, dynamic p, {double? radius}) {
  final ap = Provider.of<AuthenticationProvider>(context, listen: false);
  final cp = Provider.of<ContextProvider>(context, listen: false);
  final id = p is User ? p.uid : p.id;
  assert(
      p is User || p is Langame_Player, 'p must be a User or a Langame_Player');
  return GestureDetector(
    onTap: () =>
        cp.push(id == ap.user!.uid ? SelfProfilePage() : OtherProfilePage(id)),
    child: p.hasPhotoUrl() && p.photoUrl.isNotEmpty
        ? CircleAvatar(
            radius: radius != null
                ? radius
                : AppSize.safeBlockHorizontal *
                    5 *
                    (AppSize.isLargeWidth ? 0.4 : 1),
            backgroundImage: NetworkImage(p.photoUrl),
          )
        : CircleAvatar(
            backgroundColor: getBlackAndWhite(context, 2, reverse: true),
            radius: radius != null
                ? radius
                : AppSize.safeBlockHorizontal *
                    5 *
                    (AppSize.isLargeWidth ? 0.4 : 1),
            child: Text(
              p.tag,
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
              maxLines: 1,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
  );
}
