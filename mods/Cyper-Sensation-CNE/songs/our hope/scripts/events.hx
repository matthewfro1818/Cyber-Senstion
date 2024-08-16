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
var omg:Bool = false;
var zoomTween:FlxTween;
var video:FlxVideoSprite;

import flixel.addons.display.shapes.FlxShapeCircle;
var lineStyle:LineStyle = {color: FlxColor.BLACK, thickness: 1};
var drawStyle:DrawStyle = {smoothing: true};
public var canvas1:FlxShapeCircle;
public var canvas2:FlxShapeCircle;

function postCreate() {
    bf = strumLines.members[1].characters[0];
    taeyai = strumLines.members[2].characters[0];
    conner = strumLines.members[3].characters[0];
    daisy = strumLines.members[4].characters[0];
    futo = strumLines.members[5].characters[0];
    pico = strumLines.members[6].characters[0];

    shaStrum = strumLines.members[0];
    bfStrum = strumLines.members[1];
    taeStrum = strumLines.members[2];

    connerStrum = strumLines.members[3];
    daisyStrum = strumLines.members[4];
    futoStrum = strumLines.members[5];
    picoStrum = strumLines.members[6];
    
    if(FlxG.save.data.MiddleScroll)
    {
        // Player MiddleScroll
        // Boyfriend
        strumLines.members[1].members[0].setPosition(420,50);
        strumLines.members[1].members[1].setPosition(526,50);
        strumLines.members[1].members[2].setPosition(630,50);
        strumLines.members[1].members[3].setPosition(736,50);
        // TaeYai
        strumLines.members[2].members[0].setPosition(420,50);
        strumLines.members[2].members[1].setPosition(526,50);
        strumLines.members[2].members[2].setPosition(630,50);
        strumLines.members[2].members[3].setPosition(736,50);
        // Opponent Middle Scroll
        // Shadow TaeYai
        strumLines.members[0].members[0].setPosition(80,50);
        strumLines.members[0].members[1].setPosition(186,50);
        strumLines.members[0].members[2].setPosition(965,50);
        strumLines.members[0].members[3].setPosition(1071,50);
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
        // Futo
        strumLines.members[5].members[0].setPosition(80,50);
        strumLines.members[5].members[1].setPosition(186,50);
        strumLines.members[5].members[2].setPosition(965,50);
        strumLines.members[5].members[3].setPosition(1071,50);
        // Pico
        strumLines.members[6].members[0].setPosition(80,50);
        strumLines.members[6].members[1].setPosition(186,50);
        strumLines.members[6].members[2].setPosition(965,50);
        strumLines.members[6].members[3].setPosition(1071,50);
    }

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

    bf.shader = new CustomShader("garage-shadow");
    bf.shader.color = [2, 249 / 255, 0.5, 0.33 * ((3 - i) / 3)];
    bf.shader.shadowLength = 25 * ((3 - i) / 2);
    bf.shader.flipped = true;

    taeyai.shader = new CustomShader("garage-shadow");
    taeyai.shader.color = [2, 249 / 255, 0.5, 0.33 * ((3 - i) / 3)];
    taeyai.shader.shadowLength = 25 * ((3 - i) / 2);
    taeyai.shader.flipped = true;

	conner.color = FlxColor.fromHSL(conner.color.hue, conner.color.saturation, 0.4, 0.4);
	daisy.color = FlxColor.fromHSL(daisy.color.hue, daisy.color.saturation, 0.7, 0.7);
	futo.color = FlxColor.fromHSL(futo.color.hue, futo.color.saturation, 0.4, 0.4);
	bf.color = FlxColor.fromHSL(bf.color.hue, bf.color.saturation, 0.4, 0.4);
    taeyai.color = FlxColor.fromHSL(boyfriend.color.hue, boyfriend.color.saturation, 0.4, 0.4);

    daisy.x = -1705;
    daisy.y = -300;
    conner.setPosition(-570,105);
    futo.setPosition(-1280,-100);
    futo.visible = conner.visible = daisy.visible =  false;
    taeyai.y += 100;
    bf.setPosition(540,-90);

    for(s in futoStrum) {
       s.alpha = 0;
       s.color = FlxColor.fromHSL(s.color.hue, 0.9, 0.4, 0.4);
    }

    
    for(s in connerStrum) {
        s.alpha = 0;
        s.color = FlxColor.fromHSL(3, 0.3, 0.4, 0.4);
     }

     for(s in picoStrum) {
        s.alpha = 0;
     }

     //Bot
     if(!FlxG.save.data.bfmode)
    {
        for(s in bfStrum) {
            s.alpha = 0;
         }

         charname = 'talia';
    }
    else
    {
        for(s in taeStrum) {
            s.alpha = 0;
         }
        strumLines.members[2].cpu = true;
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

     if(FlxG.save.data.ShaderHigh) {
     //for Hard Bump effect
     blur = new CustomShader("radialBlur");
     blur.cx =  0.5;
     blur.cy =  0.5;
     blur.blurWidth = 0.0;

     chromaticGame = new CustomShader("stupid");
     chromaticGame.chromaticAmount = 0.003;

     chromatic = new CustomShader("stupid");
     chromatic.chromaticAmount = 0.001;

     camGame.addShader(blur);
     camHUD.addShader(blur);
     camNewHUD.addShader(blur);

     camGame.addShader(chromaticGame);
     camHUD.addShader(chromatic);
     camNewHUD.addShader(chromatic);
     }

     //Extra Stage
     var index = members.indexOf(strumLines.members[0].characters[0]);
     door = new FlxSprite(-1470   ,-895 ).loadGraphic(Paths.image('stages/shadow/door'));
     door.scale.set(1.5,1.5);
     insert(index, door);

     portal = new FlxSprite(-1140  ,-1200  ).loadGraphic(Paths.image("stages/shadow/portal"));
     portal.frames = Paths.getSparrowAtlas('stages/shadow/portal');
     portal.antialiasing = true;
     portal.blend = 0;
     portal.color = FlxColor.fromHSL(portal.color.hue, portal.color.saturation, 0.7, 0.7);
     portal.scrollFactor.set(0.7,0.7);
     portal.animation.addByPrefix('idle', "frame_0", 24,true);
     portal.animation.play('idle',true);
     portal.visible = false;
     insert(index, portal);


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

     eventbackground = new FlxSprite(200,-200).makeGraphic(1280,720, 0xFF000000);
     eventbackground.updateHitbox();
     eventbackground.scale.set(10,10);
     eventbackground.screenCenter(FlxAxes.X);
     eventbackground.scrollFactor.set(1,1);
     
     
     botplaytxt = new FunkinText(525, 547, 0, "BOTPLAY", 24, true);
     botplaytxt.visible = false;
     botplaytxt.screenCenter(FlxAxes.X);
   	 botplaytxt.cameras = [camHUD];
	 add(botplaytxt);


     fire = new FlxSprite(-1510  ,-300 ).loadGraphic(Paths.image("stages/shadow/fire"));
     fire.frames = Paths.getSparrowAtlas('stages/shadow/fire');
     fire.antialiasing = true;
     fire.scrollFactor.set(0.7,0.7);
     fire.animation.addByPrefix('idle', "FIREEE instance 1", 24,true);
     fire.animation.play('idle',true);
     insert(index, fire);
     insert(index, eventbackground);
     fire.visible = eventbackground.visible = false;

     camfx = new FlxCamera();
     camfx.bgColor = 0;
     FlxG.cameras.add(camfx, false);

     camChar = new FlxCamera();
     camChar.bgColor = 0;
     camChar.zoom = 1.4;
     FlxG.cameras.remove(camHUD, false);
     FlxG.cameras.add(camChar, false);
     FlxG.cameras.add(camHUD, false);

     //Daisy Effects
     daiclone = new Character(-640 ,180 ,'daisy-wrath',false);
     daiclone.flipX = false;
     daiclone.cameras = [camChar];
     add(daiclone);
 
     taeclone = new Character(645 ,155 ,'taescare',taeyai.isPlayer);
     taeclone.cameras = [camChar];
     add(taeclone);

     bfclone = new Character(670 ,-60 ,boyfriend.curCharacter,boyfriend.isPlayer);
     bfclone.cameras = [camChar];
     add(bfclone);

     daiclone.visible = taeclone.visible = bfclone.visible = camChar.visible = false;
     daiclone.alpha = taeclone.alpha = bfclone.alpha = camChar.alpha = 0;


     coolText = new FunkinText(0,0,0,'CHAOS', 64, true);
     coolText.antialiasing = true;
     coolText.font = Paths.font("seriouss.ttf");
     coolText.cameras = [camfx];
     coolText.color = 0xFFf5675b;
     coolText.screenCenter();
     add(coolText);

     scary = new FlxSprite( -218.5   , -13).loadGraphic(Paths.image('stages/shadow/scary2'));
     scary.cameras = [camfx];
     scary.alpha = 0;
     scary.scale.set(1.5,1.5);
     add(scary);

    //Pico Section
    white = new FlxSprite(-800, -800);
    white.makeGraphic(FlxG.width * 2.3, FlxG.width * 2.3, 0xFFffffff);
    white.scrollFactor.set(0, 0);
    white.blend = 1;


    gffake = new FlxSprite(dad.x ,dad.y).loadGraphic(Paths.image("characters/gffake"));
    gffake.frames = Paths.getSparrowAtlas('characters/gffake');
    gffake.antialiasing = true;
    gffake.animation.addByPrefix('idle', "gf idle0", 24,false);
    gffake.animation.play('idle',true);

    add(gffake);
    insert(index, white); 
    pico.setPosition(-795 ,-410 );
    gffake.setPosition(-935 ,-25 );
       //PICO
   //bf.setPosition(540   ,-90 ); OG
    gffake.color = FlxColor.fromHSL(gffake.color.hue, gffake.color.saturation, 0.6, 0.6);
	pico.color = FlxColor.fromHSL(pico.color.hue, pico.color.saturation, 0.6, 0.6);

    var index = members.indexOf(boyfriend);
	canvas1 = new FlxShapeCircle(665 ,305 ,100,lineStyle,FlxColor.BLACK);
	insert(index,canvas1);
	canvas1.scale.x = 2;
	canvas1.scale.y = 0.5;
	canvas1.alpha = 0.7;

    var index = members.indexOf(pico);
	canvas2 = new FlxShapeCircle(-885 ,350 ,100,lineStyle,FlxColor.BLACK);
	insert(index,canvas2);
	canvas2.scale.x = 2;
	canvas2.scale.y = 0.4;
	canvas2.alpha = 0.7;

	canvas3 = new FlxShapeCircle(-655 ,230  ,100,lineStyle,FlxColor.BLACK);
	insert(index,canvas3);
	canvas3.scale.x = 2;
	canvas3.scrollFactor = pico.scrollFactor;
	canvas3.scale.y = 0.5;
	canvas3.alpha = 0.7;

    pico.visible = gffake.visible = canvas1.visible = canvas2.visible = canvas3.visible = white.visible = false;

     glitch = new CustomShader('screenglitch');
     glitch.enabled = true;
     portal.shader = glitch;
     camfx.addShader(glitch);
     
     if(FlxG.save.data.ShaderHigh) {
     drunk = new CustomShader("itfake");
     camChar.addShader(drunk);

     bloomShader = new FunkinShader(Assets.getText(Paths.fragShader("bloom")));
     camChar.addShader(bloomShader);
     }

     clown1.visible = clownf.visible = clown0.visible = coolText.visible = false;
     defaultCamZoom = 0.6;
     camZooming = true;
}

function onCountdown(event)
    {
            event.volume = 0;
    }

function onPostNoteCreation(event)
{
    //TO DO: Make this bot depend on Story

    if(!FlxG.save.data.bfmode)
        {
            if(event.strumLineID == 1)
                {
                    event.note.alpha = 0;
                }
        }
        else
        {
            if(event.strumLineID == 2)
                {
                    event.note.alpha = 0;
                }
        }
        

        if(event.strumLineID == 0 || event.strumLineID == 5)
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

        camHUD.y = lerp(camHUD.y, 0, 0.125);
        camHUD.angle = lerp(camHUD.angle, 0, 0.125);
        camGame.angle = lerp(camGame.angle, 0, 0.125);

        switch(daisy.getAnimName()) {
            case "singLEFT":  daiclone.playAnim('singLEFT');
            case "singDOWN":  daiclone.playAnim('singDOWN');
            case "singUP":    daiclone.playAnim('singUP');
            case "singRIGHT": daiclone.playAnim('singRIGHT');
        }

        switch(taeyai.getAnimName()) {
            case "singLEFT":  taeclone.playAnim('singLEFT');
            case "singDOWN":  taeclone.playAnim('singDOWN');
            case "singUP":    taeclone.playAnim('singUP');
            case "singRIGHT": taeclone.playAnim('singRIGHT');
        }
    
        switch(boyfriend.getAnimName()) {
            case "singLEFT":  bfclone.playAnim('singLEFT');
            case "singDOWN":  bfclone.playAnim('singDOWN');
            case "singUP":    bfclone.playAnim('singUP');
            case "singRIGHT": bfclone.playAnim('singRIGHT');
        }
        
        if (!FlxG.save.data.bfmode) { strumLines.members[1].cpu = true; }
        
        if(FlxG.keys.justPressed.B || virtualPad.buttonA.justPressed)
        {
                if (!FlxG.save.data.bfmode)
                {
                    strumLines.members[2].cpu = !strumLines.members[2].cpu;
                    botplaytxt.visible = !botplaytxt.visible;
                    addVirtualPad('NONE', 'A_B_X_Y');
        	        addVirtualPadCamera();
        	        if(!strumLines.members[2].cpu) { addVirtualPad('NONE', 'A'); addVirtualPadCamera(); }
                }
        }


        /*var damngod = canvas3;
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
    if(FlxG.save.data.ShaderHigh) {
    blur.blurWidth = multi;
    }

    multi2 = lerp(multi2,0.0014,0.125);
    if(FlxG.save.data.ShaderHigh) {
    chromatic.chromaticAmount = multi2;
    }

    multi3 = lerp(multi3,0.003,0.125);
    if(FlxG.save.data.ShaderHigh) {
    chromaticGame.chromaticAmount = multi2;
    }

    time += elapsed;
    glitch.iTime = time;
    if(FlxG.save.data.ShaderHigh) {
    drunk.iTime = time;
    bloomShader = time;
    }
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

function onPostCountdown(event) {
    event.sprite.visible = false;
    
    FlxTween.tween(camGame, {alpha: 1}, 1.5, {ease: FlxEase.quadInOut});
    FlxTween.tween(camNewHUD, {alpha: 1}, 1.5, {ease: FlxEase.quadInOut});
    FlxTween.tween(camGame, {zoom: 1}, 1.7, {ease: FlxEase.quadInOut});

}



function stepHit()
{
    switch(curStep)
    {
        case 708,721,728,738,745:
            defaultCamZoom += 0.1;
        case 752:
            camHUD.flash(FlxColor.WHITE, 0.3);
            camGame.shake(0.05, 0.5, null, true, 0);
            camHUD.shake(0.05, 0.5, null, true, 0);
            portal.visible = true;
            defaultCamZoom = 0.4;
            zoomar = true;
            cameraMovementEnabled = true;
            cameraMovementStrength = 2;
        case 1072:
            defaultCamZoom = 0.6;
        case 1327:
            camZooming = false;
            camNewHUD.alpha = 0;
            FlxTween.tween(eventbackground2, {alpha:1}, 1.5, {ease: FlxEase.expoOut});
            FlxTween.tween(camGame, {zoom: 2}, 2.5, {ease: FlxEase.expoOut});
            zoomar = false;
            FlxTween.tween(scary, {alpha:1}, 2, {ease: FlxEase.cubeIn});
        case 1360:
            camHUD.flash(FlxColor.WHITE, 0.2);
            FlxTween.tween(camGame, {zoom: 0.6},2, {ease: FlxEase.backInOut, onComplete: function() {
                camZooming = true;
                zoomar = true;
        }});
        FlxTween.tween(camNewHUD, {alpha: 1}, 1.5, {ease: FlxEase.quadInOut});
            scary.visible = eventbackground2.visible = false;
            dad.visible = false;
            clown1.visible = clownf.visible = clown0.visible = true;
            portal.visible = door.visible = false;
            conner.visible = true;
            defaultCamZoom =0.6;
            bf.y += 100;

            for(s in connerStrum) {
                s.alpha = 1;
             }

           
        case 1424:
            defaultCamZoom = 0.7;
         
        case 1616:
            defaultCamZoom = 1;
            zoomar = false;
        case 1872:
            superZoomar = true;
            defaultCamZoom = 0.6;
            wing = true;
        case 2624:
            superZoomar = false;
            eventbackground2.visible = true;
            eventbackground2.alpha = 0;
            camZooming = false;
            FlxTween.tween(eventbackground2, {alpha:1}, 2, {ease: FlxEase.expoOut});
            FlxTween.tween(camGame, {zoom: 1}, 1, {ease: FlxEase.expoOut});
        case 2640:
            for(s in connerStrum) {
                s.alpha = 0;
             }

             for(s in daisyStrum) {
                s.alpha = 1;
             }
            camNewHUD.alpha = 0;
            FlxTween.tween(camNewHUD, {alpha: 1}, 1.5, {ease: FlxEase.quadInOut});
            camZooming = false;
            defaultCamZoom = 3; 
            daisy.cameraOffset.x += 200;
            daisy.flipX = false;
            clown1.visible = clownf.visible = clown0.visible = conner.visible = false;
            fire.visible = eventbackground.visible =  daisy.visible = true;
            wing = false;
            FlxTween.tween(eventbackground2, {alpha:0}, 2, {ease: FlxEase.expoOut});
            FlxTween.tween(camGame, {zoom: 0.7},2, {ease: FlxEase.backInOut, onComplete: function() {
                camZooming = true;
                defaultCamZoom = 0.7; 
        }});
        case 3024,3060,3068,3120,3128,3135,3184,3192,3200,3248,3256:
            defaultCamZoom = 1;
        case 3055,3064,3072,3124,3132,3140,3188,3196,3204,3252,3260:
            defaultCamZoom = 0.7;
        case 3280:
            camHUD.flash(FlxColor.WHITE, 0.2);
            daiclone.visible = taeclone.visible = bfclone.visible = true;
            camGame.alpha = 0;
            camChar.alpha = 1;
            camChar.visible = true;
            daiclone.x += FlxG.width;
            FlxTween.tween(daiclone, {alpha:1, x:daiclone.x-FlxG.width}, 4, {ease: FlxEase.quintOut});
            camNewHUD.alpha = 0;
        case 3344:
            taeclone.x -= FlxG.width;
            FlxTween.tween(daiclone, {alpha:0, x:daiclone.x-100}, 2, {ease: FlxEase.quintOut});
            FlxTween.tween(taeclone, {alpha:1, x:daiclone.x+FlxG.width}, 4, {ease: FlxEase.quintOut});
        case 3392:
            FlxTween.tween(daiclone, {alpha:1, x:daiclone.x+100}, 2, {ease: FlxEase.quintOut});
        case 3408:
            bfclone.y += FlxG.height;
            FlxTween.tween(taeclone, {alpha:0, x:taeclone.x+100}, 2, {ease: FlxEase.quintOut});
            FlxTween.tween(bfclone, {alpha:1, y:bfclone.y-FlxG.height}, 6, {ease: FlxEase.quintOut});
        case 3472:
            FlxTween.tween(taeclone, {alpha:1, x:taeclone.x-100}, 1, {ease: FlxEase.quintOut});
            FlxTween.tween(bfclone, {alpha:1, y:bfclone.x+FlxG.height}, 2, {ease: FlxEase.quintOut});
        case 3536:
            camGame.alpha = 1;
            camChar.alpha = 0;
            camChar.visible = false;
            superZoomar = true;
            defaultCamZoom = 0.65;
            camHUD.flash(FlxColor.WHITE, 0.2);
            daiclone.visible = taeclone.visible = bfclone.visible = false;
            FlxTween.tween(camNewHUD, {alpha: 1}, 1.5, {ease: FlxEase.quadInOut});
        case 3792,3920:
            defaultCamZoom = 0.8;
            superZoomar = false;
        case 3856:
            defaultCamZoom = 0.7;
        case 3888:
            defaultCamZoom = 0.9;
        case 3984:
            camZooming = false;
            FlxTween.tween(camGame, {zoom: 2},4, {ease: FlxEase.backInOut, onComplete: function() {
                camZooming = true;
                
        }});
        case 4032:
            defaultCamZoom = 0.7; 
        case 4048:
            camHUD.flash(FlxColor.WHITE, 0.2);
            fire.visible = eventbackground.visible =  daisy.visible = false;
            superZoomar = true;
            bf.y -= 100;
            futo.visible = true;
            cameraMovementStrength = 4;
            FlxG.camera.followLerp = 0.3;
            for(s in futoStrum) {
                s.alpha = 1;
             }

             for(s in daisyStrum) {
                s.alpha = 0;
             }
        case 4304:
            defaultCamZoom = 0.6; 
            camHUD.flash(FlxColor.WHITE, 0.2);
            superZoomar = false;
            zoomar = true;
        case 4432:
            defaultCamZoom = 0.7;
        case 4560,4656:
            superZoomar = true;
            defaultCamZoom = 0.8;
        case 4592,4688:
            defaultCamZoom = 0.7;
        case 4816:
            camHUD.flash(FlxColor.WHITE, 0.2);
            cameraMovementStrength = 6;
            defaultCamZoom = 0.8;
            zoomar = false;
            omg = true;
        case 5072:
            camHUD.flash(FlxColor.WHITE, 0.2);
            defaultCamZoom = 0.6;
            zoomar = true;
            omg = superZoomar = false;
        case 5137,5264:
            defaultCamZoom = 0.8;
        case 5200:
            defaultCamZoom = 0.7;
        case 5328:
            camHUD.flash(FlxColor.WHITE, 0.2);
            superZoomar = true;
            zoomar = false;
            defaultCamZoom = 0.9;
        case 5360,5456,5552:
            defaultCamZoom = 0.7;
        case 5444,5521:
            defaultCamZoom = 0.6;
        case 5572:
            superZoomar = camZooming = false;
            FlxTween.tween(camGame, {zoom: 2},1, {ease: FlxEase.backInOut});
            FlxTween.tween(eventbackground2, {alpha:1}, 1, {ease: FlxEase.expoOut});
        case 5592:
            FlxTween.tween(eventbackground2, {alpha:0.1}, 2, {ease: FlxEase.expoOut});
            FlxTween.tween(camGame, {zoom: 0.7},2, {ease: FlxEase.backInOut, onComplete: function() {
                camZooming = true;
                
        }});
            bf.shader = null;
            pico.visible = gffake.visible = canvas1.visible = canvas2.visible = canvas3.visible = white.visible = true;
            futo.visible = taeyai.visible = false;
            bf.setPosition(555  ,-325);
            cameraMovementEnabled = false;
            FlxG.camera.followLerp = 0.3;
            for(s in futoStrum) {
                s.alpha = 0;
             }

             for(s in picoStrum) {
                s.alpha = 1;
             }
        case 5732:
            defaultCamZoom = 0.6;
        case 5792:
            defaultCamZoom = 0.8;
        case 5840:
            FlxTween.tween(eventbackground2, {alpha:1}, 2, {ease: FlxEase.expoOut});
            camZooming = false;
            FlxTween.tween(camGame, {zoom: 2},2, {ease: FlxEase.backInOut});
        case 5857:
            var i = 0;
            i++;
            bf.shader = new CustomShader("garage-shadow");
            bf.shader.color = [2, 249 / 255, 0.5, 0.33 * ((3 - i) / 3)];
            bf.shader.shadowLength = 25 * ((3 - i) / 2);
            bf.shader.flipped = true;
            bf.setPosition(540   ,-90 );

            FlxTween.tween(eventbackground2, {alpha:0}, 2, {ease: FlxEase.expoOut});
            FlxTween.tween(camGame, {zoom: 0.4},2, {ease: FlxEase.expoOut, onComplete: function() {
                camZooming = true;
                superZoomar = true;
                defaultCamZoom = 0.4;
                
            }});
            cameraMovementEnabled = true;
            cameraMovementStrength = 2;
            pico.visible = gffake.visible = canvas1.visible = canvas2.visible = canvas3.visible = white.visible = false;
            
            portal.visible = door.visible = dad.visible = taeyai.visible = true;

            for(s in picoStrum) {
                s.alpha = 0;
             }

             for(s in shaStrum) {
                s.alpha = 1;
             }
        case 5984:
            defaultCamZoom = 0.9;
        case 6049:
            defaultCamZoom = 0.7;
        case 6112:
            camHUD.flash(FlxColor.WHITE, 0.2);
            defaultCamZoom = 0.9;
        case 6240:
            defaultCamZoom = 0.7;
            cameraMovementStrength = 4;
        case 6336:
            defaultCamZoom = 0.4;
        case 6366:
            FlxTween.tween(eventbackground2, {alpha:1}, 2, {ease: FlxEase.expoOut});
            camZooming = false;
            FlxTween.tween(camGame, {zoom: 2},2, {ease: FlxEase.quintOut});
            FlxTween.tween(camHUD, {alpha: 0},2, {ease: FlxEase.backInOut});
        
    }
    if(curStep >= 4816 && curStep < 5072)
        {
            camGame.x = camHUD.x = camfx.x = camNewHUD.x = 0;
            camGame.y = camHUD.y = camfx.y = camNewHUD.y = 0;
    
            camGame.x += FlxG.random.int(-9,9);
            camGame.y += FlxG.random.int(-9,9);
    
            camHUD.x += FlxG.random.int(-9,9);
            camHUD.y += FlxG.random.int(-9,9);
    
            camfx.x += FlxG.random.int(-9,9);
            camfx.y += FlxG.random.int(-9,9);
    
            camNewHUD.x += FlxG.random.int(-9,9);
            camNewHUD.y += FlxG.random.int(-9,9);		
        }
}

function onNoteHit(event)
    {
        event.enableCamZooming = false;
    }

public var wing:Bool = false;
function beatHit()
    {
        if(curBeat % 2==0) {gffake.animation.play('idle',true);}
        if(wing)
            {
                camHUD.angle = 2.5 * (curBeat % 2 == 0 ? 1 : -1);
                camGame.angle = 2.5 * (curBeat % 2 == 0 ? 1 : -1);
                camHUD.y = -40 * (curBeat % 2 == 0 ? 1 : -1);
            }

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
                multi+= 0.03;
            }
        if (curBeat % 4 == 0 && omg)
            {
                hardbump();
            }
        if (curBeat % 6 == 0 && omg)
            {
                bump();
                multi2 += 0.002;
                multi3 += 0.002;
            }
    } 