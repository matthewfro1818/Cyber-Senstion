import funkin.game.cutscenes.Cutscene;
import hxvlc.flixel.FlxVideoSprite;
import funkin.game.cutscenes.ScriptedCutscene;
import funkin.game.cutscenes.VideoCutscene;
import flixel.util.FlxSave;
import funkin.backend.assets.ModsFolder;
var camLock:Bool = false;
var middle:Bool = false;
var looptime:Float = 0;

var videoCamera:FlxCamera;

var cutsceneCamera:FlxCamera;
var video:FlxVideoSprite;

function videomidsong(videoname) 
    {
        trace('playvide');
        if (video.load('mods/' + ModsFolder.currentModFolder + '/videos/' + videoname + '.mp4'))
            new FlxTimer().start(0.001, function(tmr:FlxTimer) {
                video.play();
            });
    }

function postCreate()
    {
        videoCamera = new FlxCamera();
        videoCamera.bgColor = 0;
        FlxG.cameras.add(videoCamera, false);
    
        video = new FlxVideoSprite(FlxAxes.X,FlxAxes.Y);
        video.cameras = [videoCamera];
    
        add(video);
    
        camZooming = false;
        camLock = true;
        var index = members.indexOf(boyfriend);
        eventbackground = new FlxSprite(0,0).makeGraphic(1280,720, 0xFF000000);
        eventbackground.alpha = 1;
        eventbackground.updateHitbox();
        eventbackground.scale.set(4,4);
        eventbackground.screenCenter(FlxAxes.X);
        eventbackground.scrollFactor.set();
        insert(index, eventbackground);

        eventwhite = new FlxSprite(0,0).makeGraphic(1280,720, 0xFFFFFFFF);
        eventwhite.alpha = 0;
        eventwhite.updateHitbox();
        eventwhite.scale.set(4,4);
        eventwhite.screenCenter(FlxAxes.X);
        eventwhite.scrollFactor.set();
        insert(index, eventwhite);

        eventbackground2 = new FlxSprite(dad.x,dad.y).makeGraphic(1280,720, 0xFF000000);
        eventbackground2.alpha = 1;
        eventbackground2.updateHitbox();
        eventbackground2.scale.set(4,4);
        eventbackground2.screenCenter(FlxAxes.X);
        eventbackground2.scrollFactor.set(1,1);
        add(eventbackground2);

        eventbackground3 = new FlxSprite(dad.x,dad.y).makeGraphic(1280,720, 0xFFFFFFFF);
        eventbackground3.alpha = 0;
        eventbackground3.updateHitbox();
        eventbackground3.scale.set(4,4);
        eventbackground3.screenCenter(FlxAxes.X);
        eventbackground3.scrollFactor.set(1,1);
        add(eventbackground3);

        cameffect = new FlxCamera();
        cameffect.bgColor = 0;
        FlxG.cameras.remove(camHUD, false);
        FlxG.cameras.remove(camNewHUD, false);
        FlxG.cameras.add(cameffect, false);
        FlxG.cameras.add(camHUD, false);
        FlxG.cameras.add(camNewHUD, false);
        

        

        if (FlxG.save.data.ShaderHigh) {
        spin = new CustomShader("coolbg");
        }
        image = new FlxSprite(0, 0).makeGraphic(1280,720, 0xFFFFFFFF);
        image.antialiasing = true;
        if (FlxG.save.data.ShaderHigh) {
        image.shader = spin;
        }
        image.setGraphicSize(FlxG.width, FlxG.height);
        image.updateHitbox();
        image.screenCenter(FlxAxes.XY);
        image.cameras = [cameffect];

        image.alpha = 0;

        add(image);

        dad.alpha = boyfriend.alpha = 0;

        camNewHUD.alpha  = 0;

        //Shader
       /* blur = new CustomShader("radialBlur");
        blur.cx =  0.5;
        blur.cy =  0.5;
        blur.blurWidth = 0.0;
        camGame.addShader(blur);
        camHUD.addShader(blur);
        camNewHUD.addShader(blur);*/

        var index = members.indexOf(dad);
        txtFX = new FunkinText(dad.x + 20, dad.y + 200, 0, 'エミコ', 46);
        txtFX.font = Paths.font("JP.ttf");
        txtFX.alignment = 'CENTER';
        txtFX.alpha = 0;
        //txtFX.x += FlxG.width + 700;
        insert(index, txtFX);

        FlxG.camera.zoom = 1;
        FlxG.camera.followLerp = 0;
        
        addMobileControls();
		mobileControls.visible = true;
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

function update(elapsed:Float)
{
    video.screenCenter(FlxAxes.XY);
    video.setGraphicSize(FlxG.width, FlxG.height);
    
    /*var sprite = image;
    if (FlxG.keys.pressed.J) sprite.x -= 5;
    if (FlxG.keys.pressed.L) sprite.x += 5;
    if (FlxG.keys.pressed.I) sprite.y -= 5;
    if (FlxG.keys.pressed.K) sprite.y += 5;
    if (FlxG.keys.pressed.O) trace(sprite);*/

    spin.iTime = (looptime += elapsed);
}

function onCameraMove(event) {
    var char = event.ratio >= 0.5 ? boyfriend : dad;
    if(curCameraTarget >= 0.5) char = boyfriend;
    else char = dad;

    if(camLock)
        {
            if(char == dad)
            {
                    camFollow.setPosition(dad.getMidpoint().x, dad.getMidpoint().y - 100);
                    FlxG.camera.focusOn(camFollow.getPosition());
            }
            else if(char == boyfriend)
            {
                    camFollow.setPosition(boyfriend.getMidpoint().x, boyfriend.getMidpoint().y + 200);
                    FlxG.camera.focusOn(camFollow.getPosition());
            }
            
        }

    if(middle)
    {
        camFollow.setPosition(boyfriend.getMidpoint().x - 500, boyfriend.getMidpoint().y - 80);
        FlxG.camera.focusOn(camFollow.getPosition());
    }
    
    
}


function bump()
    {
        FlxG.camera.zoom += 0.015;
        camHUD.zoom += 0.03;
    }

function stepHit()
{
        switch (curStep)
        {
            case 47:
                FlxTween.tween(eventbackground3, {alpha: 1}, 1, {ease: FlxEase.cubeIn});
            case 64:
                camHUD.flash(FlxColor.WHITE, 0.5);
                dad.alpha = boyfriend.alpha = 1;
                eventbackground2.alpha = eventbackground.alpha = 0;
                eventbackground3.alpha = 0;
                FlxTween.tween(eventbackground, {alpha: 0.5}, 1, {ease: FlxEase.cubeIn});
                camFollow.setPosition(550, 730);
            case 79:
                FlxTween.tween(txtFX, {x: txtFX.x + 300,alpha:1}, 1, {ease: FlxEase.backInOut});
            case 96:
                FlxTween.tween(txtFX, {x: txtFX.x + 300,alpha:0}, 2, {ease: FlxEase.backInOut});
                FlxG.camera.followLerp = 0;
            case 144:
                txtFX.text = 'ビーフ';
                txtFX.setPosition(boyfriend.x + 20,boyfriend.y + 400);
                FlxTween.tween(txtFX, {x: txtFX.x - 200,alpha:1}, 1, {ease: FlxEase.backInOut});
            case 160:
                FlxTween.tween(txtFX, {x: txtFX.x - 300,alpha:0}, 2, {ease: FlxEase.backInOut});
            case 175,179,184,188,191:
                camGame.flash(FlxColor.WHITE, 0.5);
            case 195:
                camLock = false;
                camGame.flash(FlxColor.WHITE, 0.5);
                eventbackground.alpha = 0;
                camZooming = true;
                FlxG.camera.followLerp = 0.04;
                FlxTween.tween(FlxG.camera, {zoom: 0.7},1, {ease: FlxEase.backInOut});
                FlxTween.tween(camHUD, {alpha: 1}, 1, {ease: FlxEase.cubeIn});
                FlxTween.tween(camNewHUD, {alpha:1},1, {ease: FlxEase.cubeIn});
                for(s in strumLines.members[0]) {
                    FlxTween.tween(s, {x:s.x + FlxG.width}, 1.5, {ease: FlxEase.expoOut});
                }
            
                for(s in strumLines.members[1]) {
                    FlxTween.tween(s, {x:s.x - FlxG.width}, 1.5, {ease: FlxEase.expoOut});
                }
            case 222:
                camZooming = false;
                FlxTween.tween(camGame, {zoom: 1},0.3, {ease: FlxEase.backInOut});
            case 260:
                FlxTween.tween(camGame, {zoom: 0.7},1, {ease: FlxEase.backInOut});
            case 285:
                FlxTween.tween(camGame, {zoom: 1},1, {ease: FlxEase.expoInOut});
            case 310:
                FlxG.camera.zoom = 1;
                FlxG.camera.followLerp = 0;
                camLock = true;
                eventbackground.alpha = 0.6;
            case 320:
                camLock = false;
                camZooming = true;
                FlxG.camera.followLerp = 0.04;
                camGame.flash(FlxColor.WHITE, 0.5);
                eventbackground.alpha = 0;
                FlxTween.tween(camGame, {zoom: 0.7},1, {ease: FlxEase.backInOut});
            case 442:
                
                camZooming = false;
                FlxG.camera.followLerp = 1;
                boyfriend.cameraOffset.x -= 300;
            case 448:
                camGame.flash(FlxColor.WHITE, 0.5);
                camZooming = true;
                middle = true;
                FlxG.camera.followLerp = 0;
            case 703:
                camGame.flash(FlxColor.WHITE, 0.5);
                camZooming = false;
                middle = false;
                FlxG.camera.followLerp = 0.04;
                FlxTween.tween(camGame, {zoom: 1},1, {ease: FlxEase.backInOut});
            case 736:
                camZooming = false;
                FlxG.camera.followLerp = 0.02;
            case 768:
                FlxTween.tween(eventbackground, {alpha: 0}, 1, {ease: FlxEase.cubeIn});
                middle = false;
                dad.cameraOffset.x -= 300;
                FlxG.camera.followLerp = 0.04;
                FlxTween.tween(camGame, {zoom: 0.8},1, {ease: FlxEase.backInOut});
            case 831:
                camGame.flash(FlxColor.WHITE, 0.5);
                camZooming = true;
                middle = true;
                 dad.cameraOffset.x += 300;
                 boyfriend.cameraOffset.x -= 300;
                FlxG.camera.followLerp = 0;
                FlxTween.tween(eventwhite, {alpha: 1}, 1, {ease: FlxEase.cubeIn});
                boyfriend.color = FlxColor.fromHSL(boyfriend.color.hue, boyfriend.color.saturation, 0.4, 0.4);
                dad.color = FlxColor.fromHSL(dad.color.hue, dad.color.saturation, 0.4, 0.4);
            case 1072:
                middle = false;
                camZooming = false;
                FlxG.camera.followLerp = 1;
                FlxTween.tween(camGame, {zoom: 1},1, {ease: FlxEase.backInOut});
                FlxTween.tween(eventbackground2, {alpha: 1},1, {ease: FlxEase.backInOut});
            case 1088:
                camGame.flash(FlxColor.WHITE, 0.5);
                camGame.alpha = 1;
                eventbackground2.alpha = 0;
                eventwhite.alpha = 0;
                middle = false;
                camZooming = true;
                FlxG.camera.followLerp = 0.04;
                FlxTween.tween(camGame, {zoom: 0.7},1, {ease: FlxEase.backInOut});
                boyfriend.color = FlxColor.fromHSL(boyfriend.color.hue, boyfriend.color.saturation, 1, 1);
                dad.color = FlxColor.fromHSL(dad.color.hue, dad.color.saturation, 1, 1);
            case 1344:
                boyfriend.cameraOffset.x += 300;
                camZooming = false;
                FlxG.camera.followLerp = 0.02;
                camHUD.flash(FlxColor.BLACK, 0.5);
                dad.colorTransform.redOffset = dad.colorTransform.greenOffset = dad.colorTransform.blueOffset = 255;
                boyfriend.colorTransform.redOffset = boyfriend.colorTransform.greenOffset = boyfriend.colorTransform.blueOffset = 255;
                eventbackground.alpha = 1;
            case 1591:
                FlxTween.tween(camGame, {zoom: 1},1, {ease: FlxEase.backInOut});
                FlxTween.tween(dad, {alpha: 0},1, {ease: FlxEase.backInOut});
                FlxTween.tween(boyfriend, {alpha: 0},1, {ease: FlxEase.backInOut});
                FlxTween.tween(camHUD, {alpha: 0},1, {ease: FlxEase.backInOut});
                FlxTween.tween(camNewHUD, {alpha: 0},1, {ease: FlxEase.backInOut});
                
                boyfriend.cameraOffset.x -= 300;
            case 1608:
                if(!FlxG.save.data.ShaderHigh)
                {
                videomidsong('osu');
                video.alpha = 1;
                }
                if (FlxG.save.data.ShaderHigh) {
                FlxTween.tween(image, {alpha: 1},1, {ease: FlxEase.backInOut});
                }
                FlxTween.tween(camHUD, {alpha: 1},1, {ease: FlxEase.backInOut});
                //FlxTween.tween(camNewHUD, {alpha: 1},1, {ease: FlxEase.backInOut});
            case 1888:
                if (!FlxG.save.data.ShaderHigh) {
                FlxTween.tween(video, {alpha: 0}, 0.4, {ease: FlxEase.circIn});
                }
                if (FlxG.save.data.ShaderHigh) {
                FlxTween.tween(image, {alpha: 0},1, {ease: FlxEase.backInOut});
                }
            case 1895:
                FlxTween.tween(camHUD, {alpha: 1},0.3, {ease: FlxEase.expoOut});
                FlxTween.tween(dad, {alpha: 1},1, {ease: FlxEase.backInOut});
                FlxTween.tween(boyfriend, {alpha: 1},1, {ease: FlxEase.backInOut});
                FlxTween.tween(camGame, {zoom: 0.7},1, {ease: FlxEase.backInOut});
            case 1904:
                camGame.flash(FlxColor.WHITE, 0.5);
                eventbackground.alpha = 0;
                middle = true;
                camZooming = true;
                dad.colorTransform.redOffset = dad.colorTransform.greenOffset = dad.colorTransform.blueOffset = 0;
                boyfriend.colorTransform.redOffset = boyfriend.colorTransform.greenOffset = boyfriend.colorTransform.blueOffset = 0;

            case 2160:
                camGame.flash(FlxColor.WHITE, 0.5);
                middle = false;
                camZooming = false;
                camGame.zoom = 1;
                camLock = true;
                eventbackground.alpha = 0.4;
                boyfriend.cameraOffset.x += 300;
            case 2176:
                camGame.flash(FlxColor.WHITE, 0.5);
                camGame.zoom = 0.7;
                boyfriend.cameraOffset.x -= 300;
                camLock = false;
                FlxTween.tween(camGame, {zoom: 1},1, {ease: FlxEase.backInOut});
                FlxTween.tween(eventbackground2, {alpha: 1},2, {ease: FlxEase.backOut});
                
                
                
        }
}

function onNoteHit(event)
    {
        event.enableCamZooming = false;
    }