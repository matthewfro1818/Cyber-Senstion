import funkin.system.FunkinSprite;
import haxe.io.Path;

function create() {
    var i = members.indexOf(roombg2);
    trace(i);

    var positions = [
        [false, [671, 291], [1009, 316], [575, 538], [1002, 518]],
        [false, [330, 177], [634, 400], [170, 630], [601, 430]],
        [true, 1092, 301, 386, 233],
        [true, 1092, 531, 386, 233],
        [true, 1092, 770, 386, 233],
    ];

    var images = Paths.getFolderContent('images/stages/room/frames');
    for(pos in positions) {
        var spr = new FunkinSprite(roombg2.x, roombg2.y);
        spr.loadSprite(Paths.image('stages/room/frames/' + Path.withoutExtension(images[FlxG.random.int(0, images.length-1)])));
        spr.scrollFactor = roombg2.scrollFactor; // i love breaking flixel laws
        spr.antialiasing = true;

        if (pos[0]) {
            // resize technique
            spr.x += pos[1];
            spr.y += pos[2];
            spr.setGraphicSize(pos[3], pos[4]);
            spr.updateHitbox();
        } else {
            // shader 3d technique
            spr.shader = new CustomShader("room-shader");
            spr.shader.topLeft = pos[1];
            spr.shader.topRight = pos[2];
            spr.shader.bottomLeft = pos[3];
            spr.shader.bottomRight = pos[4];
            spr.shader.hologramSize = [roombg2.frameWidth, roombg2.frameHeight];
            spr.setGraphicSize(roombg2.width, roombg2.height);
            spr.updateHitbox();
        }
        insert(i, spr);
    }
}