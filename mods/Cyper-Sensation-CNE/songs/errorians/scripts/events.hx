import flixel.FlxObject;
import hxvlc.flixel.FlxVideoSprite;
import funkin.backend.assets.ModsFolder;
var floatdaisy:Float = 0;
var fixedCamFollow:FlxObject = new FlxObject(0, 0, 2, 2);
var multi:Float = 0.0;
var multi2:Float = 0.0;
var multi3:Float = 0.0;
var zoomar:Bool = false;
var superZoomar:Bool = false;
var zoomTween:FlxTween;
var video:FlxVideoSprite;
function postCreate() {
    futo = strumLines.members[2].characters[0];
    conner = strumLines.members[3].characters[0];
    daisy = strumLines.members[4].characters[0];

    shaStrum = strumLines.members[0];
    futoStrum = strumLines.members[2];
    connerStrum = strumLines.members[3];
    daisyStrum = strumLines.members[4];
    
    if(FlxG.save.data.MiddleScroll)
    {
        // Player MiddleScroll
        // TaeYai
        strumLines.members[1].members[0].setPosition(420,50);
        strumLines.members[1].members[1].setPosition(526,50);
        strumLines.members[1].members[2].setPosition(630,50);
        strumLines.members[1].members[3].setPosition(736,50);
        
        // Opponent Middle Scroll
        // Shadow TaeYai
        strumLines.members[0].members[0].setPosition(80,50);
        strumLines.members[0].members[1].setPosition(186,50);
        strumLines.members[0].members[2].setPosition(965,50);
        strumLines.members[0].members[3].setPosition(1071,50);
        // Futo
        strumLines.members[2].members[0].setPosition(80,50);
        strumLines.members[2].members[1].setPosition(186,50);
        strumLines.members[2].members[2].setPosition(965,50);
        strumLines.members[2].members[3].setPosition(1071,50);
        //Conner
        strumLines.members[3].members[0].setPosition(80,50);
        strumLines.members[3].members[1].setPosition(186,50);
        strumLines.members[3].members[2].setPosition(965,50);
        strumLines.members[3].members[3].setPosition(1071,50);
        // Daisy
        strumLines.members[4].members[0].setPosition(80,50);
        strumLines.members[4].members[1].setPosition(186,50);
        strumLines.members[4].members[2].setPosition(965,50);
        strumLines.members[4].members[3].setPosition(1071,50);
    }

    taeyai = boyfriend;
    var i = 0;
    i++;

    conner.shader = new CustomShader("garage-shadow");
    conner.shader.color = [3, 249 / 255, 0.5, 0.33 * ((3 - i) / 3)];
    conner.shader.shadowLength = 35 * ((3 - i) / 2);
    conner.shader.flipped = false;

    daisy.shader = new CustomShader("garage-shadow");
    daisy.shader.color = [2, 249 / 255, 0.5, 0.33 * ((3 - i) / 3)];
    daisy.shader.shadowLength = 25 * ((3 - i) / 2);
    daisy.shader.flipped = true;

    futo.shader = new CustomShader("garage-shadow");
    futo.shader.color = [2, 249 / 255, 0.5, 0.33 * ((3 - i) / 3)];
    futo.shader.shadowLength = 25 * ((3 - i) / 2);
    futo.shader.flipped = false;

	conner.color = FlxColor.fromHSL(conner.color.hue, conner.color.saturation, 0.4, 0.4);
	daisy.color = FlxColor.fromHSL(daisy.color.hue, daisy.color.saturation, 0.7, 0.7);
	futo.color = FlxColor.fromHSL(futo.color.hue, futo.color.saturation, 0.4, 0.4);

    daisy.y = -300;
    conner.setPosition(-570,105);
    futo.setPosition(-1280,-100);
    futo.visible = conner.visible = daisy.visible = false;
    taeyai.y += 100;
    /*
    //For Last part lol
    taeyai.setPosition(-20, 100);
    conner.setPosition(-725, 105);
    futo.setPosition(500, -25);
    futo.isPlayer = true;
    futo.flipX = true;
    daisy.setPosition(100, -282.371)
    daisy.x += 200;
    taeyai.cameraOffset.x += 60;*/

    //Turn off
    for(s in futoStrum) {
       s.alpha = 0;
       s.color = FlxColor.fromHSL(s.color.hue, 0.9, 0.4, 0.4);
    }

    
    for(s in connerStrum) {
        s.alpha = 0;
        s.color = FlxColor.fromHSL(3, 0.3, 0.4, 0.4);
     }

     
    for(s in daisyStrum) {
        s.alpha = 0;
        s.color = FlxColor.fromHSL(298, 0.3, 0.4, 0.4);
     }

     for(s in strumLines.members[0]) {
        s.color = FlxColor.fromHSL(s.color.hue, 0.9, 0.4, 0.4);
     }

     add(fixedCamFollow);
     camGame.alpha = camNewHUD.alpha = 0;

     eventbackground2 = new FlxSprite(200,-200).makeGraphic(1280,720, 0xFF000000);
     eventbackground2.alpha = 0;
     eventbackground2.updateHitbox();
     eventbackground2.scale.set(10,10);
     eventbackground2.screenCenter(FlxAxes.X);
     eventbackground2.scrollFactor.set(1,1);
     add(eventbackground2);

     //for Hard Bump effect
     blur = new CustomShader("radialBlur");
     blur.cx =  0.5;
     blur.cy =  0.5;
     blur.blurWidth = 0.0;

     chromaticGame = new CustomShader("stupid");
     chromaticGame.chromaticAmount = 0.003;

     chromatic = new CustomShader("stupid");
     chromatic.chromaticAmount = 0.001;

     if(FlxG.save.data.ShaderHigh) {
     camGame.addShader(blur);
     camHUD.addShader(blur);
     camNewHUD.addShader(blur);
     }

     camGame.addShader(chromaticGame);
     camHUD.addShader(chromatic);
     camNewHUD.addShader(chromatic);

     //Extra Stage
     var index = members.indexOf(strumLines.members[0].characters[0]);
     clown1 = new FlxSprite(-1470   ,-895 ).loadGraphic(Paths.image('stages/shadow/clown2'));
     insert(index, clown1);

     clownf = new FlxSprite(-1400 ,-1055 ).loadGraphic(Paths.image("stages/shadow/flame"));
     clownf.frames = Paths.getSparrowAtlas('stages/shadow/flame');
     clownf.antialiasing = true;
     clownf.scrollFactor.set(0.7,0.7);
     clownf.animation.addByPrefix('idle', "f", 24,true);
     clownf.animation.play('idle',true);

     insert(index, clownf);

     clown0 = new FlxSprite(-1310  ,-1010).loadGraphic(Paths.image('stages/shadow/clown1'));
     insert(index, clown0);

     camfx = new FlxCamera();
     camfx.bgColor = 0;
     FlxG.cameras.add(camfx, false);


     coolText = new FunkinText(0,0,0,'CHAOS', 64, true);
     coolText.antialiasing = true;
     coolText.font = Paths.font("seriouss.ttf");
     coolText.cameras = [camfx];
     coolText.color = 0xFFf5675b;
     coolText.screenCenter();
     add(coolText);

     scary = new FlxSprite(-1310  ,-1010).loadGraphic(Paths.image('stages/shadow/scary'));
     scary.cameras = [camfx];
     scary.alpha = 0;
     scary.screenCenter();
     add(scary);


     video = new FlxVideoSprite(FlxAxes.X,FlxAxes.Y);
     video.cameras = [camfx];
 
     add(video);

     glitch = new CustomShader('screenglitch');
     glitch.enabled = true;
     camfx.addShader(glitch);
     clown1.visible = clownf.visible = clown0.visible = coolText.visible = false;

     if(PlayState.isStoryMode)
        {
            FlxG.save.data.bfmode = false;
        }
}

