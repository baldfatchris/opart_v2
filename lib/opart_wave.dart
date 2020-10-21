import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';
import 'package:screenshot/screenshot.dart';
import 'package:shake/shake.dart';
import 'package:opart_v2/setting_slider.dart';
import 'package:opart_v2/setting_intslider.dart';
import 'package:opart_v2/setting_dropdown.dart';
import 'package:opart_v2/setting_colorpicker.dart';
import 'package:opart_v2/setting_radiobutton.dart';
import 'model.dart';

Random rnd;

// Settings
Wave currentWave;

const List palettes = [
  ['default', 10, Color(0xFFffffff), [Color(0xFF34a1af), Color(0xFFa570a8), Color(0xFFd6aa27), Color(0xFF5f9d50), Color(0xFF789dd1), Color(0xFFc25666), Color(0xFF2b7b1), Color(0xFFd63aa), Color(0xFF1f4ed), Color(0xFF383c47)]],
  ['Black and White',2,'0xFF111111',['0xFF000000','0xFFffffff']],
  ['Doge Leonardo',10,'0xFFffffff',['0xFF335362','0xFF30444C','0xFF324B56','0xFF5C381E','0xFF403424','0xFF605239','0xFF7B6A4C','0xFF9A8564','0xFFB3A889','0xFF273638']],
  ['The Birth of Venus',10,'0xFFffffff',['0xFF303227','0xFF13160F','0xFF514F3D','0xFF7AA58B','0xFF647A63','0xFF9C8E64','0xFFA9C9AB','0xFFC0B381','0xFF8C6240','0xFFE3E0B0']],
  ['Bridget Riley - Achæan',10,'0xFFffffff',['0xFF37A7BC','0xFFB4B165','0xFFA47EA4','0xFF69ABCB','0xFF79B38E','0xFF17B8E0','0xFFD1EFED','0xFF151E2A','0xFF725549','0xFF074E71']],
  ['Bridget Riley - Evoe 3',3,'0xFFffffff',['0xFFBDABB3','0xFF4A6FBA','0xFF468889']],
  ['Bridget Riley - Fete',10,'0xFFffffff',['0xFF45719C','0xFFC3605A','0xFF78A8D0','0xFF2C2F34','0xFFE8EAE3','0xFF6A9056','0xFFAC88AA','0xFFCFC177','0xFF72AD9A','0xFF856974']],
  ['Bridget Riley - Nataraja',10,'0xFFffffff',['0xFFB7594C','0xFF7795C5','0xFFD2A648','0xFF3D679D','0xFFE3CE9C','0xFFB783A1','0xFF366A52','0xFF92B159','0xFF66874C','0xFF61A578']],
  ['Bridget Riley - Summers Day',10,'0xFFffffff',['0xFFF2EEF2','0xFFF3EAE0','0xFFC3AE7F','0xFFA5B0CD','0xFFB5AF97','0xFFACAEB7','0xFFCAAC96','0xFFC4ADAD','0xFFDECFBE','0xFFD0D2E1']],
  ['Da Vinci - The Last Supper',10,'0xFFffffff',['0xFF68533B','0xFF826347','0xFF3F2F1A','0xFF52412C','0xFF94755C','0xFF656462','0xFF251A0B','0xFF787C7F','0xFFA08F80','0xFFB5ADA5']],
  ['Da Vinci - The Mona Lisa',10,'0xFFffffff',['0xFF1B0C06','0xFF35240E','0xFF4F3916','0xFFA28832','0xFF887329','0xFFBE9F3D','0xFFEAB439','0xFF675D25','0xFF814811','0xFFBD751B']],
  ['Gaugin - Woman of the Mango',10,'0xFFffffff',['0xFF222843','0xFF313350','0xFF121C2E','0xFFBD8F03','0xFF403825','0xFF614020','0xFF606E70','0xFF88928B','0xFFA68319','0xFF8D501A']],
  ['Gericault - Raft of the Medusa',10,'0xFFffffff',['0xFF46341A','0xFF21190E','0xFF342514','0xFF0D0D08','0xFF554525','0xFF695531','0xFF856A3E','0xFFA28250','0xFFBE9E63','0xFFE3C47F']],
  ['Grant Wood - American Gothic',10,'0xFFffffff',['0xFF1A1F24','0xFFC5B088','0xFF7E7966','0xFF6A624C','0xFFC0DECD','0xFFA49477','0xFFD7CAA4','0xFF50462E','0xFFCAEAE1','0xFFECE9C5']],
  ['Hockney - Felled Waves on Woldgate',10,'0xFFffffff',['0xFF0D9155','0xFF167691','0xFF14341D','0xFFB1D3E7','0xFFB9A0AC','0xFF604065','0xFF52A3BC','0xFFE5BD81','0xFFA88451','0xFF51B871']],
  ['Hockney - Pacific Coast Highway',10,'0xFFffffff',['0xFF1157A0','0xFFB04A12','0xFF0B5B24','0xFF5C6E9D','0xFF6D942B','0xFF272A36','0xFF7BACAD','0xFFA87BA2','0xFF22846E','0xFFCBBC09']],
  ['Hockney - The Arrival of Spring',10,'0xFFffffff',['0xFF15987B','0xFF2A6A3B','0xFF852308','0xFF502F18','0xFF0F4318','0xFF98553F','0xFF805986','0xFF5B955E','0xFFCCBF56','0xFF0FBF16']],
  ['Hopper - Nighthawks',10,'0xFFffffff',['0xFF1C2521','0xFF1F3430','0xFF659170','0xFFDEDD86','0xFF3E5C48','0xFF342315','0xFF53311F','0xFF462212','0xFF70331B','0xFFAC772D']],
  ['Hokusai - The Great Wave',6,'0xFFffffff',['0xFFEBE5CC','0xFFD6CDB2','0xFFB7B5A2','0xFF888B82','0xFF4B5560','0xFF243042']],
  ['Klimt - The Kiss',10,'0xFFffffff',['0xFFBFA552','0xFFD0B350','0xFF786331','0xFFB19543','0xFFC0B393','0xFF907839','0xFF968E72','0xFF66588F','0xFFB85D3C','0xFF413526']],
  ['Matisse - Danse',4,'0xFFffffff',['0xFF354762','0xFFB64237','0xFF27584C','0xFF6F2121']],
  ['Matisse - Danse I',5,'0xFFffffff',['0xFF495696','0xFFBE8A7E','0xFF4D6B68','0xFF334F49','0xFF2A2622']],
  ['Matisse - Icarus',4,'0xFFffffff',['0xFF2459E4','0xFF101626','0xFFE7E273','0xFF940F0A']],
  ['Matisse - Jazz',5,'0xFFffffff',['0xFFE9E8D0','0xFF07090A','0xFFD92D2A','0xFF1766F3','0xFFE5F146']],
  ['Matisse - La Gerbe',6,'0xFFffffff',['0xFFEFEAD9','0xFF266EA8','0xFF255B37','0xFF8DAA8A','0xFFD7AA3F','0xFFB9454E']],
  ['Matisse - Les Codomas',8,'0xFFffffff',['0xFFCF881C','0xFFE6DF2D','0xFF1D1D14','0xFFD7DCD6','0xFF5A9C8A','0xFF97263F','0xFF264AC6','0xFFE2EBE9']],
  ['Matisse - Snow Flowers',9,'0xFFffffff',['DA803A','0xFFDC9E84','0xFFE2D7C5','0xFFD16886','0xFFE9E5DC','0xFF1E433E','0xFFCCCABF','0xFFA51612','0xFF527799']],
  ['Matisse - Parakeet and the Mermaid',10,'0xFFffffff',['0xFFF4FAFC','0xFFD18707','0xFFA710AA','0xFF3A3408','0xFF0B8AB3','0xFF1DB314','0xFF1F152C','0xFF8D5A09','0xFF6A0F69','0xFF0C526D']],
  ['Matisse - The Snail',8,'0xFFffffff',['0xFFFB7C1C','0xFF4AE95F','0xFFEADECB','0xFFC864E2','0xFF407CF5','0xFFE4A060','0xFFE2162A','0xFF131716']],
  ['Mondrian',6,'0xFFffffff',['0xFFF50F0F','0xFFF8E213','0xFF0C7EBD','0xFFF2F2F2','0xFF000000','0xFF363636']],
  ['Monet - Charing Cross Bridge',10,'0xFFffffff',['0xFF929696','0xFF778D99','0xFF86918D','0xFF788B86','0xFF84969E','0xFF9CA19F','0xFF688796','0xFF9E9585','0xFF587D8A','0xFFB7AB9D']],
  ['Munch - The Scream',10,'0xFFffffff',['0xFF403130','0xFF644D3C','0xFFD6995C','0xFFCF5629','0xFF8D6D46','0xFFD57C42','0xFF21141B','0xFFAE8552','0xFF625E67','0xFFD18C2D']],
  ['Picasso - Guernica',10,'0xFFffffff',['0xFF33362D','0xFF292B22','0xFFDAD5CF','0xFFC5C0B8','0xFF1B1C14','0xFFAAA89F','0xFF595C51','0xFF8D8D82','0xFF45483D','0xFF6F7268']],
  ['Picasso - The Tragedy',10,'0xFFffffff',['0xFF1E4056','0xFF5398AC','0xFF285873','0xFF6DBFE6','0xFF4CA4D7','0xFF6FAEBA','0xFF132833','0xFF8FD4E8','0xFF417C8F','0xFF2D7CAD']],
  ['Picasso - The Tragedy - reduced',5,'0xFFffffff',['0xFF5AA5C3','0xFF3D81A0','0xFF7DC8E5','0xFF26536D','0xFF173140']],
  ['Seurat - Sunday Afternoon',10,'0xFFffffff',['0xFF343C33','0xFF495B42','0xFF64665F','0xFF4A4956','0xFFB4AE79','0xFF7E7E7D','0xFF9F9A69','0xFF817E56','0xFFA0A6A9','0xFFC8C6BA']],
  ['Van Eyck - The Arnolfini Portrait',10,'0xFFffffff',['0xFF292225','0xFF141517','0xFF393231','0xFF542527','0xFF20350B','0xFF634B3C','0xFF304E0A','0xFF726859','0xFF9C907A','0xFFC4BCAB']],
  ['Van Gogh - Self Portrait',10,'0xFFffffff',['89A696','0xFF7E9989','0xFF93B2A4','0xFF70897B','0xFFA4C3B3','0xFF999C6D','0xFF7B7442','0xFF556D65','0xFFBFC092','0xFF4F4F2D']],
  ['Van Gogh - The Starry Night',10,'0xFFffffff',['0xFF44608A','0xFF191F1E','0xFF5A799D','0xFF283441','0xFF2C4175','0xFF8098A4','0xFF6E837F','0xFFA8B391','0xFF47585C','0xFFA79F39']],
  ['Van Gogh - Wheat Field with Cypresses',10,'0xFFffffff',['0xFF94A3A7','0xFFABB6B4','0xFF7E9196','0xFF8B791A','0xFF495936','0xFFC7CDC2','0xFF213421','0xFFAC9934','0xFF6C7B51','0xFF637982']],
  ['Vermeer - Girl with a Pearl Earring',10,'0xFFffffff',['0xFF181308','0xFF28261C','0xFF716046','0xFF9A8059','0xFF4A3E2C','0xFF2A3844','0xFFC0A687','0xFFDBC7B5','0xFF93A2AF','0xFF617586']],
  ['Whistlers Mother',10,'0xFFffffff',['0xFF111012','0xFF2E2D30','0xFF888985','0xFFFEFEFE','0xFF42403D','0xFF5E594B','0xFF767772','0xFFE7E7E8','0xFFB2AA9C','0xFFC9C6BF']],
  ['Goat 1',8,'0xFFffffff',['0xFF413734','0xFF282222','0xFF76665E','0xFF674A3E','0xFF4E4F50','0xFF8E8078','0xFFB0A59C','0xFFDFD7CD']],
  ['Goat 2',8,'0xFFffffff',['0xFF3E3E40','0xFF202123','0xFF5E5C5C','0xFF82817F','0xFFA1A9AB','0xFFCDD2CE','0xFF7393AF','0xFF516E8A']],
  ['Goat 3',10,'0xFFffffff',['0xFF3E3E40','0xFF202123','0xFF5E5C5C','0xFF82817F','0xFFA1A9AB','0xFFCDD2CE','0xFF7393AF','0xFF516E8A','0xFF61493F','0xFF8D7569']],
  ['Maits Stairs',10,'0xFFffffff',['0xFF5F6F82','0xFF393A37','0xFF52575A','0xFF1F1E1A','0xFFDCDAC7','0xFFCDC6AC','0xFFEAE9D9','0xFFB9B193','0xFF99937E','0xFF81755A']],
  ['Lilly',8,'0xFFffffff',['0xFFBEBFB1','0xFF273313','0xFFA9A894','0xFF807550','0xFF3F4B22','0xFF513C07','0xFFB3770D','0xFF101C09']],
  ['Man in blue hat',10,'0xFFffffff',['0xFF181714','0xFF1F1E1A','0xFF2A2822','0xFF5E6160','0xFF3D372E','0xFF494C4B','0xFFE5E6E2','0xFFD8BEA9','0xFFB58B71','0xFF919FBB']],
  ['Spider',10,'0xFFffffff',['0xFFA7A98D','0xFF94957A','0xFF818168','0xFF6F6B58','0xFF5B5147','0xFF2D1D19','0xFFBDBFA3','0xFF0F0C08','0xFF473631','0xFFE3E3D4']],
  ['Deck Chairs',7,'0xFFffffff',['0xFFEDEFEE','0xFF8E6C53','0xFFDDCFB6','0xFFBB9E7F','0xFFAA1C10','0xFF5F3C28','0xFF8CCDEE']],
  ['Bo Kaap',10,'0xFFffffff',['0xFFC05655','0xFFD5CF5C','0xFFC0B1B8','0xFF776B52','0xFF97969B','0xFF563345','0xFF441D21','0xFF0F4C69','0xFF5083AD','0xFFE4E4DE']],
  ['Pantone Pop Stripes',13,'0xFFffffff',['0xFFBF5E02','0xFFA2B035','0xFFD0920A','0xFF718FBF','0xFFE4C91C','0xFF082670','0xFF6D041F','0xFF4F3820','0xFFE0C9CC','0xFFE3C9CA','0xFF8D1C15','0xFFABC8CA','0xFFE27000']],
  ['Purple Artichokes',16,'0xFFffffff',['0xFF907B8E','0xFFAB96AF','0xFFD7DAD8','0xFFC3B3CF','0xFF79736D','0xFFB5C0B1','0xFF97A389','0xFF5E4E54','0xFF3A342D','0xFFEBF8F5','0xFF9CA693','0xFF6F855E','0xFF899775','0xFFD8E1D6','0xFF91C0AB','0xFF6BA381']],
  ['Stained Glass',10,'0xFFffffff',['0xFF160716','0xFF491A2D','0xFFE9BD33','0xFF412A67','0xFF5F519E','0xFF8A4946','0xFF6D80DA','0xFFC58CA8','0xFFCF2C6E','0xFFF1E6E4']],
  ['Ferns',10,'0xFFffffff',['0xFF4B4810','0xFF9AA93A','0xFF828D29','0xFF343008','0xFF5C5428','0xFF746E38','0xFF686D17','0xFF181801','0xFFB1C053','0xFF8F8A4E']],
  ['Rhubarb',7,'0xFFffffff',['0xFFB93A3D','0xFFAE3E20','0xFFA32323','0xFF821107','0xFF8A1210','0xFFC45A2E','0xFFD1605D']],
  ['SriDevi',10,'0xFFffffff',['0xFF884761','0xFF723A4D','0xFFA04F71','0xFFBD9E79','0xFFBEA592','0xFFAA707A','0xFFAB8F70','0xFFB9858A','0xFF936669','0xFFCCBEAF']],
  ['Peacock',15,'0xFFffffff',['0xFF55773E','0xFF355523','0xFF779758','0xFF172C12','0xFF8DC773','0xFFBAE898','0xFFE6F3CB','0xFFC4A983','0xFF30A4D7','0xFF1E477C','0xFF111832','0xFF16B2D5','0xFF28A95E','0xFFEFDA58','0xFFA72F2B','0xFFB8B01E']],
  ['Coronavirus',8,'0xFFffffff',['0xFF1B1919','0xFF641C19','0xFF922F2E','0xFF8C837E','0xFFB8A49C','0xFFBE4F4D','0xFF695C57','0xFFDDD3CB']],
];
String currentNamedPalette;

