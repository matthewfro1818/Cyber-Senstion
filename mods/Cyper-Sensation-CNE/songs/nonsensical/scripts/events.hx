import flixel.FlxObject;
import flixel.util.FlxSave;
import funkin.backend.assets.ModsFolder;
public var superZoomShit:Bool = false;
public var supersuperZoomShit:Bool = false;
public var zoomar:Bool = false;

var colorTransformShader:CustomShader;
public var funcam:FlxCamera;
var camLock:Bool;
var multi:Float = 1;
var looptime:Float = 0;
var stopcam:Bool;
var middle:Bool;
var side:Bool = false;

var strumLerp = 0.1;
var strumOrder = [0, 1, 2, 3];
var strumPos = [[736, 50], [848, 50], [960, 50], [1072, 50]];
var strumPos2 = [[96, 50], [208, 50], [320, 50], [432, 50]];
function postCreate() {
	cameraMovementEnabled=false;
	colorTransformShader = new CustomShader("colorTransform");
	colorTransformShader.redMultiplier = 1;
	colorTransformShader.greenMultiplier = 1;
	colorTransformShader.blueMultiplier = 1;
	colorTransformShader.alphaMultiplier = 1;
	colorTransformShader.redOffset = 0;
	colorTransformShader.greenOffset = 0;
	colorTransformShader.blueOffset = 0;
	colorTransformShader.alphaOffset = 0;
	camGame.addShader(colorTransformShader);


    screen = new CustomShader("split-screen");
    screen.multi = 1;
    camGame.addShader(screen);

    loops = new CustomShader("loop");
    if (FlxG.save.data.ShaderHigh) {
    distortion = new CustomShader("distortion");
    spin = new CustomShader("spinbg");
    }
    beatbg = new CustomShader("beatbg");
    disbg = new CustomShader("dis");
    //screen.multi = 1;
    
    cameffect = new FlxCamera();
    cameffect.bgColor = 0;


    camChar = new FlxCamera();
    camChar.bgColor = 0;
    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.add(camChar, false);
    FlxG.cameras.add(camHUD, false);
    FlxG.cameras.add(cameffect, false);
    
    image = new FlxSprite(0, 0);
    image.antialiasing = true;
    image.loadGraphic(Paths.image('game/pause/hologram'));
    image.blend = 9;
    if (FlxG.save.data.ShaderHigh) {
    image.shader = spin;
    }
    //image.setGraphicSize(FlxG.width * 1.4, FlxG.height * 1.4);
    image.updateHitbox();
    image.screenCenter(FlxAxes.XY);
    image.cameras = [cameffect];
    image.visible =false;
    add(image);

    image2 = new FlxSprite(-2225, -1215);
    image2.antialiasing = true;
    image2.loadGraphic(Paths.image('game/pause/hologram'));
    //image2.blend = 9;
    image2.shader = beatbg;
    image2.setGraphicSize(FlxG.width * 5, FlxG.height * 5);
    image2.updateHitbox();
    image2.cameras = [camGame];
    image2.visible = false;
    insert(members.indexOf(boyfriend), image2);

    image3 = new FlxSprite(0, 0);
    image3.antialiasing = true;
    image3.loadGraphic(Paths.image('noise'));
    image3.blend = 9;
    image3.shader = disbg;
    image3.setGraphicSize(FlxG.width, FlxG.height);
    image3.updateHitbox();
    image3.screenCenter(FlxAxes.XY);
    image3.cameras = [cameffect];
    image3.alpha = 0.1;
    image3.visible =false;
    add(image3);

    non = new Character(100,100,dad.curCharacter,false);
    stage.applyCharStuff(non,cpuStrums.data.position,0);
    non.cameras = [camChar];
    non.y += FlxG.height;
    //strumLines.members[0].characters = [dad,non];
    add(non);

    tae = new Character(100,100,boyfriend.curCharacter,boyfriend.isPlayer);
    stage.applyCharStuff(tae,playerStrums.data.position,1);
    tae.x -= 300;
    tae.y += FlxG.height;
    tae.cameras = [camChar];
    //strumLines.members[1].characters = [boyfriend,tae];
    add(tae);

    iLikeToMoveItMoveIt = new CustomShader('i like to move it move it');
    camGame.addShader(iLikeToMoveItMoveIt);

    scream = new FlxSprite(0, 0);
    scream.antialiasing = true;
    scream.loadGraphic(Paths.image('scream'));
    scream.blend = 8;
    
    scream.updateHitbox();
    scream.screenCenter(FlxAxes.XY);
    scream.x += 90;
    scream.cameras = [camNewHUD];

    scream.alpha = 0;
    //scream.visible =false;
    add(scream);
}

