import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:opart_v2/tabs/tools_widget.dart';
import '../canvas.dart';
import '../model_opart.dart';
import '../opart_page.dart';
import 'palette_widget.dart';
import 'choose_pallette_widget.dart';

class GeneralTab {
  bool open = false;
  double position;
  double width;
  double tabHeight;
  bool left;
  IconData icon;
  bool hidden = false;

  void closeTab() {
    paletteTab.position = -paletteTab.width;
    paletteTab.open = false;
    toolsTab.position = -toolsTab.width;
    toolsTab.open = false;
    choosePaletteTab.position = -choosePaletteTab.width;
    choosePaletteTab.open = false;
    this.position = -this.width;
    showCustomColorPicker = false;
    rebuildOpArtPage.value++;
    rebuildTab.value++;
  }

  void openTab() {
    showCustomColorPicker = false;
    rebuildOpArtPage.value++;
    paletteTab.position = -paletteTab.width;
    paletteTab.open = false;
    toolsTab.position = -toolsTab.width;
    toolsTab.open = false;
    choosePaletteTab.position = -choosePaletteTab.width;
    choosePaletteTab.open = false;
    this.open = true;
    this.position = 0;
    showCustomColorPicker = false;
    rebuildOpArtPage.value++;
    rebuildTab.value++;

  }

  void hideTab() {
    open = false;
    position = -width -45;
    rebuildTab.value++;
  }

  Widget content() {
    return Container();
  }
}

ToolsTab toolsTab;
PaletteTab paletteTab;
ChoosePaletteTab choosePaletteTab;

class ToolsTab extends GeneralTab {
@override
bool open = false;
  @override
  IconData icon = MdiIcons.tools;

  @override
  bool left = false;

  @override
  double tabHeight = -0.5;

  @override
  double position = -80;

  @override
  double width = 80;

  void showSlider(){
  position = 80;
  rebuildTab.value++;
  }



  @override
  Widget content() {
    return toolBoxTab();
  }

}

class PaletteTab extends GeneralTab {
  @override
  bool open = false;
  BuildContext context;
  PaletteTab(this.context);
  @override
  IconData icon = Icons.palette;

  @override
  bool left = true;
@override
  void openTab() {
    toolsTab.position = -toolsTab.width;
    toolsTab.open = false;
    choosePaletteTab.position = -choosePaletteTab.width-45;
    choosePaletteTab.open = false;
    this.open = true;
    this.position = 0;
    rebuildTab.value++;
  }
  @override
  double tabHeight = -0.5;

  @override
  double width = 50;





  @override
  Widget content() {
    return PaletteTabWidget();
  }



  @override
  double position = -50;

}

class ChoosePaletteTab extends GeneralTab {
  @override
  bool open = false;
  @override
  IconData icon = Icons.palette_outlined;

  @override
  bool left = true;

  @override
  double tabHeight = 0.3;

  @override
  double width = 80;
@override
void openTab() {
  paletteTab.position = -paletteTab.width-45;
  paletteTab.open = false;
  toolsTab.position = -toolsTab.width;
  toolsTab.open = false;
  this.open = true;
  this.position = 0;
  rebuildTab.value++;

}





  @override
  Widget content() {
    return choosePaletteTabWidget();
  }




  @override
  double position = -80;


}
