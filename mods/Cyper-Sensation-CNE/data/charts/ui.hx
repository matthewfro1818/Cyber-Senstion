
if(PlayState.SONG.meta.displayName == 'credits') return;
import funkin.ui.FunkinText;
import flixel.text.FlxTextBorderStyle;
import flixel.ui.FlxBar;
import flixel.math.FlxRect;
import flixel.system.ui.FlxSoundTray;
import flixel.sound.FlxSound;
import openfl.display.Bitmap;
import openfl.display.BitmapData;

var uiZoom = 0.9;
var uiOffsetMul = (1/uiZoom)-1;
var wOffset = FlxG.width * uiOffsetMul;
var hOffset = FlxG.height * uiOffsetMul;

public var accBarFront:FlxSprite;
public var accBarStatus:FlxSprite;
public var accBarText:FunkinText;
//HP
public var hpbg:FlxSprite;
public var hpcolor:FlxSprite;
public var charslot:FlxSprite;
public var chars1:FlxSprite;
public var chars2:FlxSprite;
public var chars3:FlxSprite;
public var charname:String = 'bf';
var colorShader:CustomShader;
//Time Bar
public var timebg:FlxSprite;
public var timecolor:FlxSprite;
public var timrbar:FlxBar;
public var songname:FunkinText;

public var camNewHUD:FlxCamera;
//Combo
public var arrow:FlxSprite;
public var amazing:FlxSprite;
public var hits:FlxSprite;

public var combohit:FunkinText;
public var countcombo:Int = 0;
public var combogroupp:FlxSpriteGroup;
var t:FlxTween;
var t2:FlxTween;
var t3:FlxTween;
var t4:FlxTween;
var t5:FlxTween;
//Sound Tray
public var soundicon:FlxSprite;
public var bx:Int = 10;
public var by:Int = 14;
public var _width:Int = 80;
public var tmp:FlxSprite;
public var bars:FlxTypedGroup;



function create() {
    camNewHUD = new FlxCamera();
    camNewHUD.bgColor = 0;
    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.add(camNewHUD, false);
    FlxG.cameras.add(camHUD, false);
    
    introSprites = ["game/ui/3", "game/ui/2", "game/ui/1", "game/ui/go"];


}


function onPostCountdown(event) {
    event.spriteTween.cancel();
    event.sprite.scale.set(0.4, 0.4);
    event.sprite.angle -= 30;
    event.sprite.cameras = [camNewHUD];
    FlxTween.tween(event.sprite, {"scale.x": 0.65, "scale.y": 0.65, "angle": 0}, Conductor.crochet / 1000, {
        ease: FlxEase.cubeOut,
        onComplete: function() {
            event.sprite.destroy();
            remove(event.sprite, true);
        }
    });
    FlxTween.tween(event.sprite, {alpha: 0}, Conductor.crochet / 1000, {
        ease: FlxEase.cubeIn
    });
}