class Wave {
  // image settings

  SettingsModelDouble stepX = SettingsModelDouble(label: 'stepX',tooltip: 'The horizontal width of each stripe ', min: 0.01, max: 50, defaultValue: 10, icon: Icon(Icons.ac_unit));
  SettingsModelDouble stepY = SettingsModelDouble(label: 'stepY',tooltip: 'The vertical distance between points on each stripe ',min: 0.01,max: 500, defaultValue: 0.1, icon: Icon(Icons.bluetooth_audio));
  SettingsModelDouble frequency = SettingsModelDouble(label: 'frequency',tooltip: 'The frequency of the wave ', min: 0, max: 5, defaultValue: 1, icon: Icon(Icons.smoke_free));
  SettingsModelDouble amplitude = SettingsModelDouble(label: 'amplitude',tooltip: 'The amplitude of the wave ', min: 0, max: 500, defaultValue: 100, icon: Icon(Icons.weekend));

// palette settings
  SettingsModelColour backgroundColour = SettingsModelColour(label: "Background Colour", tooltip: "The background colour for the canvas", defaultValue: Colors.white, icon: Icon(Icons.settings_overscan), );
  SettingsModelBool randomColours = SettingsModelBool(label: 'Random Colours', tooltip: 'Randomise the coloursl', defaultValue: false, icon: Icon(Icons.gamepad));
  SettingsModelInt numberOfColours = SettingsModelInt(label: 'Number of Colours', tooltip: 'The number of colours in the palette', min: 1, max: 36, defaultValue: 10, icon: Icon(Icons.palette));
  SettingsModelList paletteType = SettingsModelList(label: "Palette Type", tooltip: "The nature of the palette", defaultValue: "random", icon: Icon(Icons.colorize), options: ['random', 'blended random ', 'linear random', 'linear complementary'],);
  SettingsModelDouble opacity = SettingsModelDouble(label: 'Opactity', tooltip: 'The opactity of the petal', min: 0, max: 1, defaultValue: 1, icon: Icon(Icons.remove_red_eye));
  SettingsModelList paletteList = SettingsModelList(label: "Palette", tooltip: "Choose from a list of palettes", defaultValue: "Default", icon: Icon(Icons.palette), options: ['Default', 'Black and White',	'Doge Leonardo',	'The Birth of Venus',	'Bridget Riley - Achæan',	'Bridget Riley - Evoe 3',	'Bridget Riley - Fete',	'Bridget Riley - Nataraja',	'Bridget Riley - Summers Day',	'Da Vinci - The Last Supper',	'Da Vinci - The Mona Lisa',	'Gaugin - Woman of the Mango',	'Gericault - Raft of the Medusa',	'Grant Wood - American Gothic',	'Hockney - Felled Waves on Woldgate',	'Hockney - Pacific Coast Highway',	'Hockney - The Arrival of Spring',	'Hopper - Nighthawks',	'Hokusai - The Great Wave',	'Klimt - The Kiss',	'Matisse - Danse',	'Matisse - Danse I',	'Matisse - Icarus',	'Matisse - Jazz',	'Matisse - La Gerbe',	'Matisse - Les Codomas',	'Matisse - Snow Flowers',	'Matisse - Parakeet and the Mermaid',	'Matisse - The Snail',	'Mondrian',	'Monet - Charing Cross Bridge',	'Munch - The Scream',	'Picasso - Guernica',	'Picasso - The Tragedy',	'Picasso - The Tragedy - reduced',	'Seurat - Sunday Afternoon',	'Van Eyck - The Arnolfini Portrait',	'Van Gogh - Self Portrait',	'Van Gogh - The Starry Night',	'Van Gogh - Wheat Field with Cypresses',	'Vermeer - Girl with a Pearl Earring',	'Whistlers Mother',	'Goat 1',	'Goat 2',	'Goat 3',	'Maits Stairs',	'Lilly',	'Man in blue hat',	'Spider',	'Deck Chairs',	'Bo Kaap',	'Pantone Pop Stripes',	'Purple Artichokes',	'Stained Glass',	'Ferns',	'Rhubarb',	'SriDevi',	'Peacock',	'Coronavirus',],);

