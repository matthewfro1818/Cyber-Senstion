
var colorTransformShader:CustomShader;
var camLock:Bool = false;
function postCreate() {
	cameraMovementEnabled=false;
	colorTransformShader = new CustomShader("colorTransform");
	colorTransformShader.redMultiplier = 1;
	colorTransformShader.greenMultiplier = 1;
	colorTransformShader.blueMultiplier = 1;
	colorTransformShader.alphaMultiplier = 1;
	colorTransformShader.redOffset = 0;
	colorTransformShader.greenOffset = 0;
	colorTransformShader.blueOffset = 0;
	colorTransformShader.alphaOffset = 0;
	camGame.addShader(colorTransformShader);

    camLock = true;

    FlxG.camera.followLerp = 0;
    var index = members.indexOf(dad);
    black = new FlxSprite(-800, -800);
    black.makeGraphic(FlxG.width * 2.3, FlxG.width * 2.3, 0xFF000000);
    black.scrollFactor.set(0, 0);
    black.alpha = 0;
    insert(index, black);

    dad.cameraOffset.y -= 100;
    boyfriend.cameraOffset.y += 60;
}

function onCameraMove(event) {
    var char = event.ratio >= 0.5 ? boyfriend : dad;
    if(curCameraTarget >= 0.5) char = boyfriend;
    else char = dad;

    if(camLock)
        {
            if(char == dad)
            {
                    camFollow.setPosition(dad.getMidpoint().x, dad.getMidpoint().y - 100);
                    FlxG.camera.focusOn(camFollow.getPosition());
            }
            else if(char == boyfriend)
            {
                    camFollow.setPosition(boyfriend.getMidpoint().x, boyfriend.getMidpoint().y);
                    FlxG.camera.focusOn(camFollow.getPosition());
            }
            
        }
    
    
}


function postUpdate(elapsed) {
	if (curBeat == 64) {
		var mul:Float = 1 + ((1 - ((curBeatFloat / 1) % 1)) * (1/3));
		
		colorTransformShader.redMultiplier = mul;
		colorTransformShader.greenMultiplier = mul;
		colorTransformShader.blueMultiplier = mul;
	}
    else if( (curBeat >= 99 && curBeat <= 124) && curBeat %4 == 0 || curBeat == 72 || curBeat == 80 || curBeat == 88 || curBeat == 95 || curBeat == 120 || curBeat == 122 || curBeat == 124 || curBeat == 136 || curBeat == 144 || curBeat == 152 || curBeat == 168 || curBeat == 176 || curBeat == 184) 
    {
        var mul:Float = 1 + ((1 - ((curBeatFloat / 1) % 1)) * (1/3));
		
		colorTransformShader.redMultiplier = mul;
		colorTransformShader.greenMultiplier = mul;
		colorTransformShader.blueMultiplier = mul;

    }
    else {
		colorTransformShader.redMultiplier = 1;
		colorTransformShader.greenMultiplier = 1;
		colorTransformShader.blueMultiplier = 1;
	}
}

function beatHit()
{
    if(curBeat == 64 ||(curBeat >= 40 && curBeat <= 129) && curBeat %4 == 0 || curBeat == 72 || curBeat == 80 || curBeat == 88 || curBeat == 95 || curBeat == 120 || curBeat == 122 || curBeat == 124 || curBeat == 136 || curBeat == 144 || curBeat == 152 || curBeat == 168 || curBeat == 176 || curBeat == 184) 
        {
            FlxG.camera.zoom += 0.06;
            camHUD.zoom += 0.08;
    
        }

}

function stepHit()
{
    switch(curStep)
    {
        case 107:
            camLock = false;
            tween = FlxTween.tween(FlxG.camera, {zoom: 1}, 3, {ease: FlxEase.quadInOut});
            tween2 = FlxTween.tween(FlxG.camera, {angle: -5}, 3, {ease: FlxEase.quadInOut});
            FlxG.camera.followLerp = 0.04;
        case 127:
            tween.cancel();
            tween2.cancel();
            camHUD.flash(FlxColor.WHITE, 0.2);
            FlxG.camera.zoom = 0.8;
            FlxG.camera.angle = 0;
        case 256, 640:
            FlxG.camera.followLerp = 0;
            camLock = true;
            tween = FlxTween.tween(FlxG.camera, {zoom: 1}, 0.1, {ease: FlxEase.backInOut});
            tween2 = FlxTween.tween(black, {alpha: 0.3}, 0.4, {ease: FlxEase.backInOut});
        case 263, 647:
            camLock = false;
            tween = FlxTween.tween(FlxG.camera, {zoom: 0.8}, 0.1, {ease: FlxEase.backInOut});
            tween2.cancel();
            camHUD.flash(FlxColor.WHITE, 0.2);
            black.alpha = 0;
            FlxG.camera.zoom = 0.8;
            FlxG.camera.angle = 0;
            FlxG.camera.followLerp = 0.04;
        case 383:
            camHUD.flash(FlxColor.WHITE, 0.2);
            camLock = true;
            FlxG.camera.followLerp = 0;
            FlxG.camera.zoom = 1;
        case 496:
            tween = FlxTween.tween(FlxG.camera, {zoom: 2}, 5, {ease: FlxEase.quadInOut});
            tween2 = FlxTween.tween(FlxG.camera, {angle: 10}, 5, {ease: FlxEase.quadInOut});
        case 513:
            tween.cancel();
            tween2.cancel();
            camHUD.flash(FlxColor.WHITE, 0.2);
            camLock = false;
            FlxG.camera.zoom = 0.8;
            FlxG.camera.angle = 0;
            FlxG.camera.followLerp = 0.04;
        case 768:
            camHUD.flash(FlxColor.WHITE, 0.2);
    }
}