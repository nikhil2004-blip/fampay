import 'package:fampay/state/home_provider.dart';
import 'package:flutter/material.dart';
import '../../data/models/card_group.dart';

// Import card types
import '../cards/hc1_small_display_card.dart';
import '../cards/hc3_big_display_card.dart';
import '../cards/hc5_image_card.dart';
import '../cards/hc6_small_card_with_arrow.dart';
import '../cards/hc9_dynamic_width_card.dart';

class CardFactory {
  static Widget buildCardGroup(CardGroup group, HomeProvider homeProvider) {
    switch (group.designType) {
      case "HC1":
        return HC1SmallDisplayCard(group: group);
      case "HC3":
        return HC3BigDisplayCard(
          group: group,
          provider: homeProvider,   // ✅ pass provider here
        );
      case "HC5":
        return HC5ImageCard(group: group);
      case "HC6":
        return HC6SmallCardWithArrow(group: group);
      case "HC9":
        return HC9DynamicWidthCard(group: group);
      default:
        return const SizedBox.shrink();
    }
  }
}