  List palette;
  double aspectRatio;
  File image;

// lock settings
  bool paletteLOCK = false;
  bool aspectRatioLOCK = false;

  Random random;

  Wave({

    // palette settings
    this.palette,
    this.aspectRatio = pi / 2,
    this.image,

    this.paletteLOCK = false,
    this.aspectRatioLOCK = false,
    this.random,
  });

  void randomize() {
    print('-----------------------------------------------------');
    print('randomize');
    print('-----------------------------------------------------');

    rnd = Random(DateTime.now().millisecond);


    this.stepX.randomise(random);
    this.stepY.randomise(random);
    this.frequency.randomise(random);
    this.amplitude.randomise(random);

    this.backgroundColour.randomise(random);
    this.randomColours.randomise(random);
    this.numberOfColours.randomise(random);
    this.paletteType.randomise(random);
    this.opacity.randomise(random);


    this.paletteList.randomise(random);
  }

  void randomizePalette() {
    print('-----------------------------------------------------');
    print('randomizePalette');
    print('-----------------------------------------------------');

    rnd = Random(DateTime.now().millisecond);

    this.backgroundColour.randomise(random);

    int numberOfColours = this.numberOfColours.value;

    List palette = [];
    switch (this.paletteType.value) {

    // blended random
      case 'blended random':
        {
          double blendColour = rnd.nextDouble() * 0xFFFFFF;
          for (int colourIndex = 0; colourIndex < numberOfColours; colourIndex++) {
            palette.add(Color(((blendColour + rnd.nextDouble() * 0xFFFFFF) / 2).toInt()).withOpacity(1));
          }
        }
        break;

    // linear random
      case 'linear random':
        {
          List startColour = [rnd.nextInt(255), rnd.nextInt(255), rnd.nextInt(255)];
          List endColour = [rnd.nextInt(255), rnd.nextInt(255), rnd.nextInt(255)];
          for (int colourIndex = 0; colourIndex < numberOfColours; colourIndex++) {
            palette.add(Color.fromRGBO(
                ((startColour[0] * colourIndex + endColour[0] * (numberOfColours - colourIndex)) / numberOfColours).round(),
                ((startColour[1] * colourIndex + endColour[1] * (numberOfColours - colourIndex)) / numberOfColours).round(),
                ((startColour[2] * colourIndex + endColour[2] * (numberOfColours - colourIndex)) / numberOfColours).round(),
                1));
          }
        }
        break;

    // linear complementary
      case 'linear complementary':
        {
          List startColour = [rnd.nextInt(255), rnd.nextInt(255), rnd.nextInt(255)];
          List endColour = [255 - startColour[0], 255 - startColour[1], 255 - startColour[2]];
          for (int colourIndex = 0; colourIndex < numberOfColours; colourIndex++) {
            palette.add(Color.fromRGBO(
                ((startColour[0] * colourIndex + endColour[0] * (numberOfColours - colourIndex)) / numberOfColours).round(),
                ((startColour[1] * colourIndex + endColour[1] * (numberOfColours - colourIndex)) / numberOfColours).round(),
                ((startColour[2] * colourIndex + endColour[2] * (numberOfColours - colourIndex)) / numberOfColours).round(),
                1));
          }
        }
        break;

    // random
      default:
        {
          for (int colorIndex = 0;
          colorIndex < numberOfColours;
          colorIndex++) {
            palette.add(
                Color((rnd.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1));
          }
        }
        break;
    }

    this.palette = palette;
  }

  void defaultSettings() {
    // resets to default settings

    this.stepX.value = this.stepX.defaultValue;
    this.stepY.value = this.stepY.defaultValue;
    this.frequency.value = this.frequency.defaultValue;
    this.amplitude.value = this.amplitude.defaultValue;

    // palette settings
    this.backgroundColour.value = this.backgroundColour.defaultValue;
    this.randomColours.value = this.randomColours.defaultValue;
    this.numberOfColours.value = this.numberOfColours.defaultValue;
    this.paletteType.value = this.paletteType.defaultValue;
    this.opacity.value = this.opacity.defaultValue;
    this.paletteList.value = this.paletteList.defaultValue;

    this.palette = [Color(0xFF37A7BC), Color(0xFFB4B165), Color(0xFFA47EA4), Color(0xFF69ABCB), Color(0xFF79B38E), Color(0xFF17B8E0), Color(0xFFD1EFED), Color(0xFF151E2A), Color(0xFF725549), Color(0xFF074E71)];

    this.aspectRatio = pi / 2;

    this.image;

    this.paletteLOCK = false;
    this.aspectRatioLOCK = false;
  }
}

List settingsList = [
  currentWave.stepX ,
  currentWave.stepY ,
  currentWave.frequency ,
  currentWave.amplitude ,

  currentWave.backgroundColour,
  currentWave.numberOfColours,
  currentWave.randomColours,
  currentWave.paletteType,
  currentWave.opacity ,
  currentWave.paletteList,
];

class OpArtWaveStudio extends StatefulWidget {