function postCreate() {

   

    iconP1.visible = iconP2.visible = healthBar.visible = healthBarBG.visible = accuracyTxt.visible = false;

    accBarStatus = new FlxSprite();
    accBarStatus.loadGraphic(Paths.image("game/ui/accbar_status"));
    accBarStatus.antialiasing = true;
    accBarStatus.cameras = [camHUD];
    accBarStatus.scale.set(0.75, 0.75);
    accBarStatus.updateHitbox();
    accBarStatus.setPosition(1009.75 + wOffset, 479.5 + hOffset);
    accBarStatus.shader = new CustomShader("accuracy");
    if (accBarStatus.flipY = downscroll)
        accBarStatus.y += 7;

    accBarFront = new FlxSprite();
    accBarFront.loadGraphic(Paths.image(downscroll ? "game/ui/accbar_front_downscroll" : "game/ui/accbar_front"));
    accBarFront.antialiasing = true;
    accBarFront.cameras = [camHUD];
    accBarFront.scale.set(0.75, 0.75);
    accBarFront.updateHitbox();
    accBarFront.setPosition(FlxG.width - accBarFront.width + wOffset, FlxG.height - accBarFront.height + hOffset);

    accBarText = new FunkinText(FlxG.width - 205 + wOffset, FlxG.height - 135 + hOffset, 0, "100%", 36, true);
    accBarText.borderSize = 3;
    accBarText.borderStyle = FlxTextBorderStyle.SHADOW;
    accBarText.borderColor = 0xFF318ce0;
    if (downscroll) accBarText.shadowOffset.x = -1;
    accBarText.cameras = [camHUD];
    accBarText.shader = new CustomShader("italic");
    accBarText.scale.x *= 1.2;
    accBarText.color = 0xFF4EECFF;
    accBarText.antialiasing = true;
    accBarText.shader.skew = downscroll ? -0.1 : 0.1;

    //HP BAR
    hpbg = new FlxSprite().loadGraphic(Paths.image('game/ui/hpbar_frame'));
    hpbg.antialiasing = true;
    hpbg.scale.set(0.75, 0.75);
    hpbg.updateHitbox();
    hpbg.y = FlxG.height - hpbg.height + hOffset;

    hpcolor = new FlxSprite().loadGraphic(Paths.image('game/ui/hpbar_front'));
    hpcolor.antialiasing = true;
    hpcolor.scale.set(0.75, 0.75);
    hpcolor.updateHitbox();
    hpcolor.color = 0xFF66FF33;
    hpcolor.y = FlxG.height - hpcolor.height + hOffset;

    //SHADER
	hpcolor.shader = new CustomShader("colorTransform");
    hpcolor.shader.redMultiplier = 1;
	hpcolor.shader.greenMultiplier = 1;
	hpcolor.shader.blueMultiplier = 1;
	hpcolor.shader.alphaMultiplier = 1;
	hpcolor.shader.redOffset = 0;
	hpcolor.shader.greenOffset = 0;
	hpcolor.shader.blueOffset = 0;
	hpcolor.shader.alphaOffset = 0;

    charslot = new FlxSprite(0,555 + hOffset).loadGraphic(Paths.image('game/ui/chr_slot'));
    charslot.antialiasing = true;
    charslot.scale.set(0.75, 0.75);
    charslot.updateHitbox();

    chars1 = new FlxSprite(-30,465).loadGraphic(Paths.image('game/ui/char/bf'));
    chars1.antialiasing = true;
    chars1.scale.set(0.75 * 0.55, 0.75 * 0.55);
    chars1.flipX = true;
    chars1.angle -= 4;
    chars1.updateHitbox();
    chars1.y = FlxG.height - chars1.height - 40 + hOffset;

    chars2 = new FlxSprite(-30,465).loadGraphic(Paths.image('game/ui/char/bf'));
    chars2.antialiasing = true;
    chars2.scale.set(0.75 * 0.55, 0.75 * 0.55);
    chars2.flipX = true;
    chars2.angle -= 4;
    chars2.updateHitbox();
    chars2.y = FlxG.height - chars1.height - 40 + hOffset;

    chars3 = new FlxSprite(-30,465).loadGraphic(Paths.image('game/ui/char/bf'));
    chars3.antialiasing = true;
    chars3.scale.set(0.75 * 0.55, 0.75 * 0.55);
    chars3.flipX = true;
    chars3.angle -= 4;
    chars3.updateHitbox();
    chars3.y = FlxG.height - chars1.height - 40 + hOffset;

    if((boyfriend.curCharacter != 'bf' && boyfriend.curCharacter != 'bfex'))
    {
        charname = 'talia';
    }
    if(charname == 'talia')
        {
            chars1.loadGraphic(Paths.image('game/ui/char/' + charname + '-normal'));
            chars2.loadGraphic(Paths.image('game/ui/char/' + charname + '-half'));
            chars3.loadGraphic(Paths.image('game/ui/char/' + charname + '-low'));
            chars1.scale.set(0.1, 0.1);
            chars1.setPosition(-845,-272.562);
    
            chars2.scale.set(0.1, 0.1);
            chars2.setPosition(-845,-272.562);
    
            chars3.scale.set(0.1, 0.1);
            chars3.setPosition(-845,-272.562);
        }
    chars3.visible = chars2.visible = false;
    

    scoreTxt.alignment = missesTxt.alignment = "left";
    scoreTxt.setPosition(125, 657);
    missesTxt.setPosition(125, missesTxt.y + 10);
    missesTxt.text = 'Misses: ';
    scoreTxt.antialiasing = missesTxt.antialiasing = true;
    remove(scoreTxt, true);
    remove(missesTxt, true);


    //TIME BAR
    timebg = new FlxSprite(0, 0).loadGraphic(Paths.image('game/ui/timebar-frame'));
    timebg.antialiasing = true;
    timebg.scale.set(0.65 * 0.8, 0.65 * 0.5);
    timebg.updateHitbox();
	timebg.screenCenter();
	timebg.x += wOffset / 2;
    timebg.y = downscroll ? (FlxG.height - timebg.height + hOffset - 20) : -25;
    timebg.scrollFactor.set();

    timecolor = new FlxSprite(timebg.x,timebg.y).loadGraphic(Paths.image('game/ui/timebar-fills'));
    timecolor.antialiasing = true;
    timecolor.scale.set(0.65 * 0.8, 0.65 * 0.5);
    timecolor.updateHitbox();
    timecolor.color = 0xFF66FF33;
    timecolor.scrollFactor.set();

    songname = new FunkinText(timecolor.x, timecolor.y + 5, timecolor.width, PlayState.SONG.meta.displayName, 24, true);
	songname.alignment = "center";
    songname.antialiasing = true;
    songname.scrollFactor.set();


    scoreTxt.scrollFactor.set(1, 1);
    missesTxt.scrollFactor.set(1, 1);
    for(spr in [accBarStatus, accBarFront, charslot, chars1,chars2,chars3, scoreTxt, missesTxt, timebg, timecolor, songname, hpbg, hpcolor, accBarText]) {
        spr.cameras = [camNewHUD];
        add(spr);
    }

    //COMBO
    arrowSha = new FlxSprite();
    arrowSha.loadGraphic(Paths.image("game/ui/arrow"));
    arrowSha.antialiasing = true;
    arrowSha.cameras = [camHUD];
    arrowSha.color = FlxColor.BLACK;
    
    arrowSha.setPosition(-360, 425);
    arrowSha.scale.set(0.75, 0.75);
    arrowSha.updateHitbox();
    add(arrowSha);

    arrow = new FlxSprite();
    arrow.loadGraphic(Paths.image("game/ui/arrow"));
    arrow.antialiasing = true;
    arrow.cameras = [camHUD];
    
    arrow.setPosition(-360, 425);
    arrow.scale.set(0.75, 0.75);
    arrow.updateHitbox();
    add(arrow);
    //0 ,315

    amaSha = new FlxSprite();
    amaSha.loadGraphic(Paths.image("game/ui/amazing"));
    amaSha.antialiasing = true;
    amaSha.color = FlxColor.BLACK;
    amaSha.cameras = [camHUD];
    
    amaSha.setPosition(-360, 425);
    amaSha.scale.set(0.75, 0.75);
    amaSha.updateHitbox();
    add(amaSha);

    amazing = new FlxSprite();
    amazing.loadGraphic(Paths.image("game/ui/amazing"));
    amazing.antialiasing = true;
    amazing.cameras = [camHUD];
    
    amazing.setPosition(-360, 425);
    amazing.scale.set(0.75, 0.75);
    amazing.updateHitbox();
    add(amazing);

    hitsha = new FlxSprite();
    hitsha.loadGraphic(Paths.image("game/ui/hits"));
    hitsha.antialiasing = true;
    hitsha.cameras = [camHUD];
    
    hitsha.setPosition(180, 390);
    hitsha.scale.set(0.75, 0.75);
    hitsha.color = FlxColor.BLACK;
    hitsha.updateHitbox();

    hits = new FlxSprite();
    hits.loadGraphic(Paths.image("game/ui/hits"));
    hits.antialiasing = true;
    hits.cameras = [camHUD];
    
    hits.setPosition(180, 390);
    hits.scale.set(0.75, 0.75);
    hits.updateHitbox();

    combohit = new FunkinText(97.222, 450, 0, countcombo, 70,true);
    combohit.cameras = [camHUD];
    combohit.scale.x *= 1.2;
    combohit.antialiasing = true;
    combohit.shader = new CustomShader("italic");
    combohit.font = Paths.font("combo.ttf");
    combohit.antialiasing = true;
    combohit.shader.skew = downscroll ? -0.1 : 0.1;

    combohit.borderSize = 3;
    combohit.borderStyle = FlxTextBorderStyle.SHADOW;


    
    combogroupp = new FlxSpriteGroup(-320,120);
    combogroupp.cameras = [camHUD];
	add(combogroupp);
    combogroupp.add(hitsha);
    combogroupp.add(hits);
    combogroupp.add(combohit);

    //UI INTRO
    hpbg.x = hpcolor.x = -FlxG.width;
    charslot.alpha = chars1.alpha = 0;
    accBarText.alpha = 0;

    missesTxt.alpha = 0;
    scoreTxt.alpha = 0;

    songname.alpha = 0;

    //Y POSITION
    charslot.y += 40;
    chars1.y  += 40;
    scoreTxt.y -= 50;
    missesTxt.y -= 50;
    if (downscroll)
    {
        accBarStatus.x += FlxG.width;
        accBarFront.x += FlxG.width;
        timebg.y += 300;
        timecolor.y += 300;
        
    }
    else
    {
        
        accBarStatus.y += 300;
        accBarFront.y += 300;
        timebg.y -= FlxG.height;
        timecolor.y -= FlxG.height;
    }


    for(s in strumLines.members[0]) {
		s.x -= FlxG.width;
    }

    for(s in strumLines.members[1]) {
		s.x += FlxG.width;
    }
}

