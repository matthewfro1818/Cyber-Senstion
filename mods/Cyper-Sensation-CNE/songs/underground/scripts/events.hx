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

        camNewHUD.alpha  =  0;

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

function serious()
{
    FlxG.camera.followLerp = 0.02;
    defaultCamZoom = 1;
    FlxTween.tween(vignette, {alpha:1}, 1, {ease: FlxEase.expoOut});
}

function goback()
{
    FlxG.camera.followLerp = 0.04;
    defaultCamZoom = 0.4;
    FlxTween.tween(vignette, {alpha:0}, 1.3, {ease: FlxEase.cubeIn});
}

function stepHit()
{
    switch(curStep)
    {
        case 120:
             FlxTween.tween(camHUD, {alpha: 1}, 1, {ease: FlxEase.cubeIn});
                FlxTween.tween(camNewHUD, {alpha:1},1, {ease: FlxEase.cubeIn});
                for(s in strumLines.members[0]) {
                    FlxTween.tween(s, {x:s.x + FlxG.width}, 1.5, {ease: FlxEase.expoOut});
                }
            
                for(s in strumLines.members[1]) {
                    FlxTween.tween(s, {x:s.x - FlxG.width}, 1.5, {ease: FlxEase.expoOut});
                }
        case 504,874:
            FlxTween.tween(eventbackground2, {alpha:1}, 1, {ease: FlxEase.expoOut});
            FlxTween.tween(camGame, {zoom: 1.3},1, {ease: FlxEase.expoOut});
        case 512,880:
            FlxTween.tween(eventbackground2, {alpha:0}, 2, {ease: FlxEase.cubeIn});
            serious();
        case 612,1012:
            FlxTween.tween(eventbackground2, {alpha:1}, 1, {ease: FlxEase.cubeIn});
            FlxTween.tween(camGame, {zoom: 1.3},1, {ease: FlxEase.backInOut});
        case 624,1028:
            FlxTween.tween(eventbackground2, {alpha:0}, 1, {ease: FlxEase.cubeIn});
            goback();
        case 1688:
            eventbackground2.alpha = 1;
            camNewHUD.alpha  = camHUD.alpha =  0;
    }
}