  OpArtWaveStudio();

  @override
  _OpArtWaveStudioState createState() => _OpArtWaveStudioState();
}

class _OpArtWaveStudioState extends State<OpArtWaveStudio>
    with TickerProviderStateMixin {
  int _counter = 0;
  File _imageFile;
  int _currentColor = 0;

  // Animation<double> animation1;
  // AnimationController controller1;

  // Animation<double> animation2;
  // AnimationController controller2;


  List<Map<String, dynamic>> cachedWaveList = [];
  cacheWave(
      ScreenshotController screenshotController, Function SetState) async {
    print('cache fibonacci');
    screenshotController
        .capture(delay: Duration(milliseconds: 10), pixelRatio: 0.2)
        .then((File image) async {
      currentWave.image = image;

      Map<String, dynamic> currentCache = {
        'aspectRatio': currentWave.aspectRatio,
        'stepX': currentWave.stepX.value,
        'frequency': currentWave.frequency.value,
        'amplitude': currentWave.amplitude.value,

        'backgroundColour': currentWave.backgroundColour.value,
        'randomColours': currentWave.randomColours.value,
        'numberOfColours': currentWave.numberOfColours.value,
        'paletteType': currentWave.paletteType.value,
        'opacity': currentWave.opacity.value,

        'image': currentWave.image,

      };
      cachedWaveList.add(currentCache);
      SetState();
    });
  }

  ScrollController _scrollController = new ScrollController();
  @override
  Widget bodyWidget() {
    return Screenshot(
      controller: screenshotController,
      child: Stack(
        children: [
          Visibility(
            visible: true,
            child: LayoutBuilder(
              builder: (_, constraints) => Container(
                width: constraints.widthConstraints().maxWidth,
                height: constraints.heightConstraints().maxHeight,
                child: CustomPaint(
                    painter: OpArtWavePainter(
                      seed, rnd,
                      // animation1.value,
                      // animation2.value
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
    SetState() {
      setState(() {});
    }


    Widget bodyWidget() {
      return Screenshot(
        controller: screenshotController,
        child: Stack(
          children: [
            Visibility(
              visible: true,
              child: LayoutBuilder(
                builder: (_, constraints) => Container(
                  width: constraints.widthConstraints().maxWidth,
                  height: constraints.heightConstraints().maxHeight,
                  child: CustomPaint(
                      painter: OpArtWavePainter(
                        seed, rnd,
                        // animation1.value,
                        // animation2.value
                      )),
                ),
              ),
            )
          ],
        ),
      );
    }


    void _showBottomSheetSettings(context, int index) {
      showDialog(
        //  backgroundColour: Colors.white.withOpacity(0.8),
          barrierColor: Colors.white.withOpacity(0.1),
          context: context,
          builder: (BuildContext bc) {
            return StatefulBuilder(
                builder: (BuildContext context, setLocalState) {
                  return Center(
                    child: AlertDialog(backgroundColor: Colors.white.withOpacity(0.7),
                      title: Text(settingsList[index].label),
                      content: Column(mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          (settingsList[index].type == 'Double') ?

                          settingsSlider(
                            settingsList[index].label,
                            settingsList[index].tooltip,
                            settingsList[index].value,
                            settingsList[index].min,
                            settingsList[index].max,
                            settingsList[index].locked,
                                (value) {
                              setState(() {
                                settingsList[index].value = value;
                              });
                              setLocalState((){});
                            },
                                (value) {
                              setState(() {
                                settingsList[index].locked = value;
                              });
                              setLocalState((){});
                            },
                                (){},
                          )
                              :
                          (settingsList[index].type == 'Int') ?

                          settingsIntSlider(
                            settingsList[index].label,
                            settingsList[index].tooltip,
                            settingsList[index].value,
                            settingsList[index].min,
                            settingsList[index].max,
                            settingsList[index].locked,
                                (value) {
                              setState(() {
                                settingsList[index].value = value.toInt();
                              });
                              setLocalState((){});
                            },
                                (value) {
                              setState(() {
                                settingsList[index].locked = value;
                              });
                              setLocalState((){});
                            },
                                (){},
                          )
                              :
                          (settingsList[index].type == 'List') ?

                          settingsDropdown(
                            settingsList[index].label,
                            settingsList[index].tooltip,
                            settingsList[index].value,
                            settingsList[index].options,
                            settingsList[index].locked,

                                (value) {
                              setState(() {
                                settingsList[index].value = value;
                              });
                              setLocalState((){});
                            },
                                (value) {
                              setState(() {
                                settingsList[index].locked = !settingsList[index].locked;
                              });
                            },

                          )
                              :
                          (settingsList[index].type == 'Colour') ?

                          settingsColourPicker(
                            settingsList[index].label,
                            settingsList[index].tooltip,
                            settingsList[index].value,
                            settingsList[index].locked,

                                (value) {
                              setState(() {
                                settingsList[index].value = value;
                              });
                              setLocalState((){});
                            },
                                (value) {
                              setState(() {
                                settingsList[index].locked = value;
                              });
                              setLocalState((){});
                            },

                          )
                              :
                          settingsRadioButton(
                            settingsList[index].label,
                            settingsList[index].tooltip,
                            settingsList[index].value,
                            settingsList[index].locked,

                                (value) {
                              setState(() {
                                settingsList[index].value = value;
                              });
                              setLocalState((){});
                            },
                                (value) {
                              setState(() {
                                settingsList[index].locked = value;
                              });
                              setLocalState((){});
                            },


                          ),
                        ],
                      ),
                    ),
                  );
                });
          });
    }

    void _showBottomSheet(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return Container(
                height: 350,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemCount: settingsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 10,
                        width: 10,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            _showBottomSheetSettings(context, index,
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              settingsList[index].icon,
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                    height: 40,
                                    child: Text(
                                      settingsList[index].label,
                                      textAlign: TextAlign.center,
                                    )),
                              )
                            ],
                          ),
                        ),
                      );
                    }));
          });
    }

    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        child: BottomAppBar(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                    onPressed: () {
                      setState(() {
                        currentWave.randomize();
                        currentWave.randomizePalette();
                        cacheWave(screenshotController, SetState);
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.refresh),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Randomise \nEverything',
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    )),
                FlatButton(
                    onPressed: () {
                      _showBottomSheet(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Tools',
                        textAlign: TextAlign.center,
                      ),
                    )),
                FlatButton(
                    onPressed: () {
                      setState(() {
                        currentWave.randomizePalette();
                        cacheWave(screenshotController, SetState);
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.palette),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Randomise \nPalette',
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ))
              ],
            )),
      ),
      body: Stack(
        children: [
          bodyWidget(),
          Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              height: 60,
              child: cachedWaveList.length == 0
                  ? Container()
                  : ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                itemCount: cachedWaveList.length,
                shrinkWrap: true,
                reverse: false,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentWave.stepX.value = cachedWaveList[index]['stepX'];
                          currentWave.stepY.value = cachedWaveList[index]['stepY'];
                          currentWave.frequency.value = cachedWaveList[index]['frequency'];
                          currentWave.amplitude.value = cachedWaveList[index]['amplitude'];
                          currentWave.image = cachedWaveList[index]['image'];
                          currentWave.backgroundColour.value = cachedWaveList[index]['backgroundColour'];
                          currentWave.randomColours.value = cachedWaveList[index]['randomColours'];
                          currentWave.numberOfColours.value = cachedWaveList[index]['numberOfColours'];
                          currentWave.paletteType.value = cachedWaveList[index]['paletteType'];
                          currentWave.opacity.value = cachedWaveList[index]['opacity'];
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        width: 50,
                        height: 50,
                        child: Image.file(
                            cachedWaveList[index]['image']),
                      ),
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
      print(
          '---------------------------------------------------------------------------');
      print('SHAKE');
      print(
          '---------------------------------------------------------------------------');
      setState(() {
        currentWave.randomize();
        currentWave.randomizePalette();
        //randomiseSettings();
      });
    });
    // To close: detector.stopListening();
    // ShakeDetector.waitForStart() waits for user to call detector.startListening();

    // Animation Stuff
    // controller1 = AnimationController(
    //   vsync: this,
    //   duration: Duration(seconds: 7200),
    // );

    // controller2 = AnimationController(
    //   vsync: this,
    //   duration: Duration(seconds: 60),
    // );

    // Tween<double> _angleTween = Tween(begin: -pi, end: pi);
    // Tween<double> _fillTween = Tween(begin: 1, end: 1);

    // animation1 = _angleTween.animate(controller1)
    //   ..addListener(() {
    //     setState(() {});
    //   })
    //   ..addStatusListener((status) {
    //     if (status == AnimationStatus.completed) {
    //       controller1.repeat();
    //     } else if (status == AnimationStatus.dismissed) {
    //       controller1.forward();
    //     }
    //   });

    // animation2 = _fillTween.animate(controller2)
    //   ..addListener(() {
    //     setState(() {});
    //   })
    //   ..addStatusListener((status) {
    //     if (status == AnimationStatus.completed) {
    //       controller2.reverse();
    //     } else if (status == AnimationStatus.dismissed) {
    //       controller2.forward();
    //     }
    //   });

    // controller1.forward();
    // controller2.forward();
  }

