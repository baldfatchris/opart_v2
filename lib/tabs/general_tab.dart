import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:opart_v2/tabs/tools_widget.dart';
import '../canvas.dart';
import '../model_opart.dart';
import '../opart_page.dart';
import 'palette_widget.dart';
import 'choose_pallette_widget.dart';

class GeneralTab {
  String name;
  bool open = false;

  AnimationController animationController;
  Animation animation;
  double width;
  double tabHeight;
  bool left;
  IconData icon;

  void showTab(){}


  void openTab() {
  }

  void closeTab() {
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
  String name = 'tools';

  @override
  void showTab() {
   animation = Tween<double>(begin: 0, end: width).animate(animationController);
    animationController.forward();
  }
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
    choosePaletteTab?.closeTab();

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
  Animation animation ;





  @override
  String name = 'palette tab';

  @override
  void showTab() {
    // TODO: implement hideTab
  }
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
    paletteTab?.closeTab();

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
  String name = 'choose palette';

  @override
  void showTab() {
    // TODO: implement hideTab
  }
}
