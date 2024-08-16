if (PlayState.difficulty.toLowerCase() != "ex") return;
var zoomar:Bool = false;
function postCreate()
{
    camGame.zoom = 1;
    camGame.scroll.set(-100,-300);

    FlxG.camera.followLerp = 0;
    camFollow.setPosition(-100, -900);

    camNewHUD.alpha  = 0;

    var index = members.indexOf(boyfriend);
    eventbackground = new FlxSprite(0,0).makeGraphic(1280,720, 0xFF000000);
    eventbackground.alpha = 0;
    eventbackground.updateHitbox();
    eventbackground.scale.set(4,4);
    eventbackground.screenCenter(FlxAxes.X);
    eventbackground.scrollFactor.set();
    insert(index, eventbackground);

    camZooming = false;
}

function bump()
{
    FlxG.camera.zoom += 0.015;
    camHUD.zoom += 0.03;
}

function onCountdown(event) {
    event.volume = 0;
    if (event.swagCounter == 0)
        {
             FlxTween.tween(camGame, {zoom: 0.7}, 2, {ease: FlxEase.backInOut,
                onComplete: function(twn:FlxTween)
                {
                    start = true;
					camGame.zoom = 0.7;
					defaultCamZoom = 0.7;
                    FlxG.camera.followLerp = 0.003;

                }});



        }

        if(event.swagCounter == 3)
            {
                for(s in strumLines.members[0]) {
                    s.x -= FlxG.width;
                }
            
                for(s in strumLines.members[1]) {
                    s.x += FlxG.width;
                }
            }
   
}

