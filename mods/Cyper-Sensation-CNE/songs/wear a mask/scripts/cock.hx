if (PlayState.difficulty.toLowerCase() != "regular") return;
var eventbackground:FlxSprite;
public var superZoomShit:Bool = false;
public var supersuperZoomShit:Bool = false;
public var zoomar:Bool = false;
var t:FlxTween;
function postCreate()
    {
        var index = members.indexOf(stage.characterPoses["boyfriend"].group);
        eventbackground = new FlxSprite(0,0).makeGraphic(1280,720, 0xFF000000);
        eventbackground.alpha = 0;
        eventbackground.updateHitbox();
        eventbackground.scale.set(4,4);
        eventbackground.screenCenter(FlxAxes.X);
        eventbackground.scrollFactor.set();
       // add(eventbackground);
        insert(index, eventbackground);

        trace('LOAD '  +eventbackground);

       // for(roombg in stage.stageSprites) {
         //   remove(roombg);
        //    roombg.destroy();
       // }

       camfx = new FlxCamera();
       camfx.bgColor = 0;
       FlxG.cameras.add(camfx, false);
    

       overlayfx = new FlxSprite(0,0).loadGraphic(Paths.image('fx'));
       overlayfx.scrollFactor.set(0, 0);
       overlayfx.alpha = 0;
       overlayfx.cameras = [camfx];
       overlayfx.setGraphicSize(FlxG.width * 1.2, FlxG.height * 1.2);
       overlayfx.screenCenter(FlxAxes.XY);
       add(overlayfx);

    }

    function flash()
        {
            if(t != null)
            {
                t.cancel();
            }
            overlayfx.alpha = 1;
            t = FlxTween.tween(overlayfx, {alpha: 0}, 0.5,{ease: FlxEase.quadInOut});
        }
function stepHit()
{
    switch(curStep)
    {
        case 276,280,284,340,344,348,404,408,413,468,472,476,788,792,796,852,856,860,916,920,924,980,984,988:
            flash();
        
        case 239:
            FlxTween.tween(FlxG.camera, {zoom: 0.9}, 0.5, {ease: FlxEase.quadInOut, onComplete: function(tween:FlxTween)
                {
                    defaultCamZoom=0.9;    
                }});
		case 251:
            FlxTween.tween(eventbackground, {alpha: 0.6}, 0.5);
            FlxTween.tween(FlxG.camera, {zoom: 1}, 0.5, {ease: FlxEase.quadInOut, onComplete: function(tween:FlxTween)
                {
                    defaultCamZoom=0.6;    
                }});
        case 256:
            camHUD.flash(FlxColor.WHITE, 0.5);
            FlxTween.tween(eventbackground, {alpha: 0}, 0.01);
        case 378,379,382:
            FlxG.camera.zoom += 0.09;
        case 504,505,507:
            FlxG.camera.zoom += 0.09;
        case 752:
            FlxTween.tween(FlxG.camera, {zoom: 0.9}, 1, {ease: FlxEase.quadInOut, onComplete: function(tween:FlxTween)
                {
                    defaultCamZoom=0.9;    
                }});
        case 764:
            FlxTween.tween(eventbackground, {alpha: 0.6}, 0.5);
            FlxTween.tween(FlxG.camera, {zoom: 1}, 0.5, {ease: FlxEase.quadInOut, onComplete: function(tween:FlxTween)
                {
                    defaultCamZoom=0.6;    
                }});
        case 768:
            camHUD.flash(FlxColor.WHITE, 0.5);
            FlxTween.cancelTweensOf(eventbackground);
            FlxTween.tween(eventbackground, {alpha: 0}, 0.01);
         case 890,892,894:
            FlxG.camera.zoom += 0.09;
    }
}

function beatHit(curBeat)
{
    switch(curBeat)
    {
        case 96: FlxG.camera.zoom += 0.09; supersuperZoomShit = true;
        case 125: supersuperZoomShit = false;
        case 127:defaultCamZoom=0.75; supersuperZoomShit = false;
        case 159:
            FlxTween.tween(FlxG.camera, {zoom: 0.85}, 0.5, {ease: FlxEase.quadInOut, onComplete: function(tween:FlxTween)
            {
                defaultCamZoom=0.85;    
            }});
        case 192:

            supersuperZoomShit = true;
        case 256:
            supersuperZoomShit = false;
            FlxTween.tween(FlxG.camera, {zoom: 1}, 2, {ease: FlxEase.quadInOut, onComplete: function(tween:FlxTween)
                {
                    defaultCamZoom=0.6;    
                }});
        case 260:
            camHUD.flash(FlxColor.WHITE, 0.5);
            supersuperZoomShit = true;
        case 272:
            supersuperZoomShit = false;

    }

    if (curBeat % 2 == 0 && superZoomShit)
        {
            FlxG.camera.zoom += 0.06;
            camHUD.zoom += 0.08;
        }

        if (curBeat % 1 == 0 && supersuperZoomShit)
        {
            FlxG.camera.zoom += 0.03;
            camHUD.zoom += 0.04;
        }
    if (curBeat % 4 == 0 && FlxG.camera.zoom < 1.35 && zoomar)
        {
            FlxG.camera.zoom += 0.015;
            camHUD.zoom += 0.03;
        }
}
