
if (PlayState.difficulty.toLowerCase() != "ex") return;
function beatHit(curBeat){
    switch(curBeat){        
        case 60:
            FlxG.camera.flash(FlxColor.WHITE, 0.7);
            cameraMovementEnabled=true;
            defaultCamZoom=0.8;
        case 56, 76, 140:defaultCamZoom=1;
        case 92:FlxG.camera.flash(FlxColor.WHITE, 0.7);defaultCamZoom=0.8;
        case 156:FlxG.camera.flash(FlxColor.WHITE, 0.7);defaultCamZoom=0.8;cameraMovementEnabled=false;
        case 204:defaultCamZoom=0.9;
        case 212:defaultCamZoom=0.95;
        case 220:defaultCamZoom=1.05;
        case 236:FlxG.camera.flash(FlxColor.WHITE, 0.7);
        //cameraMovementEnabled=true;
        case 252:FlxTween.tween(FlxG.camera, {zoom: 0.75}, 3.1);
    }
    if ((curBeat >= 60  && curBeat < 156) || (curBeat >=236 && curBeat<252) || (curBeat>=96 && curBeat<158)) {
        FlxG.camera.zoom += 0.015;
        camHUD.zoom += 0.03;
    }
}