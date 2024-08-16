public var superZoomShit:Bool = false;
public var supersuperZoomShit:Bool = false;
public var zoomar:Bool = false;

function postCreate() {
    if (FlxG.save.data.MiddleScroll) {
    // Player MiddleScroll
        // Tans
        strumLines.members[1].members[0].setPosition(420,50);
        strumLines.members[1].members[1].setPosition(526,50);
        strumLines.members[1].members[2].setPosition(630,50);
        strumLines.members[1].members[3].setPosition(736,50);
        // TaeYai
        strumLines.members[2].members[0].setPosition(420,50);
        strumLines.members[2].members[1].setPosition(526,50);
        strumLines.members[2].members[2].setPosition(630,50);
        strumLines.members[2].members[3].setPosition(736,50);
    
    // Opponent MiddleScroll
        // TaeYai Remixer
        strumLines.members[0].members[0].setPosition(80,50);
        strumLines.members[0].members[1].setPosition(186,50);
        strumLines.members[0].members[2].setPosition(965,50);
        strumLines.members[0].members[3].setPosition(1071,50);
        // Soft TeaYai
        strumLines.members[3].members[0].setPosition(80,50);
        strumLines.members[3].members[1].setPosition(186,50);
        strumLines.members[3].members[2].setPosition(965,50);
        strumLines.members[3].members[3].setPosition(1071,50);
    
    // Alpha
    for(s in strumLines.members[3].members) 
            {
                    s.alpha = 0.7;
            }
    for(s in strumLines.members[0].members) 
            {
                    s.alpha = 0.7;
            }
    // end
    }
}

function onSongStart()
    {
        zoomar = true;
        camZooming = true;
    }

    function onCountdown(event)
        {
            if(event.swagCounter == 3)
                {
                    for(s in strumLines.members[0]) {
                        FlxTween.tween(s, {x:s.x + FlxG.width},  0.001, {ease: FlxEase.expoOut});
                    }
                
                    for(s in strumLines.members[1]) {
                        FlxTween.tween(s, {x:s.x - FlxG.width},  0.001, {ease: FlxEase.expoOut});
                    }
                }
        }

function stepHit()
{
    switch(curStep)
    {
        case 112:
            zoomar = camZooming = false;
        case 128:
            camGame.flash(FlxColor.WHITE, 0.5);
            zoomar = camZooming = true;
        case 240:
            defaultCamZoom = 0.9;
        case 248:
            zoomar = camZooming = false;
        case 260:
            camGame.flash(FlxColor.WHITE, 0.5);
            zoomar = camZooming = true;
            defaultCamZoom = 0.5;
        case 368:
            zoomar = camZooming = false;
            defaultCamZoom = 1;
        case 376:
            curCameraTarget = 4;
            for(s in strumLines.members[4]) {
                FlxTween.tween(s, {alpha:1},  1, {ease: FlxEase.expoOut});
            }

            FlxTween.tween(strumLines.members[4].characters[0], {y:260},  1, {ease: FlxEase.expoOut});
        case 384:
            defaultCamZoom = 1;
            camGame.flash(FlxColor.WHITE, 0.5);
            zoomar = camZooming = true;
        case 448:
            defaultCamZoom = 1;
        case 496:
            zoomar = camZooming = false;
            defaultCamZoom = 1.1;
        case 516:
            defaultCamZoom = 0.5;
            camGame.flash(FlxColor.WHITE, 0.5);
            zoomar = camZooming = true;
        case 624:
            zoomar = camZooming = false;
            defaultCamZoom = 1.1;
        case 640:
            defaultCamZoom = 0.5;
            camGame.flash(FlxColor.WHITE, 0.5);
            zoomar = camZooming = true;
        case 752:
            zoomar = camZooming = false;
            defaultCamZoom = 1.1;
            FlxTween.tween(strumLines.members[4].characters[0], {y:strumLines.members[4].characters[0].y + 900},  1, {ease: FlxEase.expoOut});
        case 764:
            defaultCamZoom = 0.8;
            camGame.flash(FlxColor.WHITE, 0.5);
            shiver.visible = true;
            camZooming = true;
            shiver.y -= 1100;
            FlxTween.tween(shiver, {y:shiver.y + 1100},  1, {ease: FlxEase.expoOut});
        case 888:
            FlxTween.tween(shiver, {y:shiver.y - 1100},  1, {ease: FlxEase.expoOut});
            FlxTween.tween(strumLines.members[4].characters[0], {y:strumLines.members[4].characters[0].y - 900},  1, {ease: FlxEase.expoOut});
        case 896:
            camGame.flash(FlxColor.WHITE, 0.5);
        case 928:
            defaultCamZoom = 0.5;
            zoomar = true;
        case 1008:
            defaultCamZoom = 0.9;
            zoomar = camZooming = false;
        case 1028:
            camGame.flash(FlxColor.WHITE, 0.5);
            defaultCamZoom = 0.5;
            zoomar = camZooming = true;
        case 1152:
            camGame.flash(FlxColor.WHITE, 0.5);
            defaultCamZoom = 0.9;
        case 1276:
            defaultCamZoom = 0.5;
        case 1280:
            camGame.flash(FlxColor.WHITE, 0.5);

    }
}

function beatHit()
    {

        if (curBeat % 2 == 0 && superZoomShit)
            {
                FlxG.camera.zoom += 0.03;
                camHUD.zoom += 0.06;
                
            }
        if (curBeat % 1 == 0 && superZoomShit)
            {
                FlxG.camera.zoom += 0.04;
                camHUD.zoom += 0.07;
            }
    
            if (curBeat % 1 == 0 && supersuperZoomShit)
            {
                FlxG.camera.zoom += 0.06;
                camHUD.zoom += 0.08;
            }
        if (curBeat % 2 == 0 && zoomar)
            {
                FlxG.camera.zoom += 0.010;
                camHUD.zoom += 0.02;
            }
        if (curBeat % 1 == 0 && zoomar)
            {
                FlxG.camera.zoom += 0.015;
                camHUD.zoom += 0.03;
            }
    } 