function screamit()
{
    FlxTween.tween(scream, {alpha: 1}, 0.2, {ease: FlxEase.expoOut});
    scream.scale.set(1,1);
    new FlxTimer().start(0.3, function(tmr:FlxTimer)
        {
            
            FlxTween.tween(scream, {alpha: 0}, 0.2, {ease: FlxEase.expoOut,
                onComplete: function(twn:FlxTween)
                {
                    FlxTween.tween(scream, {alpha: 1}, 0.2, {ease: FlxEase.expoOut,
                        onComplete: function(twn:FlxTween)
                        {
                            FlxTween.tween(scream, {alpha: 0}, 0.2, {ease: FlxEase.expoOut,
                                onComplete: function(twn:FlxTween)
                                {
                                    FlxTween.tween(scream, {alpha: 1}, 0.2, {ease: FlxEase.expoOut,
                                        onComplete: function(twn:FlxTween)
                                        {
                                            FlxTween.tween(scream, {alpha: 0}, 0.2, {ease: FlxEase.expoOut});
                                        }});
                                    scream.scale.set(3.1,3.1);
                                }});
                        }});
                    scream.scale.set(2.1,2.1);
                }});
        });
}

function onSongStart()
    {
      
    }

function postUpdate(elapsed) {
    if (FlxG.keys.pressed.J) image2.x -= 5;
    if (FlxG.keys.pressed.L) image2.x += 5;
    if (FlxG.keys.pressed.I) image2.y -= 5;
    if (FlxG.keys.pressed.K) image2.y += 5;
    if (FlxG.keys.pressed.O) trace(image2);
	if ((curBeat >= 36 && curBeat < 212) || curBeat >= 292 && curBeat < 596 || (curBeat >= 612 && curBeat < 804)) {
		var mul:Float = 1 + ((1 - ((curBeatFloat / 1) % 1)) * (1/3));
		
		colorTransformShader.redMultiplier = mul;
		colorTransformShader.greenMultiplier = mul;
		colorTransformShader.blueMultiplier = mul;
	} else {
		colorTransformShader.redMultiplier = 1;
		colorTransformShader.greenMultiplier = 1;
		colorTransformShader.blueMultiplier = 1;
	}
    camHUD.angle = lerp(camHUD.angle, 0, 0.125);

   

    loops.iTime = (looptime += elapsed);
    if (FlxG.save.data.ShaderHigh) {
    distortion.iTime = (looptime += elapsed);
    spin.iTime = (looptime += elapsed);
    }
    beatbg.iTime = (looptime += elapsed);
    disbg.iTime = (looptime += elapsed);
    iLikeToMoveItMoveIt.iTime = (looptime += elapsed);

    if(curBeat >= 31 && curBeat < 36)
        {
            scream.alpha += 0.01;
            scream.scale.x += 0.01;
            scream.scale.y += 0.01;
        }

//468
    if(curBeat >= 468 && curBeat < 500)
    {
        for(s in strumLines.members[0]) {
            s.x = (Note.swagWidth * (s.ID + 5)) + (400 * Math.sin((curBeatFloat + s.ID) * Math.PI / 17));
            s.y = (20 * Math.sin((curBeatFloat + s.ID) * Math.PI / 4));
        }
    
        for(s in strumLines.members[1]) {
            s.x = (Note.swagWidth * (s.ID + 4)) - (400 * Math.sin((curBeatFloat - s.ID) * Math.PI / 17));
            s.y = (20 * Math.sin((curBeatFloat + s.ID) * Math.PI / 4));
            
        }
    }
//500
    if(curBeat >= 500)
    {
        if(FlxG.save.data.MiddleScroll)
        {
        // Player MiddleScroll
        strumLines.members[1].members[0].setPosition(420,50);
        strumLines.members[1].members[1].setPosition(526,50);
        strumLines.members[1].members[2].setPosition(630,50);
        strumLines.members[1].members[3].setPosition(736,50);
        
        // Opponent MiddleScroll
        strumLines.members[0].members[0].setPosition(80,50);
        strumLines.members[0].members[1].setPosition(186,50);
        strumLines.members[0].members[2].setPosition(965,50);
        strumLines.members[0].members[3].setPosition(1071,50);
    }
        if (!FlxG.save.data.MiddleScroll) {
        for (s in strumLines.members[0]) {
            s.x = lerp(s.x, strumPos2[strumOrder[s.ID]][0], strumLerp);
            s.y = lerp(s.y, strumPos2[strumOrder[s.ID]][1], strumLerp);
        }

        for (s in strumLines.members[1]) {
            s.x = lerp(s.x, strumPos[strumOrder[s.ID]][0], strumLerp);
            s.y = lerp(s.y, strumPos[strumOrder[s.ID]][1], strumLerp);
        }
        }
    }
        if (curBeat >= 500 && curBeat < 548) {
            iLikeToMoveItMoveIt.offset = [(Std.int(curBeatFloat) + FlxEase.cubeOut(curBeatFloat % 1)) * 0.5 * (side ? -1 : 1), 0];
        }
    
        if (curBeat < 548) {
            iLikeToMoveItMoveIt.ratio = 1-FlxEase.cubeIn(FlxMath.bound((500 - curBeatFloat) / 2, 0, 1));
        } else {
            iLikeToMoveItMoveIt.ratio = 1-FlxEase.cubeOut(FlxMath.bound((curBeatFloat - 548) / 2, 0, 1));
        }

        switch(dad.getAnimName()) {
            case "singLEFT":  non.playAnim('singLEFT');
            case "singDOWN":  non.playAnim('singDOWN');
            case "singUP":    non.playAnim('singUP');
            case "singRIGHT": non.playAnim('singRIGHT');
        }
    
        switch(boyfriend.getAnimName()) {
            case "singLEFT":  tae.playAnim('singLEFT');
            case "singDOWN":  tae.playAnim('singDOWN');
            case "singUP":    tae.playAnim('singUP');
            case "singRIGHT": tae.playAnim('singRIGHT');
        }
}

