public var superZoomShit:Bool = false;
public var supersuperZoomShit:Bool = false;
public var zoomar:Bool = false;
function postCreate()
    {
        var index = members.indexOf(dad);
        eventbackground = new FlxSprite(0,0).makeGraphic(1280,720, 0xFF000000);
        eventbackground.alpha = 0;
        eventbackground.updateHitbox();
        eventbackground.scale.set(4,4);
        eventbackground.screenCenter(FlxAxes.X);
        eventbackground.scrollFactor.set();
        insert(index, eventbackground);

        eventbackground2 = new FlxSprite(200,-200).makeGraphic(1280,720, 0xFF000000);
        eventbackground2.alpha = 1;
        eventbackground2.updateHitbox();
        eventbackground2.scale.set(10,10);
        eventbackground2.cameras = [camRays];
        eventbackground2.screenCenter(FlxAxes.X);
        eventbackground2.scrollFactor.set(1,1);
        add(eventbackground2);

        camNewHUD.alpha  = camHUD.alpha = 0;

        camfx = new FlxCamera();
        camfx.bgColor = 0;
        FlxG.cameras.remove(camHUD, false);
        FlxG.cameras.remove(camNewHUD, false);
        FlxG.cameras.add(camfx, false);
        FlxG.cameras.add(camHUD, false);
        FlxG.cameras.add(camNewHUD, false);
        
        vignette=new FlxSprite().loadGraphic(Paths.image('stages/room/vignette'));
        vignette.screenCenter();
        vignette.cameras=[camfx];
        vignette.alpha=0;
        vignette.scrollFactor.set();
        add(vignette);
            

    }
function onNoteHit(event)
    {
        event.enableCamZooming = false;
    }
function onCountdown(event)
{
    event.volume = 0;
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
function bump()
    {
        FlxG.camera.zoom += 0.015;
        camHUD.zoom += 0.03;
    }        


function onSongStart()
    {
        FlxTween.tween(eventbackground2, {alpha:0}, 4, {ease: FlxEase.cubeIn});
    }

function stepHit()
{
    switch(curStep)
    {
        case 57:
             FlxTween.tween(camHUD, {alpha: 1}, 1, {ease: FlxEase.cubeIn});
                FlxTween.tween(camNewHUD, {alpha:1},1, {ease: FlxEase.cubeIn});
                for(s in strumLines.members[0]) {
                    FlxTween.tween(s, {x:s.x + FlxG.width}, 1.5, {ease: FlxEase.expoOut});
                }
            
                for(s in strumLines.members[1]) {
                    FlxTween.tween(s, {x:s.x - FlxG.width}, 1.5, {ease: FlxEase.expoOut});
                }
        case 384:
            camZooming = false;
            FlxTween.tween(camGame, {zoom: 1},1, {ease: FlxEase.backInOut});
        case 513:
            FlxTween.tween(camGame, {zoom: 0.7},1, {ease: FlxEase.backInOut});
        case 640:
            FlxTween.tween(camGame, {zoom: 0.4},1, {ease: FlxEase.backInOut});
            camZooming = true;
            camHUD.flash(FlxColor.WHITE, 0.5);
        case 896:
            camGame.alpha = camNoRays.alpha = 0;
            eventbackground2.alpha = 1;
        case 912:
            camHUD.flash(FlxColor.WHITE, 0.5);
            superZoomShit = true;
            camGame.alpha = camNoRays.alpha = 1;
            eventbackground2.alpha = 0;
            FlxG.camera.followLerp = 0.3;
        case 1424:
            superZoomShit = false;
            camZooming = false;
            FlxTween.tween(camGame, {zoom: 1},1, {ease: FlxEase.backInOut});
        case 1432:
            FlxG.camera.followLerp = 0.04;
        case 1551:
            FlxG.camera.followLerp = 0.3;
        case 1681:
            FlxG.camera.followLerp = 0.04;
            FlxTween.tween(camGame, {zoom: 0.7},1, {ease: FlxEase.backInOut});
            camZooming = supersuperZoomShit = true;
        case 1936:
            camHUD.flash(FlxColor.WHITE, 0.5);
            supersuperZoomShit = camZooming = false;
            FlxG.camera.followLerp = 0.3;
            FlxTween.tween(vignette, {alpha: 0.6},1, {ease: FlxEase.backInOut}); 
            FlxTween.tween(camGame, {zoom: 1},1, {ease: FlxEase.backInOut});
        case 2188:
            camGame.alpha = camNoRays.alpha = 0;
            eventbackground2.alpha = 1;
        case 2192:
            camHUD.flash(FlxColor.WHITE, 0.5);
            superZoomShit = camZooming = true;
            camGame.alpha = camNoRays.alpha = 1;
            eventbackground2.alpha = 0;
            FlxG.camera.followLerp = 0.3;
            FlxTween.tween(camGame, {zoom: 0.4},1, {ease: FlxEase.backInOut});
        case 2480:
            camZooming = superZoomShit = false;
            FlxTween.tween(camGame, {zoom: 1},1, {ease: FlxEase.backInOut});
            FlxTween.tween(eventbackground2, {alpha: 1},2, {ease: FlxEase.backOut});

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