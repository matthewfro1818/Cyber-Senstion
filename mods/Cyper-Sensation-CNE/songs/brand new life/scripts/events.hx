public var superZoomShit:Bool = false;
public var supersuperZoomShit:Bool = false;
public var zoomar:Bool = false;
function postCreate()
{
        var index = members.indexOf(boyfriend);
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

        eventwhite = new FlxSprite(0,0).makeGraphic(1280,720, 0xFFFFFFFF);
        eventwhite.alpha = 0;
        eventwhite.updateHitbox();
        eventwhite.scale.set(10,10);
        eventwhite.screenCenter(FlxAxes.X);
        eventwhite.scrollFactor.set();
        add(eventwhite);

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
        vignette.alpha=0.7;
        vignette.scrollFactor.set();
        add(vignette);

        camZooming = false;
        camGame.zoom = 1.3;
        dad.cameraOffset.x -= 50;
        dad.cameraOffset.y -= 50;

        boyfriend.cameraOffset.x -= 100;
        boyfriend.y -= 50;
            

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
        case 33:
            FlxTween.tween(camGame, {zoom: 1},1, {ease: FlxEase.backInOut});
        case 112:
            FlxTween.tween(camHUD, {alpha: 1}, 0.7, {ease: FlxEase.cubeIn});
               FlxTween.tween(camNewHUD, {alpha:1}, 0.7, {ease: FlxEase.cubeIn});
               for(s in strumLines.members[0]) {
                   FlxTween.tween(s, {x:s.x + FlxG.width},  0.7, {ease: FlxEase.expoOut});
               }
           
               for(s in strumLines.members[1]) {
                   FlxTween.tween(s, {x:s.x - FlxG.width},  0.7, {ease: FlxEase.expoOut});
               }
        case 256:
            camZooming = zoomar = true;
        case 499:
            camZooming = zoomar = false;
            FlxTween.tween(camGame, {zoom: 0.7},0.4, {ease: FlxEase.backInOut});
        case 512:
            camZooming = superZoomShit = true;
        case 1009:
            camZooming = superZoomShit = false;
            FlxTween.tween(camGame, {zoom: 1},0.4, {ease: FlxEase.backInOut});
        case 1024:
            camZooming = zoomar = true;
            FlxTween.tween(camGame, {zoom: 0.8},0.4, {ease: FlxEase.backInOut});
        case 1528:
            camZooming = zoomar = false;
            FlxTween.tween(camGame, {zoom: 1},0.4, {ease: FlxEase.backInOut});
            FlxG.camera.followLerp = 99;
        case 1536:
            FlxTween.tween(camGame, {zoom: 1.3},0.4, {ease: FlxEase.backInOut});
            FlxTween.tween(eventbackground, {alpha:0.8}, 0.7, {ease: FlxEase.expoOut});
        case 1540:
            camZooming = true;
        case 1772:
            camZooming = false;
            FlxTween.tween(camGame, {zoom: 2},0.4, {ease: FlxEase.backInOut});
            FlxTween.tween(eventbackground2, {alpha:1}, 0.7, {ease: FlxEase.expoOut});
        case 1792:
            FlxTween.tween(eventwhite, {alpha:1}, 1, {ease: FlxEase.backInOut});
        case 1808:
            camHUD.flash(FlxColor.WHITE, 0.5);
            camZooming = zoomar = true;
            FlxTween.tween(camGame, {zoom: 1},0.4, {ease: FlxEase.backInOut});
            eventbackground2.alpha = eventbackground.alpha = eventwhite.alpha = 0;
            FlxG.camera.followLerp = 0.04;

    }
}