// @override
// void dispose() {
//   controller1.dispose();
//   // controller2.dispose();
//   super.dispose();
// }

}

class OpArtWavePainter extends CustomPainter {
  int seed;
  Random rnd;
  // double angle;
  // double fill;

  OpArtWavePainter(
      this.seed,
      this.rnd,
      // this.angle,
      // this.fill
      );

  @override
  void paint(Canvas canvas, Size size) {
    rnd = Random(seed);
    print('seed: $seed');

    print('----------------------------------------------------------------');
    print('Wave');
    print('----------------------------------------------------------------');


    // Initialise the palette
    if (currentWave == null) {
      currentWave = new Wave(random: rnd);
      currentWave.defaultSettings();
      currentNamedPalette = currentWave.paletteList.value;
    }
    if (currentNamedPalette != null && currentWave.paletteList.value != currentNamedPalette) {
      // find the index of the palette in the list
      List newPalette = palettes.firstWhere((palette) => palette[0]==currentWave.paletteList.value);
      // set the palette details
      currentWave.numberOfColours.value = newPalette[1].toInt();
      currentWave.backgroundColour.value = Color(int.parse(newPalette[2]));
      currentWave.palette = [];
      for (int z = 0; z < currentWave.numberOfColours.value; z++){
        currentWave.palette.add(Color(int.parse(newPalette[3][z])));
      }
      currentNamedPalette = currentWave.paletteList.value;
    } else if (currentWave.numberOfColours.value >
        currentWave.palette.length) {
        currentWave.randomizePalette();
    }


    if (currentWave == null) {
      currentWave = new Wave(random: rnd);
      currentWave.defaultSettings();
    }

    if (currentWave.numberOfColours.value>currentWave.palette.length){
      currentWave.randomizePalette();
    }

    double canvasWidth = size.width;
    double canvasHeight = size.height;
    print('canvasWidth: $canvasWidth');
    print('canvasHeight: $canvasHeight');
    print('canvasWidth / canvasHeight = ${canvasWidth / canvasHeight}');

    double borderX = 0;
    double borderY = 0;
    double imageWidth = canvasWidth;
    double imageHeight = canvasHeight;

    // if (currentWave.aspectRatio == pi/2){
    currentWave.aspectRatio = canvasWidth / canvasHeight;
    // }

    if (canvasWidth / canvasHeight < currentWave.aspectRatio) {
      borderY = (canvasHeight - canvasWidth / currentWave.aspectRatio) / 2;
      imageHeight = imageWidth / currentWave.aspectRatio;
    } else {
      borderX = (canvasWidth - canvasHeight * currentWave.aspectRatio) / 2;
      imageWidth = imageHeight * currentWave.aspectRatio;
    }


    print('aspectRatio = $currentWave.aspectRatio');
    print('imageWidth = $imageWidth');
    print('imageHeight = $imageHeight');
    print('borderX = $borderX');
    print('borderY = $borderY');

    print('numberOfColours: ${currentWave.numberOfColours}');
    print('opacity: ${currentWave.opacity}');
    print('paletteType: ${currentWave.paletteType}');
    print('randomColours: ${currentWave.randomColours}');

    int colourOrder = 0;

    // Now make some art

    generateWave(
      canvas,
      canvasWidth,
      canvasHeight,
      imageWidth,
      imageHeight,
      borderX,
      borderY,

      // angle, //currentWave.angleIncrement,
      currentWave.stepX.value,
      currentWave.stepY.value,
      currentWave.frequency.value,
      currentWave.amplitude.value,
      currentWave.backgroundColour.value,
      currentWave.randomColours.value,
      currentWave.numberOfColours.value,
      currentWave.paletteType.value,
      currentWave.opacity.value,
      currentWave.palette,
    );
  }

  generateWave(
      Canvas canvas,
      double canvasWidth,
      double canvasHeight,
      double imageWidth,
      double imageHeight,
      double borderX,
      double borderY,

      double currentStepX,
      double currentStepY,
      double currentFrequency,
      double currentAmplitude,
      Color currentBackgroundColour,
      bool currentRandomColours,
      int currentNumberOfColours,
      String currentPaletteType,
      double currentOpacity,
      List currentPalette,
      ) {

    int colourOrder = 0;


    // colour in the canvas
    //a rectangle
    canvas.drawRect(
        Offset(borderX, borderY) & Size(imageWidth, imageHeight * 2),
        Paint()
          ..color = currentBackgroundColour
          ..style = PaintingStyle.fill);



    double offset = 1;
    double start = 0 - currentAmplitude;
    double end = imageWidth + currentStepX + currentAmplitude;

    for (double i = start; i < end; i+= currentStepX ) {

      Color waveColor;
      if (currentRandomColours){
        waveColor = currentPalette[rnd.nextInt(currentNumberOfColours)];
      }
      else
      {
        colourOrder++;
        waveColor = currentPalette[colourOrder%currentNumberOfColours];
      }

      // var paint1 = Paint()
      //   ..color = waveColor
      //   ..style = PaintingStyle.fill;
      // canvas.drawRect(Offset(borderX + i, borderY) & Size(stepX, imageHeight), paint1);

      Path wave = Path();

      double j;
      for (j = 0; j < imageHeight + currentStepY; j+=currentStepY) {
        var delta = currentAmplitude * sin(pi * 2 * (j / imageHeight * currentFrequency + offset * i / imageWidth));
        if (j==0){
          wave.moveTo(borderX + i + delta, borderY + j);
        }
        else{
          wave.lineTo(borderX + i + delta, borderY + j);
        }
      }
      for (double k = j; k >= -currentStepY; k-=currentStepY) {
        var delta = currentAmplitude * sin(pi * 2 * (k / imageHeight * currentFrequency + offset * (i+currentStepX) / imageWidth));
        wave.lineTo(borderX + i + currentStepX + delta, borderY + k);
      }


//      wave.lineTo(borderX + imageWidth, borderY + imageHeight);
      wave.close();

      canvas.drawPath(
          wave,
          Paint()
            ..style = PaintingStyle.fill
            ..color = waveColor);

    }



    // colour in the outer canvas
    var paint1 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset(0, 0) & Size(borderX, canvasHeight), paint1);
    canvas.drawRect(
        Offset(canvasWidth - borderX, 0) & Size(borderX, canvasHeight), paint1);

    canvas.drawRect(Offset(0, 0) & Size(canvasWidth, borderY), paint1);
    canvas.drawRect(
        Offset(
          0,
          canvasHeight - borderY,
        ) &
        Size(canvasWidth, borderY + canvasHeight * 2),
        paint1);
  }
  @override
  bool shouldRepaint(OpArtWavePainter oldDelegate) => false;
}
