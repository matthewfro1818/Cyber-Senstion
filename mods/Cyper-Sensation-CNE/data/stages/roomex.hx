import funkin.system.FunkinSprite;
import haxe.io.Path;

function create() {
    var i = members.indexOf(roombg);
    trace(i);

    var positions = [
        /*
        [uses shader, x, y, width, height, [top left], [top right], [bottom left], [bottom right]]
        */
        // LEFT SIDE
      // [true, 644, 282, 382, 272, [16, 2], [373, 29], [7, 263], [365, 242], 0],
      // [true, 652, 532, 367, 273, [2, 10], [354, 1], [5, 266], [362, 231], 0],
      // [true, 659, 784, 402, 298, [-5, 47], [353, 2], [46, 290], [381, 232], 0],
      // [true, 262, 184, 402, 405, [69, -15], [392, 97], [12, 399], [331, 356], 0],
      // [true, 277, 550, 327, 400, [4, 61], [321, 4], [15, 398], [318, 261], 0],
      // [true, 281, 821, 410, 440, [-25, 135], [307, -15], [98, 525], [500, 260], 0],
      // [true, -12, 46, 332, 610, [3, 11], [330, 121], [-12, 606], [250, 548], 0],
      // [true, -12, 622, 286, 538, [-10, 59], [244, 2], [4, 552], [274,337], 0],
      // [true, -381.8, -90.7, 311.45, 347.9, [1, 184], [264, -85], [73, 392], [450, 280], 0],

        // MIDDLE
      //  [false, 1092, 301, 386, 233],
        [false, 855, 409, 386, 233],
       // [false, 1092, 770, 386, 233],

        // RIGHT SIDE
      // [true, 1561, 290, 357, 252, [2, 25], [335, 2], [7, 232], [352, 249], 0],
      // [true, 1557, 529, 357, 277, [5, 2], [357, 17], [1, 237], [356, 273], 0],
      // [true, 1528, 781, 388, 300, [25, 4], [395, 51], [3, 234], [338, 295], 0],
      // [true, 1936, 189, 372, 407, [0, 83], [294, -20], [33, 356], [363, 397], 0],
      // [true, 1965, 549, 332, 413, [6, 5], [326, 68], [7, 264], [313, 400], 0],
      // [true, 1902, 842, 375, 402, [40, -32], [410, 139], [-15, 265], [285, 450], 0],
      // [true, 2260, 60, 300, 612, [-5, 100], [300, 3], [74, 533], [312, 589], 0],
      // [true, 2306, 602, 254, 540, [28, 21], [307, 80], [5, 363], [254, 524], 0],
      // [true, 2306, 602, 254, 540, [28, 21], [307, 80], [5, 363], [254, 524], 0],
      // [true, 2166, 982, 394, 372, [134, -65], [425, 183], [0, 210], [352, 363], 0],
    ];

    var easterEgg = FlxG.random.bool(1/4.2);
    var baseImages = [for(f in Paths.getFolderContent('images/stages/room/frames')) if (Path.extension(f).toLowerCase() == "png") Path.withoutExtension(f)];
    var images = [];
      var spr = new FunkinSprite(roombg.x, roombg.y);
      if (images.length <= 0)
          images = [for(i in baseImages) i];
      var curImg = images[FlxG.random.int(0, images.length-1)];
      images.remove(curImg);
      spr.loadSprite(easterEgg ? Paths.image('stages/room/putin') : Paths.image('stages/room/frames/' + curImg));
      spr.animation.add("idle", [for(i in 0...spr.frames.frames.length) i], 24, true);
      spr.animation.play("idle");
      spr.scrollFactor = roombg.scrollFactor; // i love breaking flixel laws
      spr.antialiasing = true;
      spr.setGraphicSize(FlxG.width *2,FlxG.height * 2);
      spr.updateHitbox();
      spr.screenCenter(FlxAxes.XY);
      insert(i, spr);
    
}