function onCameraMove(event) {
    var char = event.ratio >= 0.5 ? boyfriend : dad;
    if(curCameraTarget >= 0.5) char = boyfriend;
    else char = dad;

    if(camLock)
        {
            if(char == dad)
            {
                
                if(stopcam)
                {
                        camFollow.setPosition(400, 450);
                        FlxG.camera.focusOn(camFollow.getPosition());
                }
                else if(middle)
                {
                    camFollow.setPosition(730, 450);
                    FlxG.camera.focusOn(camFollow.getPosition());
                }
                else
                {
                    camFollow.setPosition(dad.getMidpoint().x, dad.getMidpoint().y - 100);
                    FlxG.camera.focusOn(camFollow.getPosition());
                }
            }
            else if(char == boyfriend)
            {
                if(stopcam)
                    {
                            camFollow.setPosition(700, 500);
                            FlxG.camera.focusOn(camFollow.getPosition());
                    }
                    else if(middle)
                        {
                            camFollow.setPosition(730, 450);
                            FlxG.camera.focusOn(camFollow.getPosition());
                        }
                    else
                    {
                        camFollow.setPosition(boyfriend.getMidpoint().x, boyfriend.getMidpoint().y);
                        FlxG.camera.focusOn(camFollow.getPosition()); 
                    }

            }
            
        }
    
    
}

