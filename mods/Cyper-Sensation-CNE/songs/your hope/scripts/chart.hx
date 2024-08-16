/*
        /\    /\  
       /  \  /  \ 
      /    \/    \
     / /  \  /  \ \
    |--  0 -- 0  --|
    |  \  /  \  /  |
     \     /\     /
      \__________/

    im in your walls
*/

var bg:FlxSprite;
var vignette:FlxSprite;
var shockTime:Float = 0;
var distortionScale1:Float = 0;
var useShock:Bool = false;
function onCountdown(event:CountdownEvent) {
    event.cancelled = true;
}

function postCreate() {
    bg = new FlxSprite(-FlxG.width, -FlxG.height).makeGraphic(1, 1, 0xFF000000);
    bg.scale.set(FlxG.width * 4, FlxG.height * 4);
    bg.scrollFactor.set();
    bg.cameras = [camHUD];
    add(bg);

    vignette=new FlxSprite().loadGraphic(Paths.image('stages/room/vignette'));
    vignette.screenCenter();
    vignette.cameras=[camHUD];
    vignette.alpha=0;
    vignette.scrollFactor.set();
    add(vignette);


    FlxG.camera.zoom = 0.65;
    dad.visible = false;


    shockwave = new FunkinShader(Assets.getText(Paths.fragShader("shockwave")));
    shockwave.enabled = true;
    camGame.addShader(shockwave);

    fishZoom = new FunkinShader(Assets.getText(Paths.fragShader("fish")));
	camGame.addShader(fishZoom);
    camHUD.addShader(fishZoom);
    camNewHUD.addShader(fishZoom);
    fishZoom.distortionScale = 0;

    camFollow.setPosition(-100, -900);
    camGame.scroll.set(-100,-900);

    glitch = new CustomShader('screenglitch');
    glitch.enabled = false;
    camGame.addShader(glitch);
    camHUD.addShader(glitch);
    camNewHUD.addShader(glitch);

    cameffect = new FlxCamera();
    cameffect.bgColor = 0;


    eventwhite = new FlxSprite(0,0).makeGraphic(1280,720, 0xFFFFFFFF);
    eventwhite.alpha = 0;
    eventwhite.updateHitbox();
    eventwhite.scale.set(4,4);
    eventwhite.screenCenter();
    eventwhite.scrollFactor.set();
    eventwhite.cameras = [cameffect];
    add(eventwhite);

    camfx = new FlxCamera();
    camfx.bgColor = 0;
    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.remove(camNewHUD, false);
    FlxG.cameras.add(camfx, false);
    FlxG.cameras.add(camNewHUD, false);
    FlxG.cameras.add(camHUD, false);
    FlxG.cameras.add(cameffect, false);

    bleh = new FlxSprite(0,0).loadGraphic(Paths.image('flash/'+FlxG.random.int(0,8)));
    bleh.scrollFactor.set(0, 0);
    bleh.alpha = 0;
    bleh.cameras = [camfx];
    bleh.setGraphicSize(FlxG.width, FlxG.height);
    bleh.screenCenter(FlxAxes.XY);
    add(bleh);

    for(i in 0...8)
    {
        bleh.loadGraphic((Paths.image('flash/'+i)));
    }
    

    coolText = new FunkinText(0,0,0,'', 26, true);
    coolText.screenCenter();
    coolText.antialiasing = true;
    coolText.borderSize = 3;
    coolText.font = Paths.font("freeplay.ttf");
    coolText.cameras = [camfx];
    add(coolText);

    //Make Next Song play as BF
    if(PlayState.isStoryMode)
    {
        FlxG.save.data.bfmode = true;
    }
    

}
var t:FlxTween;
var t2:FlxTween;
function flashback(which:Int)
    {
        
        bleh.loadGraphic(Paths.image('flash/'+which));
        bleh.alpha = 0.5;
        bleh.setGraphicSize(FlxG.width, FlxG.height);
        bleh.screenCenter(FlxAxes.XY);
        if(t != null) {t.cancel();}
        t = FlxTween.tween(bleh, {alpha: 0}, 1,{ease: FlxEase.cubeIn});
    }

function textup(what:String)
    {
        
        coolText.text = what;
        coolText.alpha = 1;
        coolText.screenCenter(FlxAxes.XY);
        if(t2 != null) {t.cancel();}
        t2 = FlxTween.tween(coolText, {alpha: 0}, 1,{ease: FlxEase.cubeIn});
    }

function onSongStart() {
    FlxTween.tween(bg, {alpha: 0}, Conductor.crochet / 1000 * 32);

    FlxG.camera.followLerp = 0.002;
    canvas2.alpha = 0;
}

function postUpdate(elapsed) {
    distortionScale1 = lerp(distortionScale1,0,0.125);
    fishZoom.distortionScale = distortionScale1;
}

var time:Float = 0;
function update(elapsed:Float) {
    if(useShock)
    {
        shockTime += elapsed;
    }
    time += elapsed;
    glitch.iTime = time;

    shockwave.iTime = shockTime;
    if (curBeat < 134) {
        FlxG.camera.zoom = FlxMath.lerp(0.65, 1.35, FlxEase.cubeIn(curBeatFloat / 130));
        camZooming = false;
    }
}