function onCountdown(event) {
    if (event.swagCounter == 3)
        {
            FlxTween.tween(hpcolor, {x: hpcolor.x + FlxG.width}, 1.5, {ease: FlxEase.expoOut});
            FlxTween.tween(hpbg, {x: hpcolor.x + FlxG.width}, 1.5, {ease: FlxEase.expoOut});
            FlxTween.tween(charslot, {alpha: 1, y: charslot.y - 30}, 1, {ease: FlxEase.expoOut, startDelay: 1});
            FlxTween.tween(chars1, {alpha: 1, y: chars1.y - 40}, 1, {ease: FlxEase.expoOut, startDelay: 1});
            FlxTween.tween(accBarText, {alpha:1}, 1.5, {ease: FlxEase.expoOut, startDelay: 1});
            FlxTween.tween(scoreTxt, {alpha: 1,y: scoreTxt.y + 50}, 1.5, {ease: FlxEase.expoOut, startDelay: 1});
            FlxTween.tween(missesTxt, {alpha: 1,y: missesTxt.y + 50}, 1.5, {ease: FlxEase.expoOut, startDelay: 1});
            FlxTween.tween(songname, {alpha:1}, 1.5, {ease: FlxEase.expoOut, startDelay: 1});
            for(s in strumLines.members[0]) {
                FlxTween.tween(s, {x:s.x + FlxG.width}, 1.5, {ease: FlxEase.expoOut});
            }
        
            for(s in strumLines.members[1]) {
                FlxTween.tween(s, {x:s.x - FlxG.width}, 1.5, {ease: FlxEase.expoOut});
            }

            if (downscroll)
                {
                    FlxTween.tween(accBarStatus, {x: accBarStatus.x - FlxG.width}, 1.5, {ease: FlxEase.expoOut});
                    FlxTween.tween(accBarFront, {x: accBarFront.x - FlxG.width}, 1.5, {ease: FlxEase.expoOut});
            
                    FlxTween.tween(timebg, {y: timebg.y - 300}, 1.5, {ease: FlxEase.expoOut});
                    FlxTween.tween(timecolor, {y: timecolor.y - 300}, 1.5, {ease: FlxEase.expoOut});
                   
                    
                }
                else
                {
                    
                    FlxTween.tween(accBarStatus, {y: accBarStatus.y - 300}, 1.5, {ease: FlxEase.expoOut});
                    FlxTween.tween(accBarFront, {y: accBarFront.y - 300}, 1.5, {ease: FlxEase.expoOut});
            
                    FlxTween.tween(timebg, {y: timebg.y + FlxG.height}, 1.5, {ease: FlxEase.expoOut});
                    FlxTween.tween(timecolor, {y: timecolor.y + FlxG.height}, 1.5, {ease: FlxEase.expoOut});
                   
                }
        }
   
}