function videomidsong(videoname) 
    {
        trace('playvide');
        if (video.load('mods/' + ModsFolder.currentModFolder + '/videos/' + videoname + '.mp4'))
            new FlxTimer().start(0.001, function(tmr:FlxTimer) {
                video.play();
            });
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
function onPostCountdown(event) {
    event.sprite.visible = false;
    FlxG.camera.target = fixedCamFollow;
    
    FlxTween.tween(camGame, {alpha: 1}, 1.5, {ease: FlxEase.quadInOut});
    FlxTween.tween(fixedCamFollow, {x: 300}, 1.5, {ease: FlxEase.quadInOut});

}
function onPostNoteCreation(event)
{
        if(event.strumLineID == 0 || event.strumLineID == 2)
            {
                event.note.color = FlxColor.fromHSL(event.note.color.hue, 0.9, 0.4, 0.4);
            }
            
        if(event.strumLineID == 3)
            {
                event.note.color = FlxColor.fromHSL(3, 0.3, 0.4, 0.4);
            }

        if(event.strumLineID == 4)
            {
                event.note.color = FlxColor.fromHSL(298, 0.3, 0.4, 0.4);
            }
}

function onStrumCreation(event)
    {
        if (event.player > 1)
            {
                event.cancelAnimation();
            }
    }

function postUpdate(elapsed)
    {
        floatdaisy += 0.06 * elapsed * 120;
        var sinvalve = Math.sin(floatdaisy);
        var cosvalve = Math.cos(floatdaisy);
        daisy.y += sinvalve * elapsed * 120;
        daisy.y += cosvalve * elapsed * 120;

        video.screenCenter(FlxAxes.XY);
        video.setGraphicSize(FlxG.width, FlxG.height);

        /*var damngod = futo;
        if (FlxG.keys.pressed.LEFT) damngod.x -= 5;
        if (FlxG.keys.pressed.RIGHT) damngod.x += 5;
        if (FlxG.keys.pressed.UP) damngod.y -= 5;
        if (FlxG.keys.pressed.DOWN) damngod.y += 5;
        if (FlxG.keys.pressed.SPACE) trace(damngod);*/
    }
var time:Float = 0;
function update(elapsed)
{
    multi = lerp(multi,0.0,0.125);
    blur.blurWidth = multi;

    multi2 = lerp(multi2,0.0014,0.125);
    chromatic.chromaticAmount = multi2;

    multi3 = lerp(multi3,0.003,0.125);
    chromaticGame.chromaticAmount = multi2;

    time += elapsed;
    glitch.iTime = time;
}
function bump()
{
    FlxG.camera.zoom += 0.015;
    camHUD.zoom += 0.03;
    multi2 += 0.002;
    multi3 += 0.002;
    
} 

function hardbump()
{
    FlxG.camera.zoom += 0.03;
    camHUD.zoom += 0.06;
    multi+= 0.07;
    multi2 += 0.002;
    multi3 += 0.002;
    
} 

function beatHit()
    {
        if (curBeat % 2 == 0 && zoomar)
            {
                FlxG.camera.zoom += 0.010;
                camHUD.zoom += 0.02;
            }
        if (curBeat % 1 == 0 && zoomar)
            {
                bump();
            }

        if (curBeat % 2 == 0 && superZoomar)
            {
                FlxG.camera.zoom += 0.03;
                camHUD.zoom += 0.06;
                multi+= 0.03;
                multi2 += 0.002;
                multi3 += 0.002;
            }
        if (curBeat % 1 == 0 && superZoomar)
            {
                bump();
            }
    } 

function stepHit()
{
    switch(curStep)
    {
        case 31:
            defaultCamZoom = 1;
            camGame.zoom = 1;
            fixedCamFollow.x = -700;
            fixedCamFollow.y = -100;
        case 32:
            FlxG.camera.followLerp = 0.3;
            FlxTween.tween(fixedCamFollow, {x: -400}, 1.5, {ease: FlxEase.quadInOut});
        case 64:
            fixedCamFollow.x = 1540;
            fixedCamFollow.y = 500;
            FlxG.camera.followLerp = 0;
            FlxG.camera.focusOn(fixedCamFollow.getPosition());
            new FlxTimer().start(0.01, function(tmr:FlxTimer)
                {
                    FlxG.camera.followLerp = 0.3;
                    FlxTween.tween(fixedCamFollow, {x: 640}, 1.5, {ease: FlxEase.expoOut});
                });
        case 95:
            camGame.zoom = 2;
            fixedCamFollow.x = -700;
            fixedCamFollow.y = -100;
        case 96:
            FlxG.camera.followLerp = 0.3;
            FlxTween.tween(fixedCamFollow, {x: -400}, 1.5, {ease: FlxEase.quadInOut});
            FlxTween.tween(camGame, {angle: 20}, 1.7, {ease: FlxEase.expoOut});
        case 116:
            fixedCamFollow.x = 940;
            fixedCamFollow.y = 470;
            camGame.angle = -20;
            FlxG.camera.followLerp = 0;
            FlxG.camera.focusOn(fixedCamFollow.getPosition());
        case 127:
            fixedCamFollow.x = 300;
            fixedCamFollow.y = 300;
            camGame.angle = 0;
            FlxG.camera.followLerp = 0;
            FlxG.camera.focusOn(fixedCamFollow.getPosition());
            new FlxTimer().start(0.01, function(tmr:FlxTimer)
                {
                    FlxG.camera.followLerp = 0.3;
                    FlxTween.tween(fixedCamFollow, {x: 300, y:-100}, 1.5, {ease: FlxEase.quadInOut});
                    FlxTween.tween(camGame, {zoom: 0.4}, 1.5, {ease: FlxEase.expoOut});

                });
        case 144:
                FlxTween.tween(camHUD, {alpha: 1}, 1, {ease: FlxEase.cubeIn});
                FlxTween.tween(camNewHUD, {alpha:1},1, {ease: FlxEase.cubeIn});
                for(s in strumLines.members[0]) {
                    FlxTween.tween(s, {x:s.x + FlxG.width}, 1.5, {ease: FlxEase.expoOut});
                }
                    
                for(s in strumLines.members[1]) {
                    FlxTween.tween(s, {x:s.x - FlxG.width}, 1.5, {ease: FlxEase.expoOut});
                }
        case 160:
            FlxG.camera.target = smoothCamFollow;
        case 416:
            FlxTween.tween(eventbackground2, {alpha:1}, 1.5, {ease: FlxEase.expoOut});
        case 432:
            FlxTween.tween(eventbackground2, {alpha:0}, 2.5, {ease: FlxEase.expoOut});
            FlxTween.tween(camGame, {zoom: 0.5}, 2.5, {ease: FlxEase.expoOut});
        case 448,576:
            defaultCamZoom = 0.7;
            camHUD.flash(FlxColor.WHITE, 0.2);
        case 704:
            defaultCamZoom = 0.76;
            camHUD.flash(FlxColor.WHITE, 0.2);
        case 820,1313:
            FlxTween.tween(eventbackground2, {alpha:1}, 1.5, {ease: FlxEase.expoOut});
            FlxTween.tween(camGame, {zoom: 1}, 2.5, {ease: FlxEase.expoOut});
            zoomar = false;
        case 824:
            coolText.visible = true;
        case 827:
            FlxTween.tween(scary, {alpha:1}, 2.5, {ease: FlxEase.expoOut});
        case 832: //Conner
            FlxG.camera.target = fixedCamFollow;
            defaultCamZoom =1;
            fixedCamFollow.x = -400;
            fixedCamFollow.y = 500;


            camHUD.flash(FlxColor.WHITE, 0.2);
            scary.visible = eventbackground2.visible = coolText.visible = false;
            dad.visible = false;
            clown1.visible = clownf.visible = clown0.visible = true;
            conner.visible = true;

            
            for(s in shaStrum) {
                s.alpha = 0;
             }

            for(s in connerStrum) {
                s.alpha = 1;
             }

             zoomar = true;
    
        case 833:
            FlxG.camera.followLerp = 0.3;
            FlxTween.tween(fixedCamFollow, {x: -400}, 1.5, {ease: FlxEase.quadInOut});
        case 850,882:
            defaultCamZoom =0.8;
        case 864,928:
            defaultCamZoom =1;
        case 896:
            defaultCamZoom =0.76;
            fixedCamFollow.x = 640 + 450;
            fixedCamFollow.y = 500;
            FlxG.camera.followLerp = 0;
            FlxG.camera.focusOn(fixedCamFollow.getPosition());
            new FlxTimer().start(0.01, function(tmr:FlxTimer)
                {
                    multi+= 0.3;
                    FlxG.camera.followLerp = 0.3;
                    FlxTween.tween(fixedCamFollow, {x: 640}, 1.5, {ease: FlxEase.expoOut});
                });
        case 928:
            zoomar = false;
        case 946:
            defaultCamZoom =1;
            fixedCamFollow.x = -400;
            daisy.visible = true;
            daisy.x = -1705;
            daisy.y = -800;
        case 955:
            defaultCamZoom =0.8;
            FlxTween.tween(daisy, {y: -371.828}, 1.5, {ease: FlxEase.quadInOut});
            daisy.flipX = false;
            fixedCamFollow.y = daisy.getMidpoint().y;
            daisy.cameraOffset.x += 300;
            conner.cameraOffset.x -= 300;
            
                         
            for(s in daisyStrum) {
                s.alpha = 1;
             }

             zoomar = true;
        case 960:
            FlxG.camera.target = smoothCamFollow;
            defaultCamZoom =0.6;
            eventbackground2.visible = true;
            eventbackground2.alpha = 0;
        case 1326: //Go Back to Sha
            for(s in shaStrum) {
                s.alpha = 1;
             }
            for(s in connerStrum) {
                s.alpha = 0;
             }
            for(s in daisyStrum) {
                s.alpha = 0;
             }

             dad.visible = true;
             clown1.visible = clownf.visible = clown0.visible = conner.visible = daisy.visible = false;
        case 1328:
            FlxTween.tween(eventbackground2, {alpha:0}, 2.5, {ease: FlxEase.expoOut});
            FlxTween.tween(camGame, {zoom: 0.5}, 2.5, {ease: FlxEase.expoOut});
        case 1344:
            defaultCamZoom = 0.76;
            camHUD.flash(FlxColor.WHITE, 0.2);
        case 1472,1600:
            camHUD.flash(FlxColor.WHITE, 0.2);
        case 1856:
            FlxTween.tween(eventbackground2, {alpha:1}, 1.5, {ease: FlxEase.expoOut});
            FlxTween.tween(camGame, {zoom: 1}, 2.5, {ease: FlxEase.expoOut});
        case 1892: //FUTO
            for(s in shaStrum) {
                s.alpha = 0;
             }
             for(s in futoStrum) {
                s.alpha = 1;
             }
             futo.visible = true;
             dad.visible = false;
        case 1904:
            FlxTween.tween(eventbackground2, {alpha:0}, 2.5, {ease: FlxEase.expoOut});
            FlxTween.tween(camGame, {zoom: 0.5}, 2.5, {ease: FlxEase.expoOut});
        case 1920:
            FlxG.camera.target = fixedCamFollow;
            defaultCamZoom =0.8;
            fixedCamFollow.x = -700;
            fixedCamFollow.y = 300;

            camHUD.flash(FlxColor.WHITE, 0.2);
        case 1921:
            FlxG.camera.followLerp = 0.3;
            FlxTween.tween(fixedCamFollow, {x: futo.getMidpoint().x}, 1.5, {ease: FlxEase.quadInOut});
        case 1952:
            defaultCamZoom =0.9;
            fixedCamFollow.x = 300;
            fixedCamFollow.y = 500;
            FlxG.camera.followLerp = 0;
            FlxG.camera.focusOn(fixedCamFollow.getPosition());
            new FlxTimer().start(0.01, function(tmr:FlxTimer)
                {
                    multi+= 0.1;
                    FlxG.camera.followLerp = 0.3;
                    FlxTween.tween(fixedCamFollow, {x: futo.getMidpoint().x}, 1.5, {ease: FlxEase.expoOut});
                });
        case 1968:
            defaultCamZoom =0.76;
            fixedCamFollow.y = -300;
            FlxG.camera.followLerp = 0;
            FlxG.camera.focusOn(fixedCamFollow.getPosition());
            new FlxTimer().start(0.01, function(tmr:FlxTimer)
                {
                    multi+= 0.1;
                    FlxG.camera.followLerp = 0.3;
                    FlxTween.tween(fixedCamFollow, {y: 300}, 1.5, {ease: FlxEase.expoOut});
                });
        case 1976:
            defaultCamZoom =0.8;
            fixedCamFollow.y = 700;
            FlxG.camera.followLerp = 0;
            FlxG.camera.focusOn(fixedCamFollow.getPosition());
            new FlxTimer().start(0.01, function(tmr:FlxTimer)
                {
                    multi+= 0.1;
                    FlxG.camera.followLerp = 0.3;
                    FlxTween.tween(fixedCamFollow, {y: 300}, 1.5, {ease: FlxEase.expoOut});
                });
        case 1952:
            defaultCamZoom =0.5;
            fixedCamFollow.x = -400;
            fixedCamFollow.y = 300;
            FlxG.camera.followLerp = 0;
            FlxG.camera.focusOn(fixedCamFollow.getPosition());
            new FlxTimer().start(0.01, function(tmr:FlxTimer)
                {
                    defaultCamZoom = 0.7;
                    FlxG.camera.followLerp = 0.3;
                });
        case 2016,2032:
            defaultCamZoom = 0.7;
        case 2024:
            defaultCamZoom = 0.8;
        case 2038:
            defaultCamZoom = 0.76;
        case 2048:
            defaultCamZoom = 0.6;
            FlxG.camera.followLerp = 0.3;
            fixedCamFollow.x = 640 + 450;
            fixedCamFollow.y = 500;
        case 2111,2118,2124,2130,2136,2146,2150,2154,2158:
            fixedCamFollow.x = futo.getMidpoint().x;
            fixedCamFollow.y = 300;
            FlxG.camera.followLerp = 0;
            FlxG.camera.focusOn(fixedCamFollow.getPosition());
        case 2114,2120,2126,2132,2144,2148,2152,2156:
            fixedCamFollow.x = 640;
            fixedCamFollow.y = 500;
            FlxG.camera.focusOn(fixedCamFollow.getPosition());
        case 2159:
            defaultCamZoom = 0.5;
        case 2160:
            camZooming = false;
            zoomTween = FlxTween.tween(camGame, {zoom: 1}, 2.5, {ease: FlxEase.expoOut});
            FlxG.camera.target = smoothCamFollow;
            FlxG.camera.focusOn(smoothCamFollow.getPosition());
            FlxG.camera.followLerp = 0.3;
            cameraMovementStrength = 2;
        case 2176:
            camZooming = true;
            zoomTween.cancel();
            camHUD.flash(FlxColor.WHITE, 0.2);
            defaultCamZoom = 0.5;
            cameraMovementEnabled = true;
        case 2529:
            cameraMovementEnabled = false;
            defaultCamZoom = 0.6;
        case 2547:
            FlxTween.tween(eventbackground2, {alpha:1}, 1.5, {ease: FlxEase.expoOut});
            FlxTween.tween(camGame, {zoom: 1}, 2.5, {ease: FlxEase.expoOut});
        case 2557: //FUTO
            for(s in shaStrum) {
                s.alpha = 1;
             }
             for(s in futoStrum) {
                s.alpha = 1;
             }
             for(s in connerStrum) {
                s.alpha = 1;
             }
             for(s in daisyStrum) {
                s.alpha = 1;
             }
             futo.visible = conner.visible = daisy.visible = dad.visible = true;
             taeyai.x = 10;
             conner.setPosition(-725, 105);
             futo.setPosition(500, -25);
             futo.flipX = true;
             daisy.setPosition(100, -282.371);
             daisy.x += 200;
             daisy.flipX = true;
             taeyai.cameraOffset.x += 80;
             daisy.cameraOffset.x -= 300;
        case 2560:
            camHUD.flash(FlxColor.WHITE, 0.2);
            eventbackground2.visible = false;
            defaultCamZoom = 0.5;
            superZoomar = true;
        case 3328:
            camHUD.flash(FlxColor.WHITE, 0.2);
            superZoomar = false;
        case 3583:
            camHUD.flash(FlxColor.RED, 0.2);
            videomidsong('die');

            
    }
}
