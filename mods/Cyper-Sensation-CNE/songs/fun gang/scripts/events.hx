public var superZoomShit:Bool = false;
public var supersuperZoomShit:Bool = false;
public var zoomar:Bool = false;
var  t:FlxTween;
var t2:FlxTween;
var colortween:FlxTween;

function postCreate()
{
    trace('omg sonic');
    strumLines.members[2].characters[0].visible = false;
    strumLines.members[3].characters[0].visible = false;
    strumLines.members[4].characters[0].visible = false;

    strumLines.members[4].characters[0].y = 370;
    strumLines.members[4].characters[0].x -= 300;

    strumLines.members[3].characters[0].color = FlxColor.fromHSL(dad.color.hue, dad.color.saturation, 0.7, 0.7);

    strumLines.members[2].characters[0].color = FlxColor.fromHSL(dad.color.hue, dad.color.saturation, 0.7, 0.7);
    strumLines.members[2].characters[0].y += 80;
    strumLines.members[2].characters[0].x -= 50;
    strumLines.members[2].characters[0].cameraOffset.y -= 100;
    
    if(FlxG.save.data.MiddleScroll)
    {
        // Player MiddleScroll
        // TaeYai
        strumLines.members[1].members[0].setPosition(420,50);
        strumLines.members[1].members[1].setPosition(526,50);
        strumLines.members[1].members[2].setPosition(630,50);
        strumLines.members[1].members[3].setPosition(736,50);
        
        // Opponent Middle Scroll
        // idk
        strumLines.members[0].members[0].setPosition(80,50);
        strumLines.members[0].members[1].setPosition(186,50);
        strumLines.members[0].members[2].setPosition(965,50);
        strumLines.members[0].members[3].setPosition(1071,50);
        // idk
        strumLines.members[2].members[0].setPosition(80,50);
        strumLines.members[2].members[1].setPosition(186,50);
        strumLines.members[2].members[2].setPosition(965,50);
        strumLines.members[2].members[3].setPosition(1071,50);
        // idk
        strumLines.members[3].members[0].setPosition(80,50);
        strumLines.members[3].members[1].setPosition(186,50);
        strumLines.members[3].members[2].setPosition(965,50);
        strumLines.members[3].members[3].setPosition(1071,50);
        // idk
        strumLines.members[4].members[0].setPosition(80,50);
        strumLines.members[4].members[1].setPosition(186,50);
        strumLines.members[4].members[2].setPosition(965,50);
        strumLines.members[4].members[3].setPosition(1071,50);
    }

    for(s in strumLines.members[2].members) 
		{
			s.visible = false;
		}
    
     for(s in strumLines.members[3].members) 
		{
			s.visible = false;
		}

     for(s in strumLines.members[4].members) 
		{
			s.visible = false;
		}
    

    camfx = new FlxCamera();
    camfx.bgColor = 0;
    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.remove(camNewHUD, false);
    FlxG.cameras.add(camfx, false);
    FlxG.cameras.add(camHUD, false);
    FlxG.cameras.add(camNewHUD, false);
    
        
    bleh = new FlxSprite(0,0).loadGraphic(Paths.image('cat_scream'));
    bleh.scrollFactor.set(0, 0);
    bleh.alpha = 0;
    bleh.cameras = [camfx];
    bleh.setGraphicSize(FlxG.width, FlxG.height);
    bleh.screenCenter(FlxAxes.XY);
    add(bleh);

    silcat = new FlxSprite(0,0).loadGraphic(Paths.image('cat/cat'+FlxG.random.int(0,4)));
    silcat.scrollFactor.set(0, 0);
    silcat.alpha = 0;
    silcat.cameras = [camfx];
    silcat.setGraphicSize(FlxG.width, FlxG.height);
    silcat.screenCenter(FlxAxes.XY);
    add(silcat);

    camfx2 = new FlxCamera();
    camfx2.bgColor = 0;
    FlxG.cameras.add(camfx2, false);

    overlayfx = new FlxSprite(0,0).loadGraphic(Paths.image('fx'));
    overlayfx.scrollFactor.set(0, 0);
    overlayfx.alpha = 0;
    overlayfx.cameras = [camfx2];
    overlayfx.setGraphicSize(FlxG.width * 1.2, FlxG.height * 1.2);
    overlayfx.screenCenter(FlxAxes.XY);
    add(overlayfx);

    defaultCamZoom = 0.8;
}

function update()
{
    bleh.screenCenter(FlxAxes.XY);
    bleh.x += FlxG.random.int(0,9);
    bleh.y += FlxG.random.int(0,9);
    
}

function goose()
{
    remove(silcat);
    silcat = new FlxSprite(0,0).loadGraphic(Paths.image('goose'));
    silcat.alpha = 1;
    silcat.setGraphicSize(FlxG.width, FlxG.height);
    silcat.screenCenter(FlxAxes.XY);
    silcat.cameras = [camfx];
    add(silcat);
    FlxTween.tween(silcat, {alpha: 0}, 1,{ease: FlxEase.quadInOut});
}

function meow()
    {
        remove(silcat);
        silcat = new FlxSprite(0,0).loadGraphic(Paths.image('cat/cat'+FlxG.random.int(0,4)));
        silcat.alpha = 1;
        silcat.setGraphicSize(FlxG.width, FlxG.height);
        silcat.screenCenter(FlxAxes.XY);
        silcat.cameras = [camfx];
        add(silcat);
        FlxTween.tween(silcat, {alpha: 0}, 1,{ease: FlxEase.quadInOut});
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

function stepHit()
{
    switch(curStep)
    {
        case 128:
            defaultCamZoom = 1;
        case 384:
            zoomar = true;
        case 576:
            defaultCamZoom = 0.8;
        case 624:
            defaultCamZoom = 1.2;
            zoomar = false;
        case 640:
            camHUD.flash(FlxColor.WHITE, 0.5);
            defaultCamZoom = 0.8;
            superZoomShit = true;
        case 896:
            defaultCamZoom = 1.2;
        case 1024:
            defaultCamZoom = 1;
        case 1136:
            superZoomShit = false;
            t2 = FlxTween.tween(bleh, {alpha: 1}, 4,{ease: FlxEase.backOut});
        case 1152:
            camHUD.flash(FlxColor.WHITE, 0.5);
            t2.cancel();
            bleh.alpha = 0;
            defaultCamZoom = 0.8;

            strumLines.members[0].characters[0].visible = false;
            strumLines.members[2].characters[0].visible = true;
            for(s in strumLines.members[0].members) 
                {
                    s.visible = false;
                }
        
             for(s in strumLines.members[2].members) 
                {
                    s.visible = true;
                }
        case 1408:
            camHUD.flash(FlxColor.WHITE, 0.5);
            defaultCamZoom = 0.9;
            superZoomShit = true;
        case 1664:
            camHUD.flash(FlxColor.WHITE, 0.5);
            defaultCamZoom = 0.8;
            bleh.loadGraphic(Paths.image('cesarfever'));
            bleh.setGraphicSize(FlxG.width, FlxG.height);
            bleh.screenCenter(FlxAxes.XY);
        case 1904:
            superZoomShit = false;
            defaultCamZoom = 1.1;
        case 1908:
            t2 = FlxTween.tween(bleh, {alpha: 1}, 4,{ease: FlxEase.backOut});
        case 1920:
            camHUD.flash(FlxColor.WHITE, 0.5);
            t2.cancel();
            bleh.alpha = 0;
            bleh.visible = false;
            
            defaultCamZoom = 0.8;

            strumLines.members[2].characters[0].visible = false;
            strumLines.members[3].characters[0].visible = true;
            for(s in strumLines.members[2].members) 
                {
                    s.visible = false;
                }
        
             for(s in strumLines.members[3].members) 
                {
                    s.visible = true;
                }
        case 2048:
            defaultCamZoom = 0.9;
        case 2176:
            camHUD.flash(FlxColor.WHITE, 0.5);
            defaultCamZoom = 0.8;
            superZoomShit = true;
        case 2432,2496,2560,2624:
            defaultCamZoom = 0.9;
        case 2448,2480,2512,2576,2592,2640,2656:
            defaultCamZoom += 0.1;
        case 2464,2528,2544,2608:
            defaultCamZoom -= 0.1;
        case 2672:
            superZoomShit = false;
            defaultCamZoom = 1.1;
        case 2684:
            camHUD.flash(FlxColor.WHITE, 0.5);
            bleh.alpha = 0;
            defaultCamZoom = 0.8;

            strumLines.members[3].characters[0].visible = false;
            
            strumLines.members[4].characters[0].visible = true;
            for(s in strumLines.members[3].members) 
                {
                    s.visible = false;
                }
        
             for(s in strumLines.members[4].members) 
                {
                    s.visible = true;
                }
        case 2704,2736,2756,2784,2816,2832,2848,2872,2880,2896,2912:
            defaultCamZoom += 0.1;
        case 2720,2768,2800,2846,2840,2856,2888,2904,2920,2928:
            defaultCamZoom -= 0.1;
        case 2944:
            camHUD.flash(FlxColor.WHITE, 0.5);
            defaultCamZoom = 0.9;
            superZoomShit = true;
        case 3063:
            strumLines.members[3].characters[0].x -= FlxG.width;
            strumLines.members[3].characters[0].y -= 40;
            strumLines.members[3].characters[0].visible = true;
            strumLines.members[4].characters[0].visible = true;
            FlxTween.tween(strumLines.members[3].characters[0], {x: -440 ,y:435}, 0.4,{ease: FlxEase.backOut});
            FlxTween.tween(strumLines.members[4].characters[0], {x: -560,y:465}, 0.4,{ease: FlxEase.backOut});
        case 3132:
            strumLines.members[2].characters[0].visible = true;
            strumLines.members[2].characters[0].x =  -250;
            strumLines.members[2].characters[0].y = 465;
        case 3200:
            camHUD.flash(FlxColor.WHITE, 0.5);
        case 3390:
            strumLines.members[0].characters[0].x -= FlxG.width;
            strumLines.members[0].characters[0].visible = true;
            FlxTween.tween(strumLines.members[0].characters[0], {x: -165 ,y:-10}, 0.4,{ease: FlxEase.backOut});
        case 3456:
            camHUD.flash(FlxColor.WHITE, 0.5);
            defaultCamZoom = 0.9;
            superZoomShit = false;
            

    }
}

function bump()
    {
        FlxG.camera.zoom += 0.015;
        camHUD.zoom += 0.03;
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