function onNoteHit(event) if (event.showRating && event.note.mustPress) {
    accBarText.scale.set(1.15 * 1.2, 1.15);
    accBarText.angle = FlxG.random.float(-3.5, 3.5);
    accBarText.colorTransform.redOffset = accBarText.colorTransform.greenOffset = accBarText.colorTransform.blueOffset = 255;
    accBarStatus.colorTransform.redOffset = accBarStatus.colorTransform.greenOffset = accBarStatus.colorTransform.blueOffset = 255;
}

function onPlayerMiss(event)
{
    hpcolor.angle = FlxG.random.float(-2.5, 2.5);
    hpbg.angle = FlxG.random.float(-2.5, 2.5);
    hpcolor.colorTransform.greenMultiplier = 0;
    hpcolor.colorTransform.blueMultiplier = 0;
    countcombo = 0;

    if(healthBar.percent < 50)
        {
            chars1.visible = false;
            chars2.visible = true;
            chars3.visible = false;
        }

    if(healthBar.percent < 36)
    {
        chars1.visible = false;
        chars2.visible = false;
        chars3.visible = true;
       
    }
}

function onPlayerHit(event)
    {
        if(healthBar.percent < 100)
            {
                hpcolor.colorTransform.redOffset = hpcolor.colorTransform.greenOffset = hpcolor.colorTransform.blueOffset = 255;
            }

        if(healthBar.percent > 50)
        {
            if(chars1.graphics != charname + '-normal')
                {
                    chars1.visible = true;
                    chars2.visible = false;
                    chars3.visible = false;
                }
        }

        if(healthBar.percent > 36 && healthBar.percent < 50)
        {
            if(chars1.graphics != charname + '-half')
                {
                    chars1.visible = false;
                    chars2.visible = true;
                    chars3.visible = false;
                }
        }
        
        if(!event.note.isSustainNote)
        {
            countcombo += 1;
        
            
            if(t != null)
            {
                    t.cancel(); 
                    
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
            
            
            
            
            
            
            arrow.alpha = 1;    
            amazing.alpha = 1; 
            combogroupp.alpha = 1;      
            amaSha.alpha = arrowSha.alpha = combogroupp.members[0].alpha = 0.4; 
           
            if(downscroll)
            {
                arrow.setPosition(-50, 335);
                amazing.setPosition(5, 245);
                combogroupp.setPosition(0, -180);
                combogroupp.members[1].y = 280;
                combogroupp.members[0].y = 280;
                amazing.y = 380;
                arrowSha.y -= 70;
                combogroupp.members[0].x = 180 + 5;
                t = FlxTween.tween(arrow, {x: -360, y: 425, alpha: 0}, 1.7, {ease: FlxEase.quadIn});
                t2 = FlxTween.tween(amazing, {x: -360, y: 480, alpha: 0}, 1.6, {ease: FlxEase.quadIn});
                t3 = FlxTween.tween(combogroupp, {x: -320, y: 180, alpha: 0}, 1.8, {ease: FlxEase.quadIn});
                t4 = FlxTween.tween(amaSha, {alpha: 0}, 1.7, {ease: FlxEase.quadIn});
                t5 = FlxTween.tween(arrowSha, {alpha: 0}, 1.7, {ease: FlxEase.quadIn});
            }
            else
            {
                arrow.setPosition(-50, 335);
                amazing.setPosition(5, 245);
                combogroupp.setPosition(0, 20);
                combogroupp.members[0].y = 390 + 15;
                combogroupp.members[0].x = 180 + 5;
                t = FlxTween.tween(arrow, {x: -360, y: 425, alpha: 0}, 1.7, {ease: FlxEase.quadIn});
                t2 = FlxTween.tween(amazing, {x: -360, y: 345, alpha: 0}, 1.6, {ease: FlxEase.quadIn});
                t3 = FlxTween.tween(combogroupp, {x: -320, y: 120, alpha: 0}, 1.8, {ease: FlxEase.quadIn});
                t4 = FlxTween.tween(amaSha, {alpha: 0}, 1.7, {ease: FlxEase.quadIn});
                t5 = FlxTween.tween(arrowSha, {alpha: 0}, 1.7, {ease: FlxEase.quadIn});
            }
            

        }

    
    }

function postUpdate(elapsed) {
   /* var sprites = scoreTxt;
    if (FlxG.keys.pressed.LEFT) sprites.x -= 5;
    if (FlxG.keys.pressed.RIGHT) sprites.x += 5;
    if (FlxG.keys.pressed.UP) sprites.y -= 5;
    if (FlxG.keys.pressed.DOWN) sprites.y += 5;
    if (FlxG.keys.pressed.SPACE) trace(sprites);*/

    chars2.x = chars3.x = chars1.x;
    chars2.y = chars3.y = chars1.y;

    chars2.angle = chars3.angle = chars1.angle;

    chars2.alpha = chars3.alpha = chars1.alpha;

    amaSha.x = amazing.x + 4;
    amaSha.y = amazing.y + 4;

    arrowSha.x = arrow.x + 4;
    arrowSha.y = arrow.y + 4;
            

    if (FlxG.keys.justPressed.FOUR)
        downscroll = !downscroll;
    // accBarStatus.shader.accuracy = 0.5 + (0.5 * (Math.sin(Conductor.songPosition / 1000)));
    accBarStatus.shader.accuracy = accuracy;
    if (accuracy < 0) {
        accBarText.text = " -% ";
    } else {
        accBarText.text = " " + Std.string(FlxMath.roundDecimal(accuracy * 100, 2) + "% ");
    }
    accBarText.x = FlxG.width - 145 - (accBarText.width / 2) + wOffset;

    accBarStatus.colorTransform.redOffset = accBarStatus.colorTransform.greenOffset = accBarStatus.colorTransform.blueOffset = accBarText.colorTransform.redOffset = accBarText.colorTransform.greenOffset = accBarText.colorTransform.blueOffset = lerp(accBarText.colorTransform.blueOffset, 0, 0.125);
    accBarText.scale.x = lerp(accBarText.scale.x, 1.2, 0.25);
    accBarText.scale.y = lerp(accBarText.scale.y, 1, 0.25);
    accBarText.angle = lerp(accBarText.angle, 0, 0.25);

    hpcolor.angle = lerp(hpcolor.angle, 0, 0.25);
    hpbg.angle = lerp(hpbg.angle, 0, 0.25);
    hpcolor.colorTransform.redOffset = hpcolor.colorTransform.greenOffset = hpcolor.colorTransform.blueOffset = accBarText.colorTransform.redOffset = hpcolor.colorTransform.greenOffset = hpcolor.colorTransform.blueOffset = lerp(hpcolor.colorTransform.blueOffset, 0, 0.125);
    hpcolor.clipRect = new FlxRect(0, 0, hpcolor.frameWidth * healthBar.percent / 100, hpcolor.frameHeight);
    hpcolor.color = healthBar.percent < 36 ? 0xFFff1100 : 0xFF66FF33;
    hpcolor.colorTransform.greenMultiplier = hpcolor.colorTransform.blueMultiplier = lerp(hpcolor.colorTransform.blueMultiplier, 1, 0.25);

    var mul:Float = 1 + ((1 - ((curBeatFloat / 1) % 1)) * (1/3));

    if(healthBar.percent < 36)
    {
        hpcolor.shader.redMultiplier = mul;
        hpcolor.colorTransform.greenMultiplier = 0;
        hpcolor.colorTransform.blueMultiplier = 0;
    }



    timecolor.clipRect = new FlxRect(33, 0, 849 * (1 - (Conductor.songPosition / inst.length)), hpcolor.frameHeight);

    // sync new hud camera to old one
    camNewHUD.scroll.set(camHUD.x + (wOffset / 2), (downscroll ? camHUD.y + (accBarFront.y) : camHUD.y) + (hOffset / 2));
    camNewHUD.x = camHUD.x;
    camNewHUD.y = camHUD.y;
    camNewHUD.angle = camHUD.angle;
    camNewHUD.zoom = camHUD.zoom * uiZoom;

    //Combo
    combohit.text = countcombo;
}