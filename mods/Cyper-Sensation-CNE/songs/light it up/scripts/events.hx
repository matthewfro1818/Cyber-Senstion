public var superZoomShit:Bool = false;
public var supersuperZoomShit:Bool = false;
public var zoomar:Bool = false;
var  t:FlxTween;
var colortween:FlxTween;
var camTween:FlxTween;
var comGrp:FlxTypedGroup;
var floatvalve:Float = 0;
var count:Int = 0;
var comments = ['<3','OMG CJ SO COOL', 'THOSE OUTFIT LOOK SICK!', 'MOM, I WAS HERE!!!', 'YOOOOOO','IS THAT ETELED??', ' GOES HARD AF!!', 'FIRE!!!', 'BRO THIS BAND COOL AF', 'BOCCHI THE ROCK!!', 'LOOK GARY THERE I AM!', 'BROOOO','I LOVE THIS!!','CJ! CJ! CJ!','OMG RUBY SO CUTE!!', 'I KNOW THEM!','THIS IS AMAZING!','ON COMMAND!!'];
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
    
        camGame.zoom = 2;
    
        camNewHUD.alpha  = 0;
    
        eventbackground2 = new FlxSprite(dad.x,dad.y).makeGraphic(1280,720, 0xFF000000);
        eventbackground2.alpha = 1;
        eventbackground2.updateHitbox();
        eventbackground2.scale.set(4,4);
        eventbackground2.screenCenter(FlxAxes.Y);
        eventbackground2.scrollFactor.set(1,1);
        eventbackground2.cameras = [camNoRays];
        add(eventbackground2);
        
    
        camfx = new FlxCamera();
        camfx.bgColor = 0;
        FlxG.cameras.add(camfx, false);
     
        comGrp = new FlxTypedGroup();
        add(comGrp);

        overlayfx = new FlxSprite(0,0).loadGraphic(Paths.image('fx'));
        overlayfx.scrollFactor.set(0, 0);
        overlayfx.alpha = 0;
        overlayfx.cameras = [camfx];
        overlayfx.setGraphicSize(FlxG.width * 1.2, FlxG.height * 1.2);
        overlayfx.screenCenter(FlxAxes.XY);
        add(overlayfx);

        for(i in 0...20)
        {
            txtFX = new FunkinText(0, FlxG.random.int(0,700), 0, 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 16);
            txtFX.alignment = 'CENTER';
            txtFX.cameras = [camNoRays];
            txtFX.x += FlxG.width + 700;
            comGrp.add(txtFX);
            txtFX.kill();
            txtFX.destroy();
            comGrp.remove(txtFX);

        }
    
    
    }

function onSongStart() {

     FlxTween.tween(FlxG.camera, {zoom: 0.8},3, {ease: FlxEase.backInOut, onComplete: function() {
        camZooming = true;
    }});
     FlxTween.tween(eventbackground2, {alpha: 0}, 3, {ease: FlxEase.cubeIn});
     FlxTween.tween(eventbackground, {alpha: 0}, 3, {ease: FlxEase.cubeIn});
    trace(boyfriend.cameraOffset.x);
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

function spawmCom()
{
    var randomcom = comments[FlxG.random.int(0, comments.length-1)];

    if(count < 20)
    {
        txtFX = new FunkinText(0, FlxG.random.int(0,900), 0, randomcom, 16);
        txtFX.alignment = 'CENTER';
        txtFX.cameras = [camNoRays];
        txtFX.x += FlxG.width + 1000;
        count += 1;
            
        comGrp.add(txtFX);
    }


}

function postUpdate(elapsed:Float)
{

    comGrp.forEach(function(txt:FunkinText) 
        {
            txt.x -= FlxG.random.int(1,10);

            if(txt.x < -600)
            {
                txt.kill();
                txt.destroy();
                comGrp.remove(txt);

                count -=1;
            }

            if(curStep >= 1547)
            {
                FlxTween.tween(txt, {alpha:0}, 1.5, {ease: FlxEase.expoOut});
            }
        });
}

function bump()
{
    FlxG.camera.zoom += 0.04;
    camHUD.zoom += 0.07;
    flash();
}

function libump()
{
    FlxG.camera.zoom += 0.04;
    camHUD.zoom += 0.07;
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

function stepHit()
{
    switch (curStep)
    {
        case 16,255,265,314,318,327,351,360,368,382:
            bump();
        case 71:
            FlxTween.tween(camHUD, {alpha: 1}, 1, {ease: FlxEase.cubeIn});
            FlxTween.tween(camNewHUD, {alpha:1},1, {ease: FlxEase.cubeIn});
            for(s in strumLines.members[0]) {
                FlxTween.tween(s, {x:s.x + FlxG.width}, 1.5, {ease: FlxEase.expoOut});
            }
        
            for(s in strumLines.members[1]) {
                FlxTween.tween(s, {x:s.x - FlxG.width}, 1.5, {ease: FlxEase.expoOut});
            }
        case 135:
            camZooms(1,0.5);
        case 144:
            camZooms(0.8,1);
            bump();
        case 208: 
            zoomar = true;
        case 256:
            zoomar = false;
            camZooms(1,0.4);
        case 264:
            camZooms(2,0.3);
        case 272:
            camZooms(0.8,1);
            camHUD.flash(FlxColor.WHITE, 0.5);
        case 400:
            camZooms(1,1);
        case 408:
            camHUD.flash(FlxColor.WHITE, 0.5);
            camZooms(0.9,0.5);
        case 496:
            camHUD.flash(FlxColor.WHITE, 0.5);
            camZooms(2,5);
        case 528:
            camZooms(0.8,1);
            superZoomShit = true;
        case 588:
            camZooms(1,0.3);
            superZoomShit = false;
        case 591:
            camZooms(0.8,0.3);
            camHUD.flash(FlxColor.WHITE, 0.5);
        case 640:
            camZooms(0.9,0.1);
        case 643:
            camZooms(1,0.1);
        case 646:
            camZooms(1.5,0.1);
        case 648:
            camZooms(2,0.1);
        case 652:
            camZooms(1,0.5);
        case 656:
            camHUD.flash(FlxColor.WHITE, 0.5);
        case 659:
            camZooms(0.8,1);
        case 704:
            camZooms(1,0.3);
        case 710:
            camZooms(0.8,0.3);
        case 716:
            camZooms(1,0.3);
        case 722:
            camZooms(0.8,1);
        case 768:
            camZooms(1,2);
        case 784:
            camZooms(0.9,1);
        case 816:
            camZooms(0.8,1);
        case 898:
            camZooms(1,2);
        case 1040:
            camZooms(0.8,20);
        case 1151:
            camZooms(1,0.3);
        case 1168:
            camZooms(0.8,1);
            superZoomShit = true;
        case 1424:
            camHUD.flash(FlxColor.WHITE, 0.5);
            camZooms(1,16);
        case 592,817,848,1296:
            superZoomShit = true;
        case 624,844,880,1280,1392:
            superZoomShit = false;
        case 1294:
            camHUD.flash(FlxColor.WHITE, 0.5);
        case 1547:
            FlxTween.tween(eventbackground2, {alpha:1}, 1.5, {ease: FlxEase.expoOut});
            FlxTween.tween(camHUD, {alpha:0}, 1.5, {ease: FlxEase.expoOut});
            FlxTween.tween(camNewHUD, {alpha:0}, 1.5, {ease: FlxEase.expoOut});

    }
}

function beatHit()
    {
        spawmCom();
        
        
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

function onNoteHit(event)
    {
        event.enableCamZooming = false;
    }