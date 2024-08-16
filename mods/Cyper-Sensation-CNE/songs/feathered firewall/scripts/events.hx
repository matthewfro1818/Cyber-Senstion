public var superZoomShit:Bool = false;
public var zoomar:Bool = false;
public var wing:Bool = false;
var camTween:FlxTween;

function postCreate()
{
    camGame.zoom = 1.3;
    camGame.scroll.set(253,310);
    
    var index = members.indexOf(boyfriend);
    eventbackground = new FlxSprite(0,0).makeGraphic(1280,720, 0xFF000000);
    eventbackground.alpha = 0;
    eventbackground.updateHitbox();
    eventbackground.scale.set(4,4);
    eventbackground.screenCenter(FlxAxes.X);
    eventbackground.scrollFactor.set();
    insert(index, eventbackground);
}

function bump()
    {
        FlxG.camera.zoom += 0.04;
        camHUD.zoom += 0.07;
    }

function onSongStart() {

     FlxTween.tween(FlxG.camera, {zoom: 0.8},5, {ease: FlxEase.backInOut, onComplete: function() {
        camZooming = true;
    }});
}

function camZooms(what:Float, long:Float)
    {
    
        if(camTween != null)
            {
                camTween.cancel();
            }
    
        camTween = FlxTween.tween(FlxG.camera, {zoom: what},long, {ease: FlxEase.backInOut, onComplete: function() {
                camZooming = true;
        }});
    }
    
function postUpdate(elapsed) {
    camHUD.angle = lerp(camHUD.angle, 0, 0.125);
    camGame.angle = lerp(camGame.angle, 0, 0.125);
}
function stepHit()
{
    switch(curStep)
    {
        case 64:
            superZoomShit = true;
        case 112:
            superZoomShit = false;
        case 120:
            camZooming = false;
            FlxTween.tween(FlxG.camera, {zoom:2},0.6, {ease: FlxEase.backInOut, onComplete: function() {
                camZooming = true;
            }});
            boyfriend.cameraOffset.x += 150;
        case 128:
            camHUD.flash(FlxColor.WHITE, 0.5);
            superZoomShit = true;
            FlxTween.tween(FlxG.camera, {zoom: 0.8},1, {ease: FlxEase.backInOut, onComplete: function() {
                camZooming = true;
            }});
            boyfriend.cameraOffset.x -= 150;
        case 152,224:
            camZooms(1,0.6);
        case 160,241:
            camZooms(0.8,0.5);
        case 296:
            camZooms(1.3,0.3);
        case 300,360:
            camZooms(1,0.3);
        case 304,364:
            camZooms(0.8,2);
        case 320:
            camZooms(1.3,0.7);
        case 322:
            camZooms(0.8,2);
        case 376:
            camZooming = false;
            camZooms(2,0.6);
            superZoomShit = false;
            boyfriend.cameraOffset.x += 150;
        case 384:
            camHUD.flash(FlxColor.WHITE, 0.5);
            camZooms(0.8,2);
            boyfriend.cameraOffset.x -= 150;
        case 448:
            superZoomShit = true;
        case 512:
            camHUD.flash(FlxColor.WHITE, 0.5);
            wing = true;
        case 768:
            wing = false;
            superZoomShit = false;
            camHUD.flash(FlxColor.WHITE, 0.5);
        case 784:
            camHUD.flash(FlxColor.WHITE, 0.5);
            camZooms(1.3,0.7);
            zoomar = true;
        case 800:
            camZooms(0.8,0.7);
        case 816:
            camZooms(1,1);
        case 840:
            camZooms(2,1);
        case 856:
            camZooms(0.8,0.7);
        case 860,886:
            camZooms(1,0.7);
        case 880,896:
            camZooms(0.8,0.7);
        case 911:
            zoomar = false;
            camHUD.flash(FlxColor.WHITE, 0.5);
            superZoomShit = true;
        case 1030:
            superZoomShit = false;
            camZooms(2,1);
        case 1040:
            superZoomShit = true;
            camHUD.flash(FlxColor.WHITE, 0.5);
            camZooms(0.8,1);
            wing = true;
        case 1168,1297:
            camHUD.flash(FlxColor.WHITE, 0.5);
        case 1424:
            camHUD.flash(FlxColor.WHITE, 0.5);
            wing = false;
            superZoomShit = false;
            
            
    }
}

function beatHit()
{

    if(wing)
    {
        camHUD.angle = 2.5 * (curBeat % 2 == 0 ? 1 : -1);
        camGame.angle = 2.5 * (curBeat % 2 == 0 ? 1 : -1);
    }

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