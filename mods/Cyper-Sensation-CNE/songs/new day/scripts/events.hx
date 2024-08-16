function postCreate()
{
    camZooming = false;
    var index = members.indexOf(boyfriend);
    eventbackground = new FlxSprite(0,0).makeGraphic(1280,720, 0xFF000000);
    eventbackground.alpha = 0;
    eventbackground.updateHitbox();
    eventbackground.scale.set(4,4);
    eventbackground.screenCenter(FlxAxes.X);
    eventbackground.scrollFactor.set();
    insert(index, eventbackground);
}

function onNoteHit(event)
    {
        event.enableCamZooming = false;
    }

function stepHit()
    {
        switch(curStep)
        {
            case 20:
                FlxTween.tween(camGame, {zoom: 1},1, {ease: FlxEase.backInOut});
            case 67:
                FlxTween.tween(camGame, {zoom: 0.7},1, {ease: FlxEase.expoInOut});
                FlxG.camera.followLerp = 999999999;
            case 144:
                FlxTween.tween(camGame, {zoom: 1},1, {ease: FlxEase.backInOut});
                FlxG.camera.followLerp = 0.02;
            case 207:
                FlxTween.tween(camGame, {zoom: 0.8},1, {ease: FlxEase.expoInOut});
            case 272:
                FlxTween.tween(camGame, {zoom: 1},1, {ease: FlxEase.expoOut});
                FlxG.camera.followLerp = 999999999;
            case 400:
                FlxTween.tween(camGame, {zoom: 0.8},1, {ease: FlxEase.expoInOut});
            case 528:
                FlxG.camera.followLerp = 0.02;
            case 652:
                FlxG.camera.followLerp = 1;
            case 656:
                FlxG.camera.followLerp = 0.04;
                camHUD.flash(FlxColor.WHITE, 0.5);
                FlxTween.tween(camGame, {zoom: 0.9},1, {ease: FlxEase.expoInOut});
            case 912,1423:
                FlxG.camera.followLerp = 1;
                FlxTween.tween(camGame, {zoom: 1},1, {ease: FlxEase.expoOut});
                FlxTween.tween(eventbackground, {alpha: 0.8},1, {ease: FlxEase.expoInOut});
            case 1168,1440:
                camHUD.flash(FlxColor.WHITE, 0.5);
                eventbackground.alpha = 0;
                FlxTween.tween(camGame, {zoom: 0.7},1, {ease: FlxEase.expoOut});
            case 1198,1296:
                FlxTween.tween(camGame, {zoom: 1},1, {ease: FlxEase.expoOut});
            case 1231,1360:
                FlxTween.tween(camGame, {zoom: 0.9},1, {ease: FlxEase.expoOut});
            case 1326:
                FlxTween.tween(camGame, {zoom: 0.7},1, {ease: FlxEase.expoOut});
            case 1691:
                FlxG.camera.followLerp = 999999999;
            case 1729:
                camHUD.flash(FlxColor.WHITE, 0.5);
            
        }
    }