function stepHit()
    {
        switch(curStep)
        {
            case 85:
                FlxG.camera.followLerp = 0.04;
            case 95:
                FlxTween.tween(camHUD, {alpha: 1}, 1, {ease: FlxEase.cubeIn});
                FlxTween.tween(camNewHUD, {alpha:1},1, {ease: FlxEase.cubeIn});
                for(s in strumLines.members[0]) {
                    FlxTween.tween(s, {x:s.x + FlxG.width}, 1.5, {ease: FlxEase.expoOut});
                }
            
                for(s in strumLines.members[1]) {
                    FlxTween.tween(s, {x:s.x - FlxG.width}, 1.5, {ease: FlxEase.expoOut});
                }
            case 128:
                zoomar = true;
                camZooming = true;
            case 240:
                camZooming = false;
                zoomar = false;
                FlxTween.tween(FlxG.camera, {zoom: 0.8},0.3, {ease: FlxEase.expoOut});
                FlxTween.tween(eventbackground, {alpha: 0.8},1, {ease: FlxEase.expoOut});
            case 254:
                FlxG.camera.followLerp = 1;
            case 256:
                FlxG.camera.followLerp = 0.04;
                camZooming = true;
                camHUD.flash(FlxColor.WHITE, 0.5);
                FlxTween.tween(FlxG.camera, {zoom: 0.7},0.3, {ease: FlxEase.expoOut});
                FlxTween.tween(eventbackground, {alpha: 0},0.3, {ease: FlxEase.expoOut});
            case 316,380,444:
                camZooming = false;
                zoomar = false;
                FlxTween.tween(FlxG.camera, {zoom: 0.8},0.3, {ease: FlxEase.expoOut});
                FlxTween.tween(eventbackground, {alpha: 0.8},0.3, {ease: FlxEase.expoOut});
                FlxG.camera.followLerp = 1;
            case 320,384,448:
                FlxG.camera.followLerp = 0.04;
                camZooming = true;
                camHUD.flash(FlxColor.WHITE, 0.5);
                FlxTween.tween(FlxG.camera, {zoom: 0.7},0.3, {ease: FlxEase.expoOut});
                FlxTween.tween(eventbackground, {alpha: 0},0.3, {ease: FlxEase.expoOut});
            case 504:
                camZooming = false;
                zoomar = false;
            case 512,560,608,672,736:
                FlxTween.tween(FlxG.camera, {zoom: 0.8},1, {ease: FlxEase.expoOut});
            case 542,623,688:
                FlxTween.tween(FlxG.camera, {zoom: 1},1, {ease: FlxEase.expoOut});
            case 576,640,704:
                FlxTween.tween(FlxG.camera, {zoom: 0.7},1, {ease: FlxEase.expoOut});
            case 751:
                FlxTween.tween(FlxG.camera, {zoom: 1},1, {ease: FlxEase.expoOut});
                FlxTween.tween(eventbackground, {alpha: 0.2},1, {ease: FlxEase.expoOut});
            case 763:
                FlxTween.tween(FlxG.camera, {zoom: 1.2},0.3, {ease: FlxEase.expoOut});
                FlxTween.tween(eventbackground, {alpha: 0.8},0.3, {ease: FlxEase.expoOut});
                FlxG.camera.followLerp = 1;
            case 768:
                FlxG.camera.followLerp = 0.04;
                camZooming = true;
                camHUD.flash(FlxColor.WHITE, 0.5);
                FlxTween.tween(FlxG.camera, {zoom: 0.7},0.3, {ease: FlxEase.expoOut});
                FlxTween.tween(eventbackground, {alpha: 0},0.3, {ease: FlxEase.expoOut});
            case 827,888:
                camZooming = false;
                FlxTween.tween(FlxG.camera, {zoom: 0.8},0.3, {ease: FlxEase.expoOut});
                FlxTween.tween(eventbackground, {alpha: 0.8},0.3, {ease: FlxEase.expoOut});
                FlxG.camera.followLerp = 1;
            case 831:
                FlxG.camera.followLerp = 0.04;
                camZooming = true;
                camHUD.flash(FlxColor.WHITE, 0.5);
                FlxTween.tween(FlxG.camera, {zoom: 0.7},0.3, {ease: FlxEase.expoOut});
                FlxTween.tween(eventbackground, {alpha: 0},0.3, {ease: FlxEase.expoOut});
            case 895,960:
                FlxG.camera.followLerp = 0.04;
                camZooming = true;
                zoomar = true;
                camHUD.flash(FlxColor.WHITE, 0.5);
                FlxTween.tween(FlxG.camera, {zoom: 0.7},0.3, {ease: FlxEase.expoOut});
                FlxTween.tween(eventbackground, {alpha: 0},0.3, {ease: FlxEase.expoOut});
            case 956:
                camZooming = zoomar = false;
                FlxTween.tween(FlxG.camera, {zoom: 0.8},0.3, {ease: FlxEase.expoOut});
                FlxTween.tween(eventbackground, {alpha: 0.8},0.3, {ease: FlxEase.expoOut});
                FlxG.camera.followLerp = 1;
            case 1023:
                camZooming = zoomar = false;
                FlxTween.tween(FlxG.camera, {zoom: 1},1, {ease: FlxEase.backIn});
            case 1035:
                camZooming = false;
                FlxTween.tween(FlxG.camera, {zoom: 1.2},0.3, {ease: FlxEase.expoOut});
                FlxTween.tween(eventbackground, {alpha: 0.8},0.3, {ease: FlxEase.expoOut});
                FlxG.camera.followLerp = 1;
            case 1040:
                FlxG.camera.followLerp = 0.04;
                camZooming = true;
                camHUD.flash(FlxColor.WHITE, 0.5);
                FlxTween.tween(FlxG.camera, {zoom: 0.7},0.3, {ease: FlxEase.expoOut});
                FlxTween.tween(eventbackground, {alpha: 0},0.3, {ease: FlxEase.expoOut});
            case 1083:
                camZooming = false;
                FlxTween.tween(FlxG.camera, {zoom: 1.2},0.3, {ease: FlxEase.expoOut});
                FlxTween.tween(eventbackground, {alpha: 0.8},0.3, {ease: FlxEase.expoOut});
                FlxG.camera.followLerp = 1;
            case 1087:
                FlxG.camera.followLerp = 0.04;
                camZooming = true;
                camHUD.flash(FlxColor.WHITE, 0.5);
                FlxTween.tween(FlxG.camera, {zoom: 0.7},0.3, {ease: FlxEase.expoOut});
                FlxTween.tween(eventbackground, {alpha: 0},0.3, {ease: FlxEase.expoOut});
            case 1151:
                camHUD.flash(FlxColor.WHITE, 0.5);
                camZooming = false;

        }
    }

function onNoteHit(event)
    {
        event.enableCamZooming = false;
    }

function beatHit()
    {

    
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