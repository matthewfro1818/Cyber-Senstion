if (PlayState.difficulty.toLowerCase() != "regular") return;
import flixel.FlxCamera;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import funkin.backend.shaders.FunkinShader;
import openfl.filters.ShaderFilter;
import flixel.util.FlxSave;
import funkin.backend.assets.ModsFolder;

var flipX:Float = 1;
var flipY:Float = 1;
var eventbackground:FlxSprite;
public var superZoomShit:Bool = false;
public var supersuperZoomShit:Bool = false;
public var zoomar:Bool = false;
var normalzoom:Bool = false;
var time:Float = 0;
// Cameras
var _halfWidth:Int;
var _textY:Int;
var camsplit1:FlxCamera;
var camsplit2:FlxCamera;
var newcamFollow:FlxObject;
var newprevCamFollow:FlxObject;
var newcamFollow2:FlxObject;

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

function postCreate()
    {
        var index = members.indexOf(boyfriend);
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

       camGame.rotateSprite = false;

       boyfriend.cameraOffset.y -= 50;
       boyfriend.cameraOffset.x -= 200;

       dad.cameraOffset.x += 100;

       //CAM

    var camPoss:FlxPoint = new FlxPoint(boyfriend.getGraphicMidpoint().x, boyfriend.getGraphicMidpoint().y);
    var camPoss2:FlxPoint = new FlxPoint(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y);
    if (newprevCamFollow != null) {
            newcamFollow = newprevCamFollow;
            newprevCamFollow = null;
        } else {
            newcamFollow = new FlxObject(0, 0, 2, 2);
            newcamFollow.setPosition(camPoss.x, camPoss.y);

            newcamFollow2 = new FlxObject(0, 0, 2, 2);
            newcamFollow2.setPosition(camPoss2.x, camPoss2.y);
        }
        add(newcamFollow);
        add(newcamFollow2);

        createCamera(_halfWidth, 0xFFFFCCCC, boyfriend);

        newcamFollow.setPosition(dad.getGraphicMidpoint().x,dad.getGraphicMidpoint().y + 100);
        newcamFollow2.setPosition(boyfriend.getGraphicMidpoint().x,boyfriend.getGraphicMidpoint().y + 300);

        //cam 1 = dad
        camsplit1.width = FlxG.width / 2;
        camsplit1.height = FlxG.height;
        camsplit1.alpha = 1;
        camsplit1.zoom = 0.7;
        camsplit1.x -= FlxG.width;
        camsplit1.follow(newcamFollow);
        camsplit1.focusOn(newcamFollow.getPosition());

        //cam2 = bf
        camsplit2.width = FlxG.width / 2;
        camsplit2.height = FlxG.height;
        camsplit2.x += FlxG.width;
        camsplit2.follow(newcamFollow2);
        camsplit2.focusOn(newcamFollow2.getPosition());

        FlxG.camera.followLerp = 0.3;

        //Shader
        radialBlur = new CustomShader('radialBlur');
        radialBlur.cx = 0;
        radialBlur.cy = 0;
        radialBlur.blurWidth = 0;
        radialBlur.chromaticAmount = 0;
        camGame.addShader(radialBlur);

        glitch = new CustomShader('screenglitch');
        glitch.enabled = false;
        camGame.addShader(glitch);

        hudglitch = new CustomShader('hudglitch');
        hudglitch.enabled = false;
        camHUD.addShader(hudglitch);
        camNewHUD.addShader(hudglitch);

    }

function postUpdate(elapsed)
{
    speed = 5 * elapsed;
    time += elapsed;

    glitch.iTime = time;
    
    hudglitch.iTime = time;
    //radialBlur.blurWidth = lerp(radialBlur.blurWidth,0,0.125);
   // radialBlur.chromaticAmount= lerp(radialBlur.chromaticAmount,0.003,0.125);

    radialBlur.blurWidth = 0;
    radialBlur.cx = 0.05;
    radialBlur.cy = 1;

    radialBlur.chromaticAmount = 0.003;
}
function beatHit()
    {
        if (curBeat % 2 == 0 && normalzoom)
            {
                FlxG.camera.zoom += 0.03;
                camHUD.zoom += 0.06;
                camNewHUD.zoom += 0.06;
            }

        if (curBeat % 1 == 0 && curBeat >= 368 && curBeat < 379)
            {
                FlxG.camera.zoom += 0.04;
                camHUD.zoom += 0.07;
                camNewHUD.zoom += 0.07;
            }
        if (curBeat % 1 == 0 && curBeat >= 440 && curBeat < 447)
            {
                FlxG.camera.zoom += 0.04;
                camHUD.zoom += 0.07;
                camNewHUD.zoom += 0.07;
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

        if(curBeat %2 == 0 && FlxG.random.bool(30) && curBeat < 448){
            glitch.enabled = true;
    
            new FlxTimer().start(0.3, function(tmr:FlxTimer)
            {
                glitch.enabled = false;
                   
            });
        }

        if(curBeat >= 448 && curBeat < 503)
        {
            glitch.enabled = true;
    
            new FlxTimer().start(0.3, function(tmr:FlxTimer)
            {
                glitch.enabled = false;
                   
            });

            radialBlur.blurAmount += 0.02;
            radialBlur.chromaticAmount += 0.007;
            camGame.zoom += 0.015;
            camHUD.zoom += 0.03;
            camNewHUD.zoom += 0.03;
         }
    }

function onCameraMove(event)
{
    if(curBeat >= 448 && curBeat < 503)
    {
        switch(curCameraTarget)
        {
            case 0:
                FlxTween.tween(camGame, {zoom: 0.8}, 0.5, {ease: FlxEase.backInOut, onComplete: function(tween:FlxTween)
                    {
                        defaultCamZoom=0.8;    
                    }});
                FlxTween.tween(camGame, {angle: -10}, 0.5, {ease: FlxEase.backInOut});
            case 1:
                FlxTween.tween(camGame, {zoom: 1}, 0.5, {ease: FlxEase.backInOut, onComplete: function(tween:FlxTween)
                    {
                        defaultCamZoom=1;    
                    }});
                FlxTween.tween(camGame, {angle: 10}, 0.5, {ease: FlxEase.backInOut});
        }
    }

}

function stepHit(curStep) {
    if(curStep >= 1528 && curStep < 1536)
    {
        FlxG.camera.zoom += 0.03;
        camHUD.zoom += 0.06;
        camNewHUD.zoom += 0.06;
    }

    switch(curStep)
    {
        case 1:
            defaultCamZoom=0.9;
        case 224:
            FlxTween.tween(FlxG.camera, {zoom: 1}, 0.5, {ease: FlxEase.quadInOut, onComplete: function(tween:FlxTween)
                {
                    defaultCamZoom=0.85;    
                }});

        case 239,243,274,250,251,252,253,500,504,508:
            FlxG.camera.zoom += 0.09;
        case 255:
            FlxG.camera.followLerp = 0.04;
            camHUD.flash(FlxColor.WHITE, 0.5);
            FlxTween.tween(FlxG.camera, {zoom: 0.6}, 0.5, {ease: FlxEase.quadInOut, onComplete: function(tween:FlxTween)
                {
                    defaultCamZoom=0.6;    
                }});
        case 257:
            zoomar = true;
        case 302,430:
            FlxTween.tween(FlxG.camera, {zoom: 0.85}, 1.2, {ease: FlxEase.quadInOut, onComplete: function(tween:FlxTween)
                {
                    defaultCamZoom=0.6;    
                }});
        case 480:
            zoomar = false;
            FlxTween.tween(eventbackground, {alpha: 0.6}, 0.5);
            FlxTween.tween(FlxG.camera, {zoom: 1}, 0.5, {ease: FlxEase.quadInOut, onComplete: function(tween:FlxTween)
                {
                    defaultCamZoom=0.85;    
                }});
        case 512:
            zoomar = true;
            camHUD.flash(FlxColor.WHITE, 0.5);
            FlxTween.tween(eventbackground, {alpha: 0}, 0.01);
            FlxTween.tween(FlxG.camera, {zoom: 0.6}, 0.5, {ease: FlxEase.quadInOut, onComplete: function(tween:FlxTween)
                {
                    defaultCamZoom=0.6;    
                }});
             camflip('flip');
        case 736:
            zoomar = false;
        case 768:
            camHUD.flash(FlxColor.WHITE, 0.5);
            camflip('reset');
            superZoomShit = true;
        case 895:
            camflip('flip');
        case 925:
            camflip('upside');
        case 961:
            camflip('flip');
        case 992:
            superZoomShit = false;
            camflip('rest');
        case 1024:
            camflip('reset');
            camHUD.flash(FlxColor.BLACK, 0.5);
            FlxTween.tween(FlxG.camera, {zoom: 0.85}, 1, {ease: FlxEase.quadInOut, onComplete: function(tween:FlxTween)
                {
                    defaultCamZoom=0.85;    
                }});
        case 1279:
            camflip('flip');
            normalzoom = true;
        case 1291:
            camflip('reset');
        case 1302:
            camflip('upside');
        case 1311:
            camflip('flip');
        case 1323:
            camflip('reset');
            FlxTween.tween(FlxG.camera, {zoom: 0.7}, 1, {ease: FlxEase.quadInOut, onComplete: function(tween:FlxTween)
                {
                    defaultCamZoom=0.6;    
                }});
        case 1387:
            camflip('flip');
        case 1407:
            camflip('reset');
        case 1535:
            camflip('flip');
        case 1580:
            camflip('upside');
        case 1592,1594,1595,1597,1598,1599,1654,1655,1658,1660,1661,1662,1663,1720,1722,1724,1725,1726,1727:
            //glitch
            glitch.enabled = true;
            camGame.shake(0.004, 0.1, null, true);
            camHUD.shake(0.004, 0.1, null, true);
            camNewHUD.shake(0.004, 0.1, null, true);
            new FlxTimer().start(0.1, function(tmr:FlxTimer)
                {
                    glitch.enabled = false;
               
                });
        case 1407:
            FlxG.camera.followLerp = 1;
        case 1472:
            normalzoom = false;

        case 1504:
            //cam
            FlxTween.tween(camsplit1, {x: camsplit1 + FlxG.width}, 0.4, {ease: FlxEase.quadInOut});
            FlxTween.tween(camsplit2, {x: FlxG.width / 2}, 0.4, {ease: FlxEase.quadInOut});
        case 1536:
            FlxG.camera.followLerp = 0.04;
            FlxTween.tween(camsplit1, {x: camsplit1 - FlxG.width}, 1, {ease: FlxEase.quadInOut});
            FlxTween.tween(camsplit2, {x: camsplit2.x + 900}, 1, {ease: FlxEase.quadInOut});
        case 1600:
            camflip('reset');
        case 1664:
            camflip('flip');
        case 1709:
            camflip('upside');
        case 1728:
            camflip('reset');
        case 1758:
            part(false);

        case 1792:
            part(true);
            camGame.shake(0.003, 22, null, true);
            camHUD.shake(0.003, 22, null, true);
            camNewHUD.shake(0.003, 22, null, true);
            hudglitch.enabled = true;
            notemove('reverse');
            supersuperZoomShit = true;
            camHUD.flash(FlxColor.WHITE, 0.5);
        case 1824:
            camflip('flip');
        case 1856:
            camflip('reset');
            notemove('back');
        case 1876:
            notemove('half');
        case 1920:
            notemove('reset');
        case 1935:
            notemove('upside');
        case 1983:
            notemove('flip');
        case 2000:
            notemove('reverse');
        case 2016:
            camHUD.flash(FlxColor.WHITE, 0.5);
            zoomar = true;
            notemove('reset');
            hudglitch.enabled = false;
            FlxTween.tween(camGame, {zoom: 0.7}, 0.5, {ease: FlxEase.backInOut, onComplete: function(tween:FlxTween)
                {
                    defaultCamZoom=0.6;    
                }});
            FlxTween.tween(camGame, {angle: 0}, 0.5, {ease: FlxEase.backInOut});
        case 2038,2040,2042,2044,2045,2046,2047:
            glitch.enabled = true;
            hudglitch.enabled = true;
            camGame.shake(0.004, 0.1, null, true);
            camHUD.shake(0.004, 0.1, null, true);
            camNewHUD.shake(0.004, 0.1, null, true);
            new FlxTimer().start(0.1, function(tmr:FlxTimer)
                {
                    glitch.enabled = false;
                    hudglitch.enabled = false;
                });
        case 2096,2098,2100,2102,2104,2106,2108,2109,2110,2111,2224,2226,2228,2230,2232,2234,2236,2237,2338,2239:
            glitch.enabled = true;
            hudglitch.enabled = true;
            camGame.shake(0.004, 0.1, null, true);
            camHUD.shake(0.004, 0.1, null, true);
            camNewHUD.shake(0.004, 0.1, null, true);
            new FlxTimer().start(0.1, function(tmr:FlxTimer)
                {
                    glitch.enabled = false;
                    hudglitch.enabled = false;
                });
        case 2048:
            camHUD.flash(FlxColor.WHITE, 0.5);
            camflip('flip');
        case 2080:
            camflip('upside');
        case 2112:
            camflip('flip');
        case 2145:
            supersuperZoomShit = false;
            camflip('reset');




        

    }

}

function part(after:Bool)
    {
        if(!after)
        {
            defaultCamZoom = 0.9;
            dad.playAnim('line', true);
            camHUD.alpha = 0;
        }
        else
        {
            defaultCamZoom = 0.6;
            camHUD.alpha = 1;
        }

    }

function notemove(type:String)
{
    switch(type)
    {
        case 'back':
            if (FlxG.save.data.MiddleScroll) {
            FlxTween.tween(strumLines.members[1].members[0], {x: strumPos[0][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[1].members[1], {x: strumPos[1][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[1].members[2], {x: strumPos[2][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[1].members[3], {x: strumPos[3][0]}, 0.5, {ease: FlxEase.backInOut});

            FlxTween.tween(strumLines.members[0].members[0], {x: strumPos2[0][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[0].members[1], {x: strumPos2[1][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[0].members[2], {x: strumPos2[2][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[0].members[3], {x: strumPos2[3][0]}, 0.5, {ease: FlxEase.backInOut});        
            }
            if (!FlxG.save.data.MiddleScroll) {
            for(s in strumLines.members[0]) {
                FlxTween.tween(s, {x:s.x - 645}, 0.5, {ease: FlxEase.backInOut});
            }
            for(s in strumLines.members[1]) {
                FlxTween.tween(s, {x:s.x + 645}, 0.5, {ease: FlxEase.backInOut});
            }
            }
        case 'reverse':
            if (FlxG.save.data.MiddleScroll) {
            FlxTween.tween(strumLines.members[0].members[0], {x: strumPos[0][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[0].members[1], {x: strumPos[1][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[0].members[2], {x: strumPos[2][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[0].members[3], {x: strumPos[3][0]}, 0.5, {ease: FlxEase.backInOut});

            FlxTween.tween(strumLines.members[1].members[0], {x: strumPos2[0][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[1].members[1], {x: strumPos2[1][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[1].members[2], {x: strumPos2[2][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[1].members[3], {x: strumPos2[3][0]}, 0.5, {ease: FlxEase.backInOut});        
            }
            if (!FlxG.save.data.MiddleScroll) {
            for(s in strumLines.members[0]) {
                FlxTween.tween(s, {x:s.x + 645}, 0.5, {ease: FlxEase.backInOut});
            }
            for(s in strumLines.members[1]) {
                FlxTween.tween(s, {x:s.x -645}, 0.5, {ease: FlxEase.backInOut});
            }
            }
        case 'reset':
            FlxTween.tween(strumLines.members[1].members[0], {x: strumPos[0][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[1].members[1], {x: strumPos[1][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[1].members[2], {x: strumPos[2][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[1].members[3], {x: strumPos[3][0]}, 0.5, {ease: FlxEase.backInOut});

            FlxTween.tween(strumLines.members[0].members[0], {x: strumPos2[0][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[0].members[1], {x: strumPos2[1][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[0].members[2], {x: strumPos2[2][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[0].members[3], {x: strumPos2[3][0]}, 0.5, {ease: FlxEase.backInOut});        
        case 'half':
            FlxTween.tween(strumLines.members[1].members[0], {x: strumPos2[0][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[1].members[3], {x: strumPos2[3][0]}, 0.5, {ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[0].members[0], {x: strumPos[0][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[0].members[3], {x: strumPos[3][0]}, 0.5, {ease: FlxEase.backInOut});
        case 'upside':
            FlxTween.tween(strumLines.members[1].members[1], {y: strumLines.members[1].members[1].y - 60}, 0.5,{ease: FlxEase.backInOut,
                onComplete: function(twn:FlxTween)
                {
                    FlxTween.tween(strumLines.members[1].members[1], {x: strumPos[2][0]}, 0.4,{ease: FlxEase.backOut});
                    FlxTween.tween(strumLines.members[1].members[2], {x: strumPos[1][0]}, 0.4, {ease: FlxEase.backOut});

                    FlxTween.tween(strumLines.members[1].members[1], {y: strumPos[2][1]}, 0.4,{ease: FlxEase.backOut});
                    FlxTween.tween(strumLines.members[1].members[2], {y: strumPos[1][1]}, 0.4, {ease: FlxEase.backOut});
                }});
            FlxTween.tween(strumLines.members[1].members[2], {y: strumLines.members[1].members[2].y - 60}, 0.5, {ease: FlxEase.backInOut});
        case 'flip':
            FlxTween.tween(strumLines.members[1].members[0], {y: strumLines.members[1].members[1].y + 60}, 0.5,{ease: FlxEase.backInOut,
                onComplete: function(twn:FlxTween)
                {
                    FlxTween.tween(strumLines.members[1].members[0], {x: strumPos[3][0]}, 0.4,{ease: FlxEase.backOut});
                    FlxTween.tween(strumLines.members[1].members[3], {x: strumPos[0][0]}, 0.4, {ease: FlxEase.backOut});

                    FlxTween.tween(strumLines.members[1].members[0], {y: strumPos[3][1]}, 0.4,{ease: FlxEase.backOut});
                    FlxTween.tween(strumLines.members[1].members[3], {y: strumPos[0][1]}, 0.4, {ease: FlxEase.backOut});
                }});
            FlxTween.tween(strumLines.members[1].members[3], {y: strumLines.members[1].members[2].y + 60}, 0.5, {ease: FlxEase.backInOut});
        
    }
}

    

    function camflip(type:String)
    {
        switch (type)
        {
            case 'flip':
                FlxTween.tween(camHUD.flashSprite, {scaleX: -1}, 1, {ease: FlxEase.cubeOut});
                FlxTween.tween(camNewHUD.flashSprite, {scaleX: -1}, 1, {ease: FlxEase.cubeOut});
                FlxTween.tween(camGame.flashSprite, {scaleX: -1}, 1, {ease: FlxEase.cubeOut});
            /*	FlxTween.tween(Application.current.window, {width: Application.current.window.width -900}, 0.25, {ease: FlxEase.cubeOut,onComplete: function(twn:FlxTween)
                    {
                        FlxTween.tween(Application.current.window, {width: 1280}, 1, {ease: FlxEase.cubeOut});
                    }});*/
            case 'reset':
                FlxTween.tween(camHUD.flashSprite, {scaleX: 1}, 1, {ease: FlxEase.cubeOut});
                FlxTween.tween(camNewHUD.flashSprite, {scaleX: 1}, 1, {ease: FlxEase.cubeOut});
                FlxTween.tween(camGame.flashSprite, {scaleX: 1}, 1, {ease: FlxEase.cubeOut});
                new FlxTimer().start(1, function(tmr:FlxTimer)
                    {
                        FlxTween.tween(camHUD.flashSprite, {scaleY: 1}, 1, {ease: FlxEase.cubeOut});
                        FlxTween.tween(camNewHUD.flashSprite, {scaleY: 1}, 1, {ease: FlxEase.cubeOut});
                        FlxTween.tween(camGame.flashSprite, {scaleY: 1}, 1, {ease: FlxEase.cubeOut});
                    
                    });
            case 'upside':
                FlxTween.tween(camHUD.flashSprite, {scaleY: -1}, 1, {ease: FlxEase.cubeOut});
                FlxTween.tween(camNewHUD.flashSprite, {scaleY: -1}, 1, {ease: FlxEase.cubeOut});
                FlxTween.tween(camGame.flashSprite, {scaleY: -1}, 1, {ease: FlxEase.cubeOut});
                /*FlxTween.tween(Application.current.window, {height: 1}, 0.2, {ease: FlxEase.cubeOut,onComplete: function(twn:FlxTween)
                    {
                        FlxTween.tween(Application.current.window, {height: 720}, 1, {ease: FlxEase.cubeOut});
                    }});*/
            }
    }

function createCamera(X:Int, Color:Int, Follow:FlxSprite):Void
	{
		camsplit1 = new FlxCamera(X, 0, _halfWidth, _textY);
		camsplit1.bgColor = Color;
		camsplit1.follow(Follow);
       // FlxG.cameras.add(camsplit1);

        camsplit2 = new FlxCamera(X, 0, _halfWidth, 0);
		camsplit2.bgColor = Color;
		camsplit2.follow(Follow);
       // FlxG.cameras.add(camsplit2);
       FlxG.cameras.remove(camNewHUD, false);
       FlxG.cameras.remove(camHUD, false);
       FlxG.cameras.add(camsplit1);
       FlxG.cameras.add(camsplit2);
       FlxG.cameras.add(camNewHUD, false);
       FlxG.cameras.add(camHUD, false);
	}