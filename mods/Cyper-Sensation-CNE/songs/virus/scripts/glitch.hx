import openfl.filters.ShaderFilter;
var iLikeToMoveItMoveIt:CustomShader;
var virusShader:CustomShader;
var time:Float = 0;
var noteVelocity:Float = 0;
var zoomar:Bool = false;
var supersuperZoomShit:Bool = false;
var virusShaderEnabled:Bool = false;
var wasDownscroll:Bool = false;
// swinging my pickaxe from
var side:Bool = false;

function postCreate() {
    iLikeToMoveItMoveIt = new CustomShader('i like to move it move it');
    virusShader = new CustomShader('virus');
    virusShader.uEnabled = false;
    virusShader.screenSize = [1280, 720];
    virusShader.colorMultiplier = 1;
    virusShader.colorTransform = true;

    addGameShader(virusShader);
    wasDownscroll = downscroll;

    for(sl in strumLines.members)
        sl.onNoteUpdate.add(updateNote);
    //camHUD.addShader(iLikeToMoveItMoveIt);
    
}

function update(elapsed) {
    time += elapsed;

    virusShader.time = time;
    virusShader.uEnabled = virusShaderEnabled;
    if (virusShaderEnabled)
        noteVelocity = lerp(noteVelocity, 0, 0.125);
    if (curBeatFloat >= 304 && curBeatFloat <= 432) {
        iLikeToMoveItMoveIt.offset = [(Std.int(curBeatFloat) + FlxEase.cubeOut(curBeatFloat % 1)) * 0.5 * (side ? -1 : 1), 0];
    }

    if (curBeatFloat < 304) {
        iLikeToMoveItMoveIt.ratio = 1-FlxEase.cubeIn(FlxMath.bound((304 - curBeatFloat) / 2, 0, 1));
    } else {
        iLikeToMoveItMoveIt.ratio = 1-FlxEase.cubeOut(FlxMath.bound((curBeatFloat - 432) / 2, 0, 1));
    }
}

function updateNote(event) {
    if (virusShaderEnabled) {
        event.cancelPositionUpdate();
        event.note.y += 1000 * (0.45 * scrollSpeed) * FlxG.elapsed * noteVelocity;
    }
}

function stepHit(curStep) {
    switch (curStep)
    {
        case 1246, 1279, 1310, 1339, 1350, 1359, 1367, 1383, 1391, 1399, 1415, 1423, 1431, 1447, 1502, 1534, 1567, 1594, 1630, 1660, 1694, 1725, 1853, 2044:
            virusShaderEnabled = true;
            side = !side;
            noteVelocity = 1;
        case 1248, 1281, 1312, 1341, 1352, 1361, 1369, 1385, 1393, 1401, 1417, 1425, 1433, 1449, 1504, 1537, 1569, 1596, 1633, 1663, 1697, 1728, 1856, 2049:
            virusShaderEnabled = false;
            // if (FlxG.random.bool(200/3))
            //     downscroll = !downscroll;
        case 1456:
            virusShaderEnabled = false;
            downscroll = wasDownscroll;
        case 1215:
            camZoomingInterval = 1;
        case 1727:
            camZoomingInterval = 4;
        case 2236:
            camHUD.fade(0xFF000000, Conductor.crochet / 500, false);
    }
}

function addGameShader(shader:FlxShader)
    {
        var filter:ShaderFilter = null;
        if (FlxG.game._filters == null)
            FlxG.game._filters = [];
        FlxG.game._filters.push(filter = new ShaderFilter(shader));
        return filter;
    }
    function destroy() FlxG.game.setFilters([]);