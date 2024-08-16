import flixel.addons.util.FlxSimplex;
public var superZoomShit:Bool = false;
public var zoomar:Bool = false;
public var wing:Bool = false;
var camTween:FlxTween;
var done:Bool = false;
var multi:Float = 0.0;
function postCreate()
    {
        camGame.zoom = 2;
        camZooming = false;
        
        var index = members.indexOf(boyfriend);
        eventbackground = new FlxSprite(0,0).makeGraphic(1280,720, 0xFF000000);
        eventbackground.alpha = 1;
        eventbackground.updateHitbox();
        eventbackground.scale.set(4,4);
        eventbackground.screenCenter(FlxAxes.X);
        eventbackground.scrollFactor.set();
        insert(index, eventbackground);

        dad.alpha = boyfriend.alpha = 0;

        camNewHUD.alpha  = 0;

        //Shader
        blur = new CustomShader("radialBlur");
        blur.cx =  0.5;
        blur.cy =  0.5;
        blur.blurWidth = 0.0;
        camGame.addShader(blur);
        camHUD.addShader(blur);
        camNewHUD.addShader(blur);
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

function hardbump()
    {
        FlxG.camera.zoom += 0.03;
        camHUD.zoom += 0.06;
        multi+= 0.05;
    }
    
function bump()
{
        FlxG.camera.zoom += 0.04;
        camHUD.zoom += 0.07;
}

function update(elapsed:Float)
{

    multi = lerp(multi,0.0,0.125);
    blur.blurWidth = multi;


}
function onSongStart() 
{
        FlxTween.tween(dad, {alpha: 1},10, {ease: FlxEase.cubeIn});
        FlxTween.tween(boyfriend, {alpha: 1},10, {ease: FlxEase.cubeIn});
        FlxTween.tween(eventbackground,{alpha:0},8,{ease: FlxEase.cubeIn});
        FlxTween.tween(FlxG.camera, {zoom: 0.8},15, {ease: FlxEase.backInOut});
}

function stepHit()
{
    switch (curStep)
    {
        case 128:
        FlxTween.tween(camHUD, {alpha: 1}, 1, {ease: FlxEase.cubeIn});
        FlxTween.tween(camNewHUD, {alpha:1},1, {ease: FlxEase.cubeIn});
        FlxTween.tween(FlxG.camera, {zoom: 0.6},5, {ease: FlxEase.backInOut});
        for(s in strumLines.members[0]) {
            FlxTween.tween(s, {x:s.x + FlxG.width}, 1.5, {ease: FlxEase.expoOut});
        }
    
        for(s in strumLines.members[1]) {
            FlxTween.tween(s, {x:s.x - FlxG.width}, 1.5, {ease: FlxEase.expoOut});
        }
        case 256:
            FlxTween.tween(FlxG.camera, {zoom: 1},5, {ease: FlxEase.backIn});
        case 320:
            FlxTween.tween(FlxG.camera, {zoom: 0.6},5, {ease: FlxEase.backIn});
        case 376:
            FlxTween.tween(FlxG.camera, {zoom: 0.8},0.3, {ease: FlxEase.expoOut});
        case 380:
            FlxTween.tween(camGame, {angle: 10},0.3, {ease: FlxEase.expoOut});
            FlxTween.tween(FlxG.camera, {zoom: 1},0.3, {ease: FlxEase.expoOut});
        case 384:
            FlxTween.tween(FlxG.camera, {zoom: 0.8},5, {ease: FlxEase.backIn});
            FlxTween.tween(camGame, {angle: -10},5, {ease: FlxEase.expoOut});
            camZooming = true;
            zoomar = true;
        case 448:
            FlxTween.tween(FlxG.camera, {zoom: 1},5, {ease: FlxEase.backInOut});
            FlxTween.tween(camGame, {angle: 10},5, {ease: FlxEase.backInOut});
        case 512:
            FlxTween.tween(FlxG.camera, {zoom: 0.8},5, {ease: FlxEase.backInOut});
            FlxTween.tween(camGame, {angle: -10},5, {ease: FlxEase.backInOut});
        case 576:
            FlxTween.tween(FlxG.camera, {zoom: 1},5, {ease: FlxEase.backInOut});
            FlxTween.tween(camGame, {angle: 0},5, {ease: FlxEase.backInOut});
        case 632:
            camZooming = false;
            zoomar = false;
            FlxTween.tween(FlxG.camera, {zoom: 0.8},0.3, {ease: FlxEase.expoOut});
        case 636:
            FlxTween.tween(FlxG.camera, {zoom: 1},0.3, {ease: FlxEase.expoOut});
        case 640:
            camHUD.flash(FlxColor.WHITE, 0.5);
            camZooming = true;
            FlxTween.tween(FlxG.camera, {zoom: 0.8},0.3, {ease: FlxEase.expoOut});
        case 896:
            camHUD.flash(FlxColor.WHITE, 0.5);
            camZooming = false;
            FlxTween.tween(FlxG.camera, {zoom: 1},1, {ease: FlxEase.expoOut});
        case 928:
            FlxTween.tween(FlxG.camera, {zoom: 0.8},7, {ease: FlxEase.backInOut});
        case 959:
            FlxTween.tween(FlxG.camera, {zoom: 1},7, {ease: FlxEase.backInOut});
        case 992:
            FlxTween.tween(FlxG.camera, {zoom: 0.6},7, {ease: FlxEase.backInOut});    
            FlxG.camera.followLerp = 0.01;
        case 1024:
            FlxTween.tween(FlxG.camera, {zoom: 0.8},7, {ease: FlxEase.backInOut});
        case 1056:
            FlxTween.tween(FlxG.camera, {zoom: 0.9},1, {ease: FlxEase.expoOut});
        case 1071:
            FlxTween.tween(FlxG.camera, {zoom: 0.6},1, {ease: FlxEase.expoOut});
        case 1088:
            FlxTween.tween(FlxG.camera, {zoom: 0.9},7, {ease: FlxEase.backInOut});
        case 1120:
            FlxTween.tween(FlxG.camera, {zoom: 0.6},7, {ease: FlxEase.backInOut});
        case 1152:
            FlxTween.tween(FlxG.camera, {zoom: 0.8},5, {ease: FlxEase.backIn});
            FlxTween.tween(camGame, {angle: -10},5, {ease: FlxEase.expoOut});
            camZooming = true;
            zoomar = true;
        case 1215:
            FlxTween.tween(FlxG.camera, {zoom: 1},5, {ease: FlxEase.backInOut});
            FlxTween.tween(camGame, {angle: 10},5, {ease: FlxEase.backInOut});
        case 1280:
            FlxTween.tween(FlxG.camera, {zoom: 0.8},5, {ease: FlxEase.backInOut});
            FlxTween.tween(camGame, {angle: -10},5, {ease: FlxEase.backInOut});
        case 1344:
            FlxTween.tween(FlxG.camera, {zoom: 1},5, {ease: FlxEase.backInOut});
            FlxTween.tween(camGame, {angle: 0},5, {ease: FlxEase.backInOut});
        case 1399:
            camZooming = false;
            zoomar = false;
            FlxTween.tween(FlxG.camera, {zoom: 0.8},0.3, {ease: FlxEase.expoOut});
        case 1404:
            FlxTween.tween(FlxG.camera, {zoom: 1},0.3, {ease: FlxEase.expoOut});
        case 1408:
            camHUD.flash(FlxColor.WHITE, 0.5);
            camZooming = true;
            superZoomShit = true;
            FlxTween.tween(FlxG.camera, {zoom: 0.8},0.3, {ease: FlxEase.expoOut});
            FlxG.camera.followLerp = 0.04;
        case 1664:
            camHUD.flash(FlxColor.WHITE, 0.5);
            camZooming = false;
            superZoomShit = false;
            FlxTween.tween(FlxG.camera, {zoom: 1},1, {ease: FlxEase.expoOut});
            
            
    }
   
}

function onNoteHit(event)
    {
        event.enableCamZooming = false;
    }

function beatHit()
    {

            if (curBeat % 2 == 0 && superZoomShit)
                {
                    FlxG.camera.zoom += 0.03;
                    camHUD.zoom += 0.06;
                    multi+= 0.05;
                    
                }
            if (curBeat % 1 == 0 && superZoomShit)
                {
                    FlxG.camera.zoom += 0.04;
                    camHUD.zoom += 0.07;
                    multi+= 0.1;

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