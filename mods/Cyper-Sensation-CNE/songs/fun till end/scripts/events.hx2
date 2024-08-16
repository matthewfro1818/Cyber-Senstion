public var superZoomShit:Bool = false;
public var supersuperZoomShit:Bool = false;
public var zoomar:Bool = false;
var  t:FlxTween;
var colortween:FlxTween;
var txtTween:FlxTween;
var heymoment:Bool = false;


function postCreate()
{
    var index = members.indexOf(boyfriend);
    eventbackground = new FlxSprite(0,0).makeGraphic(1280,720, 0xFF000000);
    eventbackground.alpha = 1;
    eventbackground.updateHitbox();
    eventbackground.scale.set(4,4);
    eventbackground.screenCenter(FlxAxes.X);
    eventbackground.scrollFactor.set();
    insert(index, eventbackground);

    camZooming = false;
    boyfriend.alpha = 0;

    camGame.zoom = 2;
    dad.cameraOffset.x -= 200;
    dad.cameraOffset.y -= 100;

    camNewHUD.alpha  = 0;

    eventbackground2 = new FlxSprite(dad.x,dad.y).makeGraphic(1280,720, 0xFF000000);
    eventbackground2.alpha = 1;
    eventbackground2.updateHitbox();
    eventbackground2.scale.set(4,4);
    eventbackground2.screenCenter(FlxAxes.X);
    eventbackground2.scrollFactor.set(1,1);
    eventbackground2.cameras = [camRays];
    add(eventbackground2);
    

    camfx = new FlxCamera();
    camfx.bgColor = 0;
    FlxG.cameras.add(camfx, false);

    txtFX = new FunkinText(0, FlxG.height * 0.875, 0, "HEY!", 48);
    txtFX.alignment = 'CENTER';
    txtFX.screenCenter(FlxAxes.Y);
    txtFX.color = 0xFFde2a8a;
    txtFX.cameras = [camfx];
    txtFX.x -= FlxG.width;
    add(txtFX);
 

    overlayfx = new FlxSprite(0,0).loadGraphic(Paths.image('fx'));
    overlayfx.scrollFactor.set(0, 0);
    overlayfx.alpha = 0;
    overlayfx.cameras = [camfx];
    overlayfx.setGraphicSize(FlxG.width * 1.2, FlxG.height * 1.2);
    overlayfx.screenCenter(FlxAxes.XY);
    add(overlayfx);

    bleh = new FlxSprite(0,0).loadGraphic(Paths.image('bleh'));
    bleh.scrollFactor.set(0, 0);
    bleh.alpha = 0;
    bleh.cameras = [camfx];
    bleh.setGraphicSize(FlxG.width, FlxG.height);
    bleh.screenCenter(FlxAxes.XY);
    add(bleh);


}

function onSongStart() {

    FlxTween.tween(FlxG.camera, {zoom: 0.8},10, {ease: FlxEase.backIn});
    FlxTween.tween(eventbackground2, {alpha: 0}, 10, {ease: FlxEase.cubeIn});
    FlxTween.tween(eventbackground, {alpha: 0}, 11, {ease: FlxEase.cubeIn});

}

function hey(which:Int)
{
    txtFX.x = 0;
    txtFX.alpha = 1;
    if(txtTween != null)
        {
            txtTween.cancel();
        }
    switch(which)
    {
        case 0:
            txtFX.text = 'HEY!';
            txtFX.x -= FlxG.width;
            txtTween = FlxTween.tween(txtFX, {x: txtFX.x + FlxG.width + 10}, 0.3, {ease: FlxEase.backInOut});
        
        case 1:
            txtFX.text = 'YEAH!';
            txtFX.x += FlxG.width;
            txtTween = FlxTween.tween(txtFX, {x: txtFX.x - 200}, 0.3, {ease: FlxEase.backInOut});
       

    }

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
    FlxG.camera.zoom += 0.04;
    camHUD.zoom += 0.07;
    flash();
}

function blehh()
{
    bleh.alpha = 1;
    FlxTween.tween(bleh, {alpha: 0}, 1,{ease: FlxEase.quadInOut});
}

function flash()
    {
        colorArry = ['0xFFfa4d41','0xFF66e83f','0xFFffb73b','0xFF47fff6','0xFF5260ff','0xFFe74aff','0xFFff36a1'];
        colorPicked = FlxG.random.int(0, 5);
        if(t != null)
        {
            t.cancel();
        }
        if(colortween != null) {
            colortween.cancel();
        }

        overlayfx.alpha = 0.6;
        overlayfx.color = 0xFFFFFFFF;
        t = FlxTween.tween(overlayfx, {alpha: 0}, 0.5,{ease: FlxEase.quadInOut});
        
        switch(colorPicked)
        {
            case 0:
                overlayfx.color = 0xFFfa4d41;
            case 1:
                overlayfx.color = 0xFF66e83f;
            case 2:
                overlayfx.color = 0xFFffb73b;
            case 3:
                overlayfx.color = 0xFF47fff6;
            case 4:
                overlayfx.color = 0xFF5260ff;
            case 5:
                overlayfx.color = 0xFFe74aff;
            case 6:
                overlayfx.color = 0xFFff36a1;
               
        }
    }

function beatHit()
    {
        if(heymoment)
        {
            if (curBeat % 2 == 0)
                {
                    hey(1);
                }
            if (curBeat %4 == 0)
                {
                    hey(0);
                }
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
                flash();
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
    switch (curStep){
        case 118:
            FlxTween.tween(camHUD, {alpha: 1}, 1, {ease: FlxEase.cubeIn});
            FlxTween.tween(camNewHUD, {alpha:1},1, {ease: FlxEase.cubeIn});
            for(s in strumLines.members[0]) {
                FlxTween.tween(s, {x:s.x + FlxG.width}, 1.5, {ease: FlxEase.expoOut});
            }
        
            for(s in strumLines.members[1]) {
                FlxTween.tween(s, {x:s.x - FlxG.width}, 1.5, {ease: FlxEase.expoOut});
            }
        case 139,172:
            FlxTween.tween(FlxG.camera, {zoom: 1},0.5, {ease: FlxEase.expoOut});
        case 148,204:
            FlxTween.tween(FlxG.camera, {zoom: 0.9},0.5, {ease: FlxEase.expoOut});
        case 230:
            boyfriend.cameraOffset.x += 300;
        case 239:
            FlxTween.tween(FlxG.camera, {zoom: 2},0.5, {ease: FlxEase.expoOut});
            
        case 244:
            FlxTween.tween(FlxG.camera, {zoom: 1},0.3, {ease: FlxEase.expoOut});
        case 246:
            FlxTween.tween(FlxG.camera, {zoom: 2},0.3, {ease: FlxEase.expoOut});
        case 250:
            FlxTween.tween(FlxG.camera, {zoom: 2},0.5, {ease: FlxEase.expoOut});
        case 253:
            FlxTween.tween(FlxG.camera, {zoom: 0.8},1, {ease: FlxEase.backInOut});
        case 256:
            boyfriend.cameraOffset.x -= 300;
        case 298:
            FlxTween.tween(FlxG.camera, {zoom: 1},0.5, {ease: FlxEase.expoOut});
        case 314:
            FlxTween.tween(FlxG.camera, {zoom: 1.5},0.5, {ease: FlxEase.expoOut});
        case 320:
            FlxTween.tween(FlxG.camera, {zoom: 0.8},4, {ease: FlxEase.backInOut});
        case 361:
            FlxTween.tween(FlxG.camera, {zoom: 1},0.4, {ease: FlxEase.expoOut});
        case 367:
            boyfriend.cameraOffset.x -= 300;
            dad.cameraOffset.x += 300;
            FlxTween.tween(FlxG.camera, {zoom: 1.4},0.2, {ease: FlxEase.expoOut});
        case 384:
            camHUD.flash(FlxColor.WHITE, 0.5);
            FlxTween.tween(FlxG.camera, {zoom: 0.8},1, {ease: FlxEase.backInOut}); 
            boyfriend.cameraOffset.x += 300;
            dad.cameraOffset.x -= 300;
            camZooming = true;
            superZoomShit = true;
        case 623,880,1019,1137,1263,495:
            superZoomShit = false;
        case 768,896,1024,1152,512:
            camHUD.flash(FlxColor.WHITE, 0.5);
            superZoomShit = true;
        case 1280:
            camZooming = false;
            FlxTween.tween(FlxG.camera, {zoom: 2},14, {ease: FlxEase.backInOut});
            FlxTween.tween(eventbackground, {alpha: 0.8},10, {ease: FlxEase.backInOut});
            boyfriend.cameraOffset.x += 300;
        case 1408:
            FlxTween.tween(eventbackground2, {alpha: 1},0.4, {ease: FlxEase.backInOut});
        case 771:
            heymoment = true;
        case 1020:
            heymoment = false;
            FlxTween.tween(txtFX, {alpha:0},1, {ease: FlxEase.backInOut});
        
            
            
        
        
    
    
    }
}

function onNoteHit(event)
    {
        event.enableCamZooming = false;
    }