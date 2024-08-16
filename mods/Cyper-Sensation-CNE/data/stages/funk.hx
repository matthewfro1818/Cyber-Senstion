import funkin.system.FunkinSprite;
import haxe.io.Path;

import flixel.addons.display.shapes.FlxShapeCircle;
var lineStyle:LineStyle = {color: FlxColor.BLACK, thickness: 1};
var drawStyle:DrawStyle = {smoothing: true};
public var canvas1:FlxShapeCircle;
public var canvas2:FlxShapeCircle;
var boppin:Bool = true;

public var superZoomShit:Bool = false;
public var supersuperZoomShit:Bool = false;
public var zoomar:Bool = false;

function create() {
    var index = members.indexOf(strumLines.members[2].characters[0]);
	white = new FlxSprite(-800, -800);
	white.makeGraphic(FlxG.width * 2.3, FlxG.width * 2.3, 0xFFffffff);
	white.scrollFactor.set(0, 0);
	white.blend = 1;

    insert(index, white);

    var index = members.indexOf(strumLines.members[2].characters[0]);
	nerd = new FlxSprite(950,905).loadGraphic(Paths.image("characters/the_nerd_one"));
    nerd.frames = Paths.getSparrowAtlas('characters/the_nerd_one');
	nerd.antialiasing = true;
    nerd.animation.addByPrefix('idle', "the nerd one down0", 24,false);
	nerd.scale.set(0.4,0.4);
	nerd.alpha = 0.4;
	nerd.flipX = true;
	insert(index, nerd);
	
	botplaytxt = new FunkinText(525, 547, 0, "BOTPLAY", 24, true);
    botplaytxt.visible = false;
    botplaytxt.screenCenter(FlxAxes.X);
	botplaytxt.cameras = [camHUD];
	add(botplaytxt);

    var index = members.indexOf(strumLines.members[0].characters[0]);
	stamps = new FlxSprite(295 ,-110).loadGraphic(Paths.image('stamps'));
	stamps.scrollFactor.set(1,1);
	stamps.scale.set(0.2,0.2);
	stamps.origin.y = 1330;
	stamps.alpha = 0.4;
    insert(index, stamps);

	mag = new FlxSprite(265,370).loadGraphic(Paths.image('magg'));
	mag.scrollFactor.set(1,1);
	mag.scale.set(0.7,0.7);
	mag.origin.y = 840;
	mag.alpha = 0.4;
    insert(index, mag);
}


function beatHit()
	{
		if(curBeat % 2 == 0 && boppin)
		{
			nerd.animation.play('idle',true);

			stamps.scale.y = 0.01;
			FlxTween.tween(stamps.scale, {y: 0.2}, 0.4, {ease: FlxEase.backOut});

			mag.scale.y = 0.3;
			FlxTween.tween(mag.scale, {y: 0.7}, 0.4, {ease: FlxEase.backOut});
		}

		
        if (curBeat % 2 == 0 && superZoomShit)
            {
                FlxG.camera.zoom += 0.03;
                camHUD.zoom += 0.06;
                
            }
        if (curBeat % 1 == 0 && superZoomShit)
            {
                FlxG.camera.zoom += 0.04;
                camHUD.zoom += 0.07;
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

function update()
{
	chars1.alpha = chars2.alpha = chars3.alpha = 0;
	/*var damngod = mag;
    if (FlxG.keys.pressed.LEFT) damngod.x -= 5;
    if (FlxG.keys.pressed.RIGHT) damngod.x += 5;
    if (FlxG.keys.pressed.UP) damngod.y -= 5;
    if (FlxG.keys.pressed.DOWN) damngod.y += 5;
    if (FlxG.keys.pressed.SPACE) trace(damngod);*/

	strumLines.members[1].cpu = true;

    
	if(FlxG.keys.justPressed.B || virtualPad.buttonA.justPressed)
    {
            strumLines.members[2].cpu = !strumLines.members[2].cpu;
			strumLines.members[3].cpu = !strumLines.members[3].cpu;
			botplaytxt.visible = !botplaytxt.visible;
			addVirtualPad('NONE', 'A_B_X_Y');
        	addVirtualPadCamera();
			if(!strumLines.members[2].cpu && !strumLines.members[3].cpu) { addVirtualPad('NONE', 'A'); addVirtualPadCamera(); }
    }
    
    if (FlxG.save.data.MiddleScroll) {
    // Opponent MiddleScroll
        // Spyro
        strumLines.members[1].members[0].setPosition(80,50);
        strumLines.members[1].members[1].setPosition(186,50);
        strumLines.members[1].members[2].setPosition(965,50);
        strumLines.members[1].members[3].setPosition(1071,50);
        strumLines.members[1].alpha = 0.5;
    }
}

function postCreate()
{
	strumLines.members[0].characters[0].setPosition(40,545); //TOFU
	strumLines.members[1].characters[0].setPosition(-255,800); //Spyro
	strumLines.members[2].characters[0].setPosition(1125,625); //Fah
	strumLines.members[3].characters[0].setPosition(1430,715); //Jeng

	FlxG.camera.followLerp = 99;

	/*
    var index = members.indexOf(boyfriend);
	canvas1 = new FlxShapeCircle(boyfriend.x + 120,boyfriend.y + 630,100,lineStyle,FlxColor.BLACK);
	insert(index,canvas1);
	canvas1.scale.x = 2;
	canvas1.scale.y = 0.5;
	canvas1.alpha = 0.3;

	canvas2 = new FlxShapeCircle(dad.x + 140,dad.y + 580,100,lineStyle,FlxColor.BLACK);
	insert(index,canvas2);
	canvas2.scale.x = 2;
	canvas2.scale.y = 0.5;
	canvas2.alpha = 0.3;*/
	
	if (FlxG.save.data.MiddleScroll) {
    // Player MiddleScroll
        // Fah
        strumLines.members[2].members[0].setPosition(420,50);
        strumLines.members[2].members[1].setPosition(526,50);
        strumLines.members[2].members[2].setPosition(630,50);
        strumLines.members[2].members[3].setPosition(736,50);
        // Jeng
        strumLines.members[3].members[0].setPosition(420,50);
        strumLines.members[3].members[1].setPosition(526,50);
        strumLines.members[3].members[2].setPosition(630,50);
        strumLines.members[3].members[3].setPosition(736,50);
    
    // Opponent MiddleScroll
        // TOFU
        strumLines.members[0].members[0].setPosition(80,50);
        strumLines.members[0].members[1].setPosition(186,50);
        strumLines.members[0].members[2].setPosition(965,50);
        strumLines.members[0].members[3].setPosition(1071,50);
    }
}

function stepHit()
{
	switch(curStep)
	{
		case 64:
			zoomar = true;
		case 384:
			zoomar = false;
			defaultCamZoom = 0.8;
			boppin = false;
			FlxTween.tween(mag, {alpha:1}, 0.4, {ease: FlxEase.backOut});
			FlxTween.tween(stamps, {alpha:1}, 0.4, {ease: FlxEase.backOut});
			FlxTween.tween(nerd, {alpha:1}, 0.4, {ease: FlxEase.backOut});
			FlxTween.tween(strumLines.members[0].characters[0], {alpha:0.4}, 0.4, {ease: FlxEase.backOut});
			FlxTween.tween(strumLines.members[1].characters[0], {alpha:0.4}, 0.4, {ease: FlxEase.backOut});
			FlxTween.tween(strumLines.members[2].characters[0], {alpha:0.4}, 0.4, {ease: FlxEase.backOut});
			FlxTween.tween(strumLines.members[3].characters[0], {alpha:0.4}, 0.4, {ease: FlxEase.backOut});
		case 390:
			mag.y -= 30;
			mag.angle = 20;
		case 392:
			mag.y += 10;
			mag.angle = -10;
		case 394:
			zoomar = camZooming = true;
			defaultCamZoom = 0.5;
			boppin = true;
			FlxTween.tween(mag, {alpha:0.4}, 0.4, {ease: FlxEase.backOut});
			mag.angle = 0;
			mag.y = 370;
			FlxTween.tween(stamps, {alpha:0.4}, 0.4, {ease: FlxEase.backOut});
			FlxTween.tween(nerd, {alpha:0.4}, 0.4, {ease: FlxEase.backOut});
			FlxTween.tween(strumLines.members[0].characters[0], {alpha:1}, 0.4, {ease: FlxEase.backOut});
			FlxTween.tween(strumLines.members[1].characters[0], {alpha:1}, 0.4, {ease: FlxEase.backOut});
			FlxTween.tween(strumLines.members[2].characters[0], {alpha:1}, 0.4, {ease: FlxEase.backOut});
			FlxTween.tween(strumLines.members[3].characters[0], {alpha:1}, 0.4, {ease: FlxEase.backOut});
		case 652:
			camGame.flash(FlxColor.WHITE, 0.5);
			zoomar = false;
			superZoomShit = true;
		case 912:
			camGame.flash(FlxColor.WHITE, 0.5);
			superZoomShit = false;
			supersuperZoomShit = true;
		case 1168:
			camGame.flash(FlxColor.WHITE, 0.5);
			supersuperZoomShit = false;
			defaultCamZoom = 0.8;
		case 1184,1188,1192,1198:
			defaultCamZoom += 0.1;
			FlxG.camera.zoom += 0.015;
            camHUD.zoom += 0.03;
		case 1200:
			camGame.flash(FlxColor.WHITE, 0.5);
			defaultCamZoom = 0.5;
			superZoomShit = true;
		case 1296:
			defaultCamZoom = 0.8;
		case 1360:
			defaultCamZoom = 0.5;
		case 1424:
			superZoomShit = false;
			defaultCamZoom = 0.8;
			boppin = false;
			curCameraTarget = 2;
			strumLines.members[2].characters[0].cameraOffset.x -= 400;
			FlxTween.tween(mag, {alpha:1}, 0.4, {ease: FlxEase.backOut});
			FlxTween.tween(stamps, {alpha:1}, 0.4, {ease: FlxEase.backOut});
			FlxTween.tween(nerd, {alpha:1}, 0.4, {ease: FlxEase.backOut});
			FlxTween.tween(strumLines.members[0].characters[0], {alpha:0.4}, 0.4, {ease: FlxEase.backOut});
			FlxTween.tween(strumLines.members[1].characters[0], {alpha:0.4}, 0.4, {ease: FlxEase.backOut});
			FlxTween.tween(strumLines.members[2].characters[0], {alpha:0.4}, 0.4, {ease: FlxEase.backOut});
			FlxTween.tween(strumLines.members[3].characters[0], {alpha:0.4}, 0.4, {ease: FlxEase.backOut});
		case 1428:
			FlxTween.tween(stamps.scale, {x:1}, 0.4, {ease: FlxEase.backOut});
		case 1433:
			stamps.scale.x = 0.2;
		case 1436:
			stamps.y -= 10;
			stamps.angle = 10;
		case 1438:
			curCameraTarget = 3;
			FlxTween.tween(strumLines.members[3].characters[0], {alpha:1}, 0.4, {ease: FlxEase.backOut});
			strumLines.members[3].characters[0].playAnim('hey',true);
		case 1440:
			supersuperZoomShit = camZooming = true;
			defaultCamZoom = 0.5;
			boppin = true;
			stamps.angle = 0;
			stamps.y = -110;
			strumLines.members[2].characters[0].cameraOffset.x += 400;
			FlxTween.tween(mag, {alpha:0.4}, 0.4, {ease: FlxEase.backOut});
			FlxTween.tween(stamps, {alpha:0.4}, 0.4, {ease: FlxEase.backOut});
			FlxTween.tween(nerd, {alpha:0.4}, 0.4, {ease: FlxEase.backOut});
			FlxTween.tween(strumLines.members[0].characters[0], {alpha:1}, 0.4, {ease: FlxEase.backOut});
			FlxTween.tween(strumLines.members[1].characters[0], {alpha:1}, 0.4, {ease: FlxEase.backOut});
			FlxTween.tween(strumLines.members[2].characters[0], {alpha:1}, 0.4, {ease: FlxEase.backOut});
		case 1560:
			supersuperZoomShit = false;
		case 1568:
			strumLines.members[2].characters[0].cameraOffset.x -= 400;

	}
}