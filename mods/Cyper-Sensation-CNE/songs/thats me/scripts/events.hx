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

        camfx = new FlxCamera();
        camfx.bgColor = 0;
        FlxG.cameras.remove(camHUD, false);
        FlxG.cameras.remove(camNewHUD, false);
        FlxG.cameras.add(camfx, false);
        FlxG.cameras.add(camHUD, false);
        FlxG.cameras.add(camNewHUD, false);
        

            
        bleh = new FlxSprite(0,0).loadGraphic(Paths.image('cat/cat'+FlxG.random.int(0,4)));
        bleh.scrollFactor.set(0, 0);
        bleh.alpha = 0;
        bleh.cameras = [camfx];
        bleh.setGraphicSize(FlxG.width, FlxG.height);
        bleh.screenCenter(FlxAxes.XY);
        add(bleh);
    }

function meow()
{
    remove(bleh);
    bleh = new FlxSprite(0,0).loadGraphic(Paths.image('cat/cat'+FlxG.random.int(0,4)));
    bleh.alpha = 1;
    bleh.setGraphicSize(FlxG.width, FlxG.height);
    bleh.screenCenter(FlxAxes.XY);
    bleh.cameras = [camfx];
    add(bleh);
    FlxTween.tween(bleh, {alpha: 0}, 1,{ease: FlxEase.quadInOut});
}


function bump()
    {
        FlxG.camera.zoom += 0.015;
        camHUD.zoom += 0.03;
    }   

function onSongStart() {
            dad.playAnim('thatme',true);
}

function stepHit()
{
    switch(curStep)
    {
        case 144:
            zoomar = true;
            camHUD.flash(FlxColor.WHITE, 0.5);
        case 264:
            zoomar = false;
        case 272:
            supersuperZoomShit = true;
            camHUD.flash(FlxColor.WHITE, 0.5);
        case 528:
            supersuperZoomShit = false;
            superZoomShit = true;
            camHUD.flash(FlxColor.WHITE, 0.5);
        case 652:
            superZoomShit = false;
        case 656:
            camHUD.flash(FlxColor.WHITE, 0.5);
        case 784:
            camZooming = false;
            FlxTween.tween(eventbackground, {alpha:0.7}, 1, {ease: FlxEase.expoInOut});
            FlxTween.tween(camGame, {zoom:1}, 1, {ease: FlxEase.expoInOut});
        case 912:
            camZooming = true;
        case 1168:
            camHUD.flash(FlxColor.WHITE, 0.5);
            eventbackground.alpha = 0;
            FlxTween.tween(camGame, {zoom:0.7}, 1, {ease: FlxEase.expoInOut});
            supersuperZoomShit = true;
        case 1296,1424,1552:
            camHUD.flash(FlxColor.WHITE, 0.5);
        case 1664:
            supersuperZoomShit = false;
        case 1680:
            superZoomShit = true;
            camHUD.flash(FlxColor.WHITE, 0.5);
        case 1800:
            camHUD.flash(FlxColor.WHITE, 0.5);
            superZoomShit = false;
            
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
