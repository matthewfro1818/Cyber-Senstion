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
        eventbackground2.screenCenter(FlxAxes.X);
        eventbackground2.scrollFactor.set(1,1);
        add(eventbackground2);

        camNewHUD.alpha = 0;

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
        vignette.alpha=0.7;
        vignette.scrollFactor.set();
        add(vignette);

        camZooming = false;
        camGame.zoom = 1.3;
        dad.cameraOffset.x -= 200;
        dad.cameraOffset.y += 200;
            

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

function stepHit()
{
    switch(curStep)
    {
        case 56:
            FlxTween.tween(camGame, {zoom: 1},1, {ease: FlxEase.backInOut});
        case 58:
            FlxTween.tween(camHUD, {alpha: 1}, 0.7, {ease: FlxEase.cubeIn});
               FlxTween.tween(camNewHUD, {alpha:1}, 0.7, {ease: FlxEase.cubeIn});
               for(s in strumLines.members[0]) {
                   FlxTween.tween(s, {x:s.x + FlxG.width},  0.7, {ease: FlxEase.expoOut});
               }
           
               for(s in strumLines.members[1]) {
                   FlxTween.tween(s, {x:s.x - FlxG.width},  0.7, {ease: FlxEase.expoOut});
               }
               
        case 65:
            FlxTween.tween(camGame, {zoom: 0.8},1, {ease: FlxEase.backInOut});
        case 120:
            FlxTween.tween(camGame, {zoom:1},0.5, {ease: FlxEase.backInOut});
        case 128:
            camHUD.flash(FlxColor.WHITE, 0.5);
            vignette.alpha = 0;
            FlxTween.tween(camGame, {zoom: 0.7},1, {ease: FlxEase.backInOut});
            camZooming = true;
            dad.cameraOffset.y -= 150;
            zoomar = true;
        case 256:
            camZooming = zoomar = false;
            FlxTween.tween(camGame, {zoom:1},0.5, {ease: FlxEase.backInOut});
        case 260:
            camHUD.flash(FlxColor.WHITE, 0.5);
            camZooming = zoomar = true;
            FlxTween.tween(camGame, {zoom: 0.7},1, {ease: FlxEase.backInOut});
        case 384:
            camHUD.flash(FlxColor.WHITE, 0.5);
            camZooming = zoomar = false;
            FlxTween.tween(camGame, {zoom: 0.7},1, {ease: FlxEase.backInOut});
            FlxTween.tween(eventbackground2, {alpha: 1},2, {ease: FlxEase.backOut});
        case 508:
            camZooming = zoomar = true;
            camHUD.flash(FlxColor.WHITE, 0.5);
            eventbackground2.alpha = 0;
        case 510:
            bump();
        case 575:
            FlxG.camera.followLerp = 99;
        case 632:
            FlxG.camera.followLerp = 0.04;
            camZooming = zoomar = false;
            FlxTween.tween(camGame, {zoom: 2},1, {ease: FlxEase.backInOut});
        case 644:
            camHUD.flash(FlxColor.WHITE, 0.5);
            FlxTween.tween(camGame, {zoom: 0.7},1, {ease: FlxEase.backInOut});
            camZooming = superZoomShit = true;
        case 768:
            camZooming = superZoomShit = false;
            FlxTween.tween(camGame, {zoom: 2},0.3, {ease: FlxEase.backInOut});
        case 772:
            FlxTween.tween(camGame, {zoom: 0.7},0.3, {ease: FlxEase.backInOut});
            camHUD.flash(FlxColor.WHITE, 0.5);
            camZooming = superZoomShit = true;
        case 896:
            camZooming = superZoomShit = false;
            FlxTween.tween(camGame, {zoom: 1},1, {ease: FlxEase.backInOut});
            FlxTween.tween(eventbackground2, {alpha: 1},2, {ease: FlxEase.backOut});

    }
}