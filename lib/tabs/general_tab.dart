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
    if(hidden){
      hidden = false;
    }
    position = -width;
    rebuildTab.value++;
    open = false;
  }

  void openTab() {
    position = 0;
    open = true;
    rebuildTab.value++;
  }

  void hideTab() {
    position = -width-45;
    rebuildTab.value++;
    open = false;
    hidden = true;
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
  void openTab() {
    position = 0;
    if(paletteTab.open){
    paletteTab?.closeTab();}
    if(choosePaletteTab.open){
    choosePaletteTab?.closeTab();}
    open = true;
    rebuildTab.value++;
  }

  @override
  Widget content() {
    return toolBoxTab();
  }

}

class PaletteTab extends GeneralTab {
  BuildContext context;
  PaletteTab(this.context);

  @override
  IconData icon = Icons.palette;

  @override
  bool left = true;


  @override
  double tabHeight = -0.5;

  @override
  double width = 50;

  @override
  void openTab() {
    position = 0;
    open = true;
    if(toolsTab.open){
    toolsTab.closeTab();}
    choosePaletteTab.hideTab();

    rebuildTab.value++;
  }

  @override
  void closeTab() {
    if(choosePaletteTab.hidden){
      choosePaletteTab.closeTab();
      choosePaletteTab.hidden = false;
    }
    position = -50;
    showCustomColorPicker = false;
    open = false;
    rebuildTab.value++;
  }

  @override
  Widget content() {
    return PaletteTabWidget();
  }



  @override
  double position = -50;

}

class ChoosePaletteTab extends GeneralTab {
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
    position = 0;
    open = true;
    if(toolsTab.open){
    toolsTab.closeTab();}
    paletteTab.hideTab();
    rebuildTab.value++;
  }




  @override
  Widget content() {
    return choosePaletteTabWidget();
  }

@override
void hideTab() {
  position = -width - 45;
  rebuildTab.value++;
  hidden = true;
}

@override
void closeTab(){
    if(paletteTab.hidden){
      paletteTab.closeTab();
      paletteTab.hidden = false;
    }
    if(hidden){
      hidden = false;
    }
  position = -width;
  rebuildTab.value++;
  open = false;
}
  @override
  double position = -80;


}
