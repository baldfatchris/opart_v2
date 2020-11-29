import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:opart_v2/tabs/tab_tools.dart';
import '../canvas.dart';
import '../model_opart.dart';
import '../opart_page.dart';
import 'tab_palette.dart';
import 'tab_choose_palette.dart';

class GeneralTab {
  bool open = false;

  AnimationController animationController;
  Animation animation;
  double width;
  double tabHeight;
  bool left;
  IconData icon;
  bool startOpening = false;

  void openTab() {
    startOpening = true;
    rebuildOpArtPage.value++;
    showControls = false;
    animationController.forward();
    rebuildOpArtPage.value++;
  }

  void closeTab() {
    animationController?.reverse();
    open = false;
  }

  Widget content() {
    return Container();
  }
}

ToolsTab toolsTab;
PaletteTab paletteTab;
ChoosePaletteTab choosePaletteTab;

class ToolsTab implements GeneralTab {
  @override
  AnimationController animationController;

  @override
  IconData icon = MdiIcons.tools;

  @override
  bool left = false;

  @override
  bool open = false;

  @override
  double tabHeight = -0.5;

  @override
  double width = 80;
  PaletteTab paletteTab;
  @override
  void openTab() {
    paletteTab?.closeTab();
    choosePaletteTab?.closeTab();
    animationController.forward();
    open = false;
  }

  @override
  void closeTab() {
    animationController?.reverse();
  }

  @override
  Widget content() {
    return ToolBoxTab();
  }

  @override
  Animation animation;

  @override
  bool startOpening = false;
}

class PaletteTab implements GeneralTab {
  BuildContext context;
  PaletteTab(this.context);
  @override
  AnimationController animationController;

  @override
  IconData icon = Icons.palette;

  @override
  bool left = true;

  @override
  bool open = false;

  @override
  double tabHeight = -0.5;

  @override
  double width = 50;

  @override
  void openTab() {
    toolsTab?.closeTab();
    startOpening = true;
    rebuildOpArtPage.value++;
    animationController.forward();
  }

  @override
  void closeTab() {
    showCustomColorPicker = false;
    animationController?.reverse();
    open = false;
  }

  @override
  Widget content() {
    return paletteTabWidget();
  }

  @override
  Animation animation;

  @override
  bool startOpening = false;
}

class ChoosePaletteTab implements GeneralTab {
  @override
  AnimationController animationController;

  @override
  IconData icon = Icons.palette_outlined;

  @override
  bool left = true;

  @override
  bool open = false;

  @override
  double tabHeight = 0.3;

  @override
  double width = 80;

  @override
  void openTab() {
    toolsTab?.closeTab();
    startOpening = true;
    rebuildOpArtPage.value++;

    animationController.forward();
  }

  @override
  void closeTab() {
    animationController?.reverse();
    print('should close palette tab');
  }

  @override
  Widget content() {
    return choosePaletteTabWidget();
  }

  @override
  Animation animation;

  @override
  bool startOpening = false;
}