function stepHit()
    {
        switch(curStep)
        {
            case 1:
                camLock = true;
                camHUD.flash(FlxColor.WHITE, 0.2);
               
                /*stopcam = true;
                tween1 = FlxTween.tween(dad, {y: dad.y + FlxG.height, alpha: 0}, 0.6, {ease: FlxEase.elasticOut,
                    onComplete: function(twn:FlxTween)
                    {
                        dad.y -= FlxG.height;
                        stopcam = false;
                    }});
                tween = FlxTween.tween(non, {y: non.y - FlxG.height}, 0.6, {ease: FlxEase.elasticOut});*/
            case 80,82,96,99,112,114,120,122,129,131:
            FlxG.camera.zoom += 0.06;
            camHUD.zoom += 0.08;
            case 140:
                tween = FlxTween.tween(FlxG.camera, {zoom: 0.5}, 0.4, {ease: FlxEase.quadInOut});
                tween2 = FlxTween.tween(FlxG.camera, {angle: 10}, 0.4, {ease: FlxEase.quadInOut});
            case 144:
                tween.cancel();
                tween2.cancel();
                camHUD.flash(FlxColor.WHITE, 0.2);
                FlxG.camera.zoom = 0.8;
                FlxG.camera.angle = 0;
        }
    }

function beatHit()
{
    if (curBeat == 4) {
        for (a in 0...strumLines.members.length) {
            for (b in 0...4) {
                trace("strumline " + a + ", strum " + b + " at " + strumLines.members[a].members[b].x, strumLines.members[a].members[b].y);
            }
        }
    }

    switch(curBeat)
    {
        case 4,12:
            FlxG.camera.zoom += 0.06;
            camHUD.zoom += 0.08;
        case 36:
            superZoomShit = true;
            scream.alpha = 0;
            camLock = false;
            cameraMovementEnabled = true;
        case 84:
            camHUD.flash(FlxColor.WHITE, 0.2);
            superZoomShit = false;
            zoomar = true;
        case 112:
            tween = FlxTween.tween(FlxG.camera, {zoom: 1}, 3, {ease: FlxEase.quadInOut});
            tween2 = FlxTween.tween(FlxG.camera, {angle: 10}, 3, {ease: FlxEase.quadInOut});
         case 116:

            camHUD.flash(FlxColor.WHITE, 0.2);
            zoomar = false;
            supersuperZoomShit = true;
            tween.cancel();
            tween2.cancel();
            FlxG.camera.zoom = 0.8;
            FlxG.camera.angle = 0;
        case 164:
            camHUD.flash(FlxColor.WHITE, 0.2);
            supersuperZoomShit = false;
            superZoomShit = true;
        case 196:
            camHUD.flash(FlxColor.WHITE, 0.2);
            superZoomShit = false;
            supersuperZoomShit = true;
        case 212:
            camHUD.flash(FlxColor.WHITE, 0.2);
            supersuperZoomShit = false;
            tween = FlxTween.tween(FlxG.camera, {zoom: 1}, 10, {ease: FlxEase.quadInOut});
        case 228:
            camHUD.flash(FlxColor.WHITE, 0.2);
            camLock = true;
            cameraMovementEnabled = false;
            tween = FlxTween.tween(non, {y: non.y - FlxG.height}, 0.6, {ease: FlxEase.elasticOut});
        case 256:
            tween.cancel();
            camHUD.flash(FlxColor.WHITE, 0.2);
            FlxG.camera.zoom = 0.8;
            screamit();
        case 260:
            tween = FlxTween.tween(FlxG.camera, {zoom: 1}, 10, {ease: FlxEase.quadInOut});
            tween2 = FlxTween.tween(non, {y: non.y + FlxG.height}, 0.6, {ease: FlxEase.elasticOut});
            tween3 = FlxTween.tween(tae, {y: tae.y - FlxG.height}, 0.6, {ease: FlxEase.elasticOut});
        case 288:
            screamit();
        case 292:
            tween2 = FlxTween.tween(non, {y: non.y - FlxG.height}, 0.6, {ease: FlxEase.elasticOut});
           
            screen.multi = 1;
            supersuperZoomShit = true;
            camGame.addShader(loops);
            if (FlxG.save.data.ShaderHigh) {
            camGame.addShader(distortion);
            camHUD.addShader(distortion);
            }
            camHUD.flash(FlxColor.WHITE, 0.2);
            FlxG.camera.zoom = 0.8;
        case 320:
            screamit();
        case 352:
            screamit();
        case 356:
            tween2 = FlxTween.tween(non, {y: non.y + FlxG.height}, 0.6, {ease: FlxEase.elasticOut});
            tween3 = FlxTween.tween(tae, {y: tae.y + FlxG.height}, 0.6, {ease: FlxEase.elasticOut});
            camHUD.flash(FlxColor.WHITE, 0.2);
            camGame.removeShader(loops);
            FlxG.camera.zoom = 0.8;
            supersuperZoomShit = false;
            image.visible =true;
            superZoomShit = true;
            camLock = false;
            cameraMovementEnabled = true;
        case 418:
            camHUD.flash(FlxColor.WHITE, 0.2);
            image.visible =false;
            superZoomShit = false;
            if (FlxG.save.data.ShaderHigh) {
            camGame.removeShader(distortion);
            }
            tween = FlxTween.tween(FlxG.camera, {zoom: 1}, 1, {ease: FlxEase.quadInOut});
            tween2 = FlxTween.tween(FlxG.camera, {angle: 10}, 1, {ease: FlxEase.quadInOut});
        case 420:
            camHUD.flash(FlxColor.WHITE, 0.2);
            FlxG.camera.zoom = 0.4;
            defaultCamZoom = 0.4;
            tween.cancel();
            tween2.cancel();
            FlxG.camera.zoom = 0.8;
            FlxG.camera.angle = 0;
            supersuperZoomShit = true;
            image2.visible = true;
            middle = true;
            image3.visible = true;
            camLock = true;
            cameraMovementEnabled = false;
        case 468:
            camHUD.flash(FlxColor.WHITE, 0.2);
        case 500:
            tween2 = FlxTween.tween(non, {y: non.y - FlxG.height}, 0.6, {ease: FlxEase.elasticOut});
            tween3 = FlxTween.tween(tae, {y: tae.y - FlxG.height}, 0.6, {ease: FlxEase.elasticOut});
        case 548:
            tween2 = FlxTween.tween(non, {y: non.y + FlxG.height}, 0.6, {ease: FlxEase.elasticOut});
            tween3 = FlxTween.tween(tae, {y: tae.y + FlxG.height}, 0.6, {ease: FlxEase.elasticOut});      
        case 580:
            camHUD.flash(FlxColor.WHITE, 0.2);
            FlxG.camera.zoom = 0.8;
            defaultCamZoom = 0.8;
            image3.visible =false;
            image2.visible =false;
            stopcam = true;
            tween1 = FlxTween.tween(dad, {y: dad.y + FlxG.height, alpha: 0}, 0.6, {ease: FlxEase.elasticOut,
                onComplete: function(twn:FlxTween)
                {
                    dad.y -= FlxG.height;
                    stopcam = false;
                }});
            tween = FlxTween.tween(non, {y: non.y - FlxG.height}, 0.6, {ease: FlxEase.elasticOut});
            tween2 = FlxTween.tween(boyfriend, {y: boyfriend.y + FlxG.height, alpha: 0}, 0.6, {ease: FlxEase.elasticOut,
                onComplete: function(twn:FlxTween)
                {
                    boyfriend.y -= FlxG.height;
                    stopcam = false;
                }});
            tween3 = FlxTween.tween(tae, {y: tae.y - FlxG.height}, 0.6, {ease: FlxEase.elasticOut});
        case 596:
            camHUD.flash(FlxColor.WHITE, 0.6);
            supersuperZoomShit = false;
            tweenzoom = FlxTween.tween(FlxG.camera, {zoom: 1}, 10, {ease: FlxEase.quadInOut});
            dad.y += FlxG.height;
            tween1 = FlxTween.tween(dad, {y: dad.y - FlxG.height, alpha: 1}, 0.6, {ease: FlxEase.elasticOut,
                onComplete: function(twn:FlxTween)
                {
                    middle = false;
                }});
            tween = FlxTween.tween(non, {y: non.y + FlxG.height}, 0.6, {ease: FlxEase.elasticOut});

            boyfriend.y += FlxG.height;
            tween2 = FlxTween.tween(boyfriend, {y: boyfriend.y - FlxG.height, alpha: 1}, 0.6, {ease: FlxEase.elasticOut,
                onComplete: function(twn:FlxTween)
                {

                }});
            tween3 = FlxTween.tween(tae, {y: tae.y + FlxG.height}, 0.6, {ease: FlxEase.elasticOut});
        case 612:
            camHUD.flash(FlxColor.WHITE, 0.2);
            tween = FlxTween.tween(non, {y: non.y - FlxG.height}, 0.6, {ease: FlxEase.elasticOut});
       
        case 640:
            screamit();
            tweenzoom.cancel();
            camHUD.flash(FlxColor.WHITE, 0.2);
            FlxG.camera.zoom = 0.8;
        case 644:
            camHUD.flash(FlxColor.WHITE, 0.2);
            tween = FlxTween.tween(FlxG.camera, {zoom: 1}, 10, {ease: FlxEase.quadInOut});
            tween2 = FlxTween.tween(tae, {y: tae.y - FlxG.height}, 0.6, {ease: FlxEase.elasticOut});
            tween3 = FlxTween.tween(non, {y: non.y + FlxG.height}, 0.6, {ease: FlxEase.elasticOut});
        case 672,736:
            screamit();
        case 676:
            tween2 = FlxTween.tween(non, {y: non.y - FlxG.height}, 0.6, {ease: FlxEase.elasticOut});

            screen.multi = 1;
            supersuperZoomShit = true;
            camGame.addShader(loops);
            if (FlxG.save.data.ShaderHigh) {
            camGame.addShader(distortion);
            camHUD.addShader(distortion);
            }
            camHUD.flash(FlxColor.WHITE, 0.2);
            FlxG.camera.zoom = 0.8;
        case 740:
            camHUD.flash(FlxColor.WHITE, 0.2);
            camGame.removeShader(loops);
            FlxG.camera.zoom = 0.8;
            supersuperZoomShit = true;
            image.visible =true;
            superZoomShit = true;
            camLock = false;
            cameraMovementEnabled = true;
            tween2 = FlxTween.tween(non, {y: non.y + FlxG.height}, 0.6, {ease: FlxEase.elasticOut});
            tween3 = FlxTween.tween(tae, {y: tae.y + FlxG.height}, 0.6, {ease: FlxEase.elasticOut});
            
        case 800:
            tween = FlxTween.tween(FlxG.camera, {zoom: 1}, 3, {ease: FlxEase.quadInOut});
            tween2 = FlxTween.tween(FlxG.camera, {angle: 10}, 3, {ease: FlxEase.quadInOut});
        case 804:
            camHUD.flash(FlxColor.WHITE, 0.2);
            FlxG.camera.zoom = 0.8;
            FlxG.camera.angle = 0;
            
            image.visible =false;
            superZoomShit = false;
            if (FlxG.save.data.ShaderHigh) {
            camGame.removeShader(distortion);
            }
            
        case 808:
            tween.cancel();
            tween2.cancel();
            tween = FlxTween.tween(FlxG.camera, {zoom: 0.8}, 1, {ease: FlxEase.quadInOut});
            tween2 = FlxTween.tween(FlxG.camera, {angle: 0}, 1, {ease: FlxEase.quadInOut});

    }

    if (curBeat >= 228 && curBeat <= 256) {
        multi += 1;
        screen.multi = multi;
        FlxG.camera.zoom += 0.09;
        camHUD.zoom += 0.08;
     }

     if (curBeat >= 612 && curBeat <= 640) {
        multi += 1;
        screen.multi = multi;
        FlxG.camera.zoom += 0.09;
        camHUD.zoom += 0.08;
     }

     if (curBeat >= 260 && curBeat <= 288) {
        multi -= 1;
        screen.multi = multi;

        FlxG.camera.zoom += 0.09;
        camHUD.zoom += 0.08;
     }

     if (curBeat >= 644 && curBeat <= 672) {
        multi -= 1;
        screen.multi = multi;

        FlxG.camera.zoom += 0.09;
        camHUD.zoom += 0.08;
     }

    if (curBeat % 2 == 0 && superZoomShit)
        {
            FlxG.camera.zoom += 0.06;
            camHUD.zoom += 0.08;
        }

        if (curBeat % 1 == 0 && supersuperZoomShit)
        {
            FlxG.camera.zoom += 0.06;
            camHUD.zoom += 0.08;
        }
    if (curBeat % 4 == 0 && FlxG.camera.zoom < 1.35 && zoomar)
        {
            FlxG.camera.zoom += 0.015;
            camHUD.zoom += 0.03;
        }
}