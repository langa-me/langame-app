import 'package:flutter/material.dart';
import 'package:langame/providers/preference_provider.dart';

previewModeOrInvisible(PreferenceProvider pp, Widget w) =>
    pp.preference.previewMode ? w : SizedBox.shrink();