if (PlayState.difficulty.toLowerCase() != "ex") return;
import flixel.util.FlxSave;
import funkin.backend.assets.ModsFolder;
var strumLerp = 0.1;
var strumOrder = [0, 1, 2, 3];
if(FlxG.save.data.MiddleScroll)
{
var strumPos = [[420, 50], [526, 50], [630, 50], [736, 50]]; //BF
var strumPos2 = [[80, 50], [186, 50], [965, 50], [1071, 50]]; // DAD
}
if(!FlxG.save.data.MiddleScroll)
{
var strumPos = [[736, 50], [848, 50], [960, 50], [1072, 50]]; //BF
var strumPos2 = [[96, 50], [208, 50], [320, 50], [432, 50]]; // DAD
}
var time:Float = 0;

var timetobump:Bool = false;
var lowbump:Bool = false;
public var superZoomShit:Bool = false;
public var supersuperZoomShit:Bool = false;
public var zoomar:Bool = false;
var normalzoom:Bool = false;

var t:FlxTween;
var t1:FlxTween;
var t2:FlxTween;
var t3:FlxTween;


var t4:FlxTween;
var t5:FlxTween;
var t6:FlxTween;
var t7:FlxTween;

function postCreate()
    {
        eventbackground = new FlxSprite(0,0).makeGraphic(1280,720, 0xFF000000);
        eventbackground.alpha = 0;
        eventbackground.updateHitbox();
        eventbackground.scale.set(4,4);
        eventbackground.screenCenter(FlxAxes.X);
        eventbackground.scrollFactor.set();

        add(eventbackground);
        chromaticGame = new CustomShader("stupid");
		chromaticGame.chromaticAmount = 0.002;

		camGame.addShader(chromaticGame);

        glitch = new CustomShader('screenglitch');
        glitch.enabled = false;
        camGame.addShader(glitch);

        hudglitch = new CustomShader('hudglitch');
        hudglitch.enabled = false;
        camHUD.addShader(hudglitch);
        camNewHUD.addShader(hudglitch);

        coolText = new FunkinText(0,0,0,'I CAN', 46, true);
        coolText.screenCenter();
        coolText.antialiasing = true;
        coolText.alpha = 0;
        coolText.borderSize = 3;
        coolText.font = Paths.font("freeplay.ttf");
        coolText.cameras = [camHUD];
        add(coolText);
    }

function postUpdate(elapsed)
{
    speed = 5 * elapsed;
    time += elapsed;

    glitch.iTime = time;
    
    hudglitch.iTime = time;

}

function textup(what:String)
    {
        
        coolText.text = what;
        coolText.alpha = 1;
        coolText.screenCenter(FlxAxes.XY);
        glitch.enabled = true;
        hudglitch.enabled = true;
        FlxG.camera.zoom += 0.015;
        camHUD.zoom += 0.03;
        camNewHUD.zoom += 0.03;
        new FlxTimer().start(0.3, function(tmr:FlxTimer)
        {
            glitch.enabled = false;
            hudglitch.enabled = false;
                       
        });
    }

function bump()
{
    FlxG.camera.zoom += 0.015;
    camHUD.zoom += 0.03;
    camNewHUD.zoom += 0.03;
}

function downbump() //IDK why Function parameter in chart editor won't work so i had to add this stupid
{
    notebump(true);
}

function doglitch()
{
    glitch.enabled = true;
    hudglitch.enabled = true;
    defaultCamZoom += 0.3;
    new FlxTimer().start(0.3, function(tmr:FlxTimer)
    {
        glitch.enabled = false;
        hudglitch.enabled = false;
        defaultCamZoom -= 0.3;
                   
    });
}

function beatHit()
    {
        if (curBeat % 4 == 0 && lowbump)
            {
                notebump(true);
            }

        if (curBeat % 2 == 0 && lowbump)
            {
                notebump();
            }

        if (curBeat % 2 == 0 && timetobump)
            {
                notebump(true);
            }
        if (curBeat % 1 == 0 && timetobump)
            {
                notebump();
            }

        if (curBeat % 2 == 0 && superZoomShit)
            {
                FlxG.camera.zoom += 0.03;
                camHUD.zoom += 0.06;
                camNewHUD.zoom += 0.06;
            }
        if (curBeat % 1 == 0 && superZoomShit)
            {
                FlxG.camera.zoom += 0.04;
                camHUD.zoom += 0.07;
                camNewHUD.zoom += 0.07;
            }

        if (curBeat % 2 == 0 && supersuperZoomShit)
            {
                FlxG.camera.zoom += 0.03;
                camHUD.zoom += 0.06;
                camNewHUD.zoom += 0.06;
            }
    
            if (curBeat % 1 == 0 && supersuperZoomShit)
            {
                FlxG.camera.zoom += 0.06;
                camHUD.zoom += 0.08;
                camNewHUD.zoom += 0.08;
            }
        if (curBeat % 2 == 0 && zoomar)
            {
                FlxG.camera.zoom += 0.010;
                camHUD.zoom += 0.02;
                camNewHUD.zoom += 0.02;
            }
        if (curBeat % 1 == 0 && zoomar)
            {
                FlxG.camera.zoom += 0.015;
                camHUD.zoom += 0.03;
                camNewHUD.zoom += 0.03;
            }

        if (curBeat % 2 == 0 && normalzoom)
            {
                FlxG.camera.zoom += 0.03;
                camHUD.zoom += 0.06;
                camNewHUD.zoom += 0.06;
            }
    }

function stepHit()
{
    switch(curStep)
    {
        case 1:
            camHUD.flash(FlxColor.WHITE, 0.5);
        case 256:
            camHUD.flash(FlxColor.WHITE, 0.5);
            zoomar = true;
        case 480:
            zoomar = false;
        case 510:
            camHUD.flash(FlxColor.WHITE, 0.5);
            timetobump = true;
            superZoomShit = true;
        case 737:
            timetobump = false;
            superZoomShit = false;
        case 768:
            lowbump = true;
            normalzoom = true;
            camHUD.flash(FlxColor.WHITE, 0.5);
        case 896:
            lowbump = false;
            normalzoom = false;
            zoomar = true;
            timetobump = true;
        case 992:
            timetobump = false;
            zoomar = false;
        case 1760:
            eventbackground.alpha = 1;
            coolText.alpha = 1;
        case 1788:
            doglitch();
        case 1792:
            camHUD.flash(FlxColor.WHITE, 0.5);
            eventbackground.alpha = 0;
            superZoomShit = true;
            coolText.alpha = 0;
        case 2016:
            superZoomShit = false;
        case 2048:
            camHUD.flash(FlxColor.WHITE, 0.5);
            timetobump = true;
            superZoomShit = true;
        case 2240:
            timetobump = false;
        case 2273:
            superZoomShit = false;

    }
}    

function notebump(reverse:Bool = false)
{
    if(t != null)
    {
        t.cancel(); 
                
    }

    if(t1 != null)
    {
        t1.cancel();  
    }
    
    if(t2 != null)
    {
        t2.cancel();  
    }

               

    
    if(t3 != null)
    {
        t3.cancel();  
    }

    if(t4 != null)
    {
        t4.cancel();  
    }
        
    if(t5 != null)
    {
        t5.cancel();  
    }

    if(t6 != null)
    {
        t6.cancel();  
    }

    if(t7 != null)
    {
        t7.cancel();  
    }

    
    if(reverse)
    {
        strumLines.members[1].members[0].angle = -10;
        strumLines.members[1].members[0].x -= 20;
        strumLines.members[1].members[0].y -= 40;
    
        strumLines.members[1].members[1].angle = -10;
        strumLines.members[1].members[1].x -= 40;
        strumLines.members[1].members[1].y += 40;
    
        strumLines.members[1].members[2].angle = 10;
        strumLines.members[1].members[2].x += 40;
        strumLines.members[1].members[2].y += 40;
    
        strumLines.members[1].members[3].angle = 10;
        strumLines.members[1].members[3].x += 20;
        strumLines.members[1].members[3].y -= 40;
    }
    else
    {
        strumLines.members[1].members[0].angle = -10;
        strumLines.members[1].members[0].x -= 40;
        strumLines.members[1].members[0].y += 20;
    
        strumLines.members[1].members[1].angle = -10;
        strumLines.members[1].members[1].x -= 40;
        strumLines.members[1].members[1].y -= 40;
    
        strumLines.members[1].members[2].angle = 10;
        strumLines.members[1].members[2].x += 40;
        strumLines.members[1].members[2].y -= 40;
    
        strumLines.members[1].members[3].angle = 10;
        strumLines.members[1].members[3].x += 40;
        strumLines.members[1].members[3].y += 20;
    }

    t = FlxTween.tween(strumLines.members[1].members[0], {x: strumPos[0][0], y: strumPos[0][1], angle:0}, 0.3,{ease: FlxEase.backInOut});
    t1 = FlxTween.tween(strumLines.members[1].members[1], {x: strumPos[1][0], y: strumPos[1][1], angle:0}, 0.3,{ease: FlxEase.backInOut});
    t2 = FlxTween.tween(strumLines.members[1].members[2], {x: strumPos[2][0], y: strumPos[2][1], angle:0}, 0.3,{ease: FlxEase.backInOut});
    t3 = FlxTween.tween(strumLines.members[1].members[3], {x: strumPos[3][0], y: strumPos[3][1], angle:0}, 0.3,{ease: FlxEase.backInOut});

    if(reverse)
        {
            strumLines.members[0].members[0].angle = -10;
            strumLines.members[0].members[0].x -= 40;
            strumLines.members[0].members[0].y -= 20;
        
            strumLines.members[0].members[1].angle = -10;
            strumLines.members[0].members[1].x -= 40;
            strumLines.members[0].members[1].y += 40;
        
            strumLines.members[0].members[2].angle = 10;
            strumLines.members[0].members[2].x += 40;
            strumLines.members[0].members[2].y += 40;
        
            strumLines.members[0].members[3].angle = 10;
            strumLines.members[0].members[3].x += 40;
            strumLines.members[0].members[3].y -= 20;
        }
        else
        {
            strumLines.members[0].members[0].angle = -10;
            strumLines.members[0].members[0].x -= 20;
            strumLines.members[0].members[0].y += 40;
        
            strumLines.members[0].members[1].angle = -10;
            strumLines.members[0].members[1].x -= 40;
            strumLines.members[0].members[1].y -= 40;
        
            strumLines.members[0].members[2].angle = 10;
            strumLines.members[0].members[2].x += 40;
            strumLines.members[0].members[2].y -= 40;
        
            strumLines.members[0].members[3].angle = 10;
            strumLines.members[0].members[3].x += 20;
            strumLines.members[0].members[3].y += 40;
        }
    t4 = FlxTween.tween(strumLines.members[0].members[0], {x: strumPos2[0][0], y: strumPos2[0][1], angle:0}, 0.3,{ease: FlxEase.backInOut});
    t5 = FlxTween.tween(strumLines.members[0].members[1], {x: strumPos2[1][0], y: strumPos2[1][1], angle:0}, 0.3,{ease: FlxEase.backInOut});
    t6 = FlxTween.tween(strumLines.members[0].members[2], {x: strumPos2[2][0], y: strumPos2[2][1], angle:0}, 0.3,{ease: FlxEase.backInOut});
    t7 = FlxTween.tween(strumLines.members[0].members[3], {x: strumPos2[3][0], y: strumPos2[3][1], angle:0}, 0.3,{ease: FlxEase.backInOut});
}