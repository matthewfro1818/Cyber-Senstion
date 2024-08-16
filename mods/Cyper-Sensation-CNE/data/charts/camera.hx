import flixel.FlxObject;

public var cameraMovementStrength = 4;
public var cameraMovementEnabled=false;

public var smoothCamFollow:FlxObject = new FlxObject(0, 0, 2, 2);

function postCreate() {
    add(smoothCamFollow);
    FlxG.camera.target = smoothCamFollow;
    trace(cameraMovementEnabled);
}
function update(elapsed:Float) {
    smoothCamFollow.x = lerp(smoothCamFollow.x, camFollow.x, 0.1 + (0.9 * Math.pow(FlxMath.bound((smoothCamFollow.x - camFollow.x) / FlxG.width, 0, 1), 1)));
    smoothCamFollow.y = lerp(smoothCamFollow.y, camFollow.y, 0.1 + (0.9 * Math.pow(FlxMath.bound((smoothCamFollow.y - camFollow.y) / FlxG.height, 0, 1), 1)));
    smoothCamFollow.angle = lerp(smoothCamFollow.angle, camFollow.angle, 0.1 + (0.9 * Math.pow(FlxMath.bound((smoothCamFollow.angle - camFollow.angle) / FlxG.width, 0, 1), 1)));
}

function postUpdate(elapsed:Float){
    if(!cameraMovementEnabled) return;

    for (i in strumLines.members[curCameraTarget].characters) {
        smoothCamFollow.x += i.getAnimName() == "singRIGHT" ? cameraMovementStrength : i.getAnimName() == "singLEFT" ? -cameraMovementStrength : 0;
        smoothCamFollow.y += i.getAnimName() == "singDOWN" ? cameraMovementStrength : i.getAnimName() == "singUP" ? -cameraMovementStrength : 0;
        smoothCamFollow.angle += i.getAnimName() == "singRIGHT" ? cameraMovementStrength : i.getAnimName() == "singLEFT" ? -cameraMovementStrength : 0;
        
    }
}