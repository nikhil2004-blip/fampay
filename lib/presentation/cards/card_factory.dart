import 'package:flutter/material.dart';

import '../../data/models/card_group.dart';
import '../../state/home_provider.dart';

// Import each card type (we'll create these next step)
import 'hc1_small_display_card.dart';
import 'hc3_big_display_card.dart';
import 'hc5_image_card.dart';
import 'hc6_small_card_with_arrow.dart';
import 'hc9_dynamic_width_card.dart';

class CardFactory {
  static Widget buildCardGroup(CardGroup group, HomeProvider provider) {
    switch (group.designType) {
      case "HC1":
        return HC1SmallDisplayCard(group: group);
      case "HC3":
        return HC3BigDisplayCard(group: group, provider: provider);
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