function onPostGenerateStrums() {
    for(e in cpuStrums.members)
        e.visible = false;
} 

function hitGlitch(howlong:Float)
{
    glitch.enabled = true;

    new FlxTimer().start(howlong, function(tmr:FlxTimer)
    {
        glitch.enabled = false;
    });
}

function hardKick()
{
    shockTime = 0;
    distortionScale1 += 2;
    useShock = true;
    new FlxTimer().start(0.4, function(tmr:FlxTimer)
        {
            useShock = false;
        });
}

function beatHit(curBeat) {
    switch(curBeat) {
        case 40:
            FlxTween.tween(camfx, {zoom: 2}, Conductor.crochet / 1000 * 72);
        case 72:
            camfx.zoom = 1;
            FlxTween.tween(camfx, {zoom: 2}, Conductor.crochet / 1000 * 136);
        case 134:
            FlxTween.tween(FlxG.camera, {zoom:0.8}, 0.5, {ease: FlxEase.cubeInOut});
            FlxTween.tween(camHUD, {alpha:0}, 0.5);
            FlxTween.tween(camNewHUD, {alpha:0}, 0.5);
        case 139:
            curCameraTarget = 0;
            camHUD.flash(FlxColor.WHITE, 0.5);
            tinyPopup();
            distortionScale2 = 4;
            FlxG.camera.followLerp = 0.04;
            camHUD.alpha = camNewHUD.alpha = 1;
    }

    if ((curBeat >= 210  && curBeat < 233) || (curBeat>=241 && curBeat<265)){
        FlxG.camera.zoom += 0.03;
        camHUD.zoom += 0.06;
    }
    if((curBeat>=465 && curBeat< 489) || (curBeat>=497 && curBeat<521))
        {
            FlxG.camera.zoom += 0.015;
            camHUD.zoom += 0.03;
        }
}

function forceZoom(howmuch:Float,?reset:Bool = false)
{
    camZooming = false;
    FlxG.camera.zoom += howmuch;
    if(reset)
        camZooming = true;
}

var oneBeat:Float = (Conductor.crochet * 0.5) / 1000;

function stepHit(curStep)
    {
        switch(curStep)
        {
            case 161:
                FlxG.camera.followLerp = 0.02;
                
            case 576:
                camHUD.flash(FlxColor.WHITE, 0.5);
            case 804:
                defaultCamZoom= 0.9;
            case 1101:
                defaultCamZoom=1.03;
                FlxTween.tween(vignette, {alpha:0.6},0.6);
            case 1349:
                FlxTween.tween(vignette, {alpha:0}, 0.5);

            case 1476:
                defaultCamZoom=1.2;
            case 1588:
                defaultCamZoom= 1.3;
            case 838, 1605,1736:
                defaultCamZoom=0.75;
            case 1700:
                defaultCamZoom= 1.1;
            case 1828:
               FlxTween.tween(FlxG.camera, {zoom: 1.3}, 2.6, {
                ease: FlxEase.quadInOut,
                onComplete: function(twn:FlxTween)
                {
                    defaultCamZoom = 0.75;
                   cameraMovementEnabled=true;
                }
            });
            case 1957:
                defaultCamZoom= 1.1;
               cameraMovementEnabled=false;
            case 1988:
                defaultCamZoom=0.75;
               cameraMovementEnabled=true;
            case 2240:
               cameraMovementEnabled=false;
                FlxTween.tween(camHUD, {alpha:0}, 2.6);
                FlxTween.tween(camNewHUD, {alpha:0}, 2.6);
            case 2369:
                FlxTween.tween(camGame, {alpha:0}, 2.6);
        }
    }

function tinyPopup() {
    for(e in cpuStrums.members) {
        var oldScaleX = e.scale.x;
        var oldScaleY = e.scale.y;
        e.visible = true;
        e.scale.y = 0;
        e.scale.x *= 1.5;
        e.colorTransform.alphaMultiplier = 0;
        e.colorTransform.redMultiplier = e.colorTransform.greenMultiplier = e.colorTransform.blueMultiplier = 0.5;
        e.colorTransform.redOffset = 55;
        e.colorTransform.greenOffset = e.colorTransform.blueOffset = 255;
        FlxG.camera.shake(0.005, 0.5);
        FlxTween.tween(e.colorTransform, {alphaMultiplier: 1}, Conductor.crochet / 1000, {ease: FlxEase.quintOut});
        FlxTween.tween(e.scale, {y: oldScaleY}, Conductor.crochet / 1000, {ease: FlxEase.elasticOut});
        FlxTween.tween(e.scale, {x: oldScaleX}, Conductor.crochet / 2000, {ease: FlxEase.cubeOut});
        FlxTween.tween(e.colorTransform, {redOffset: 0, greenOffset: 0, blueOffset: 0, redMultiplier: 1, greenMultiplier: 1, blueMultiplier: 1}, Conductor.crochet / 250, {startDelay: Conductor.crochet / 500, ease: FlxEase.quintOut});
        defaultCamZoom= 0.74;
    }

    canvas2.alpha = 0.3;
    dad.visible = true;
}
