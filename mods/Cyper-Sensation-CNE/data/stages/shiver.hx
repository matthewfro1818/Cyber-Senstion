import funkin.system.FunkinSprite;
import funkin.game.cutscenes.Cutscene;
import hxvlc.flixel.FlxVideoSprite;
import funkin.game.cutscenes.ScriptedCutscene;
import funkin.game.cutscenes.VideoCutscene;
import funkin.backend.assets.ModsFolder;
import haxe.io.Path;

import flixel.addons.display.shapes.FlxShapeCircle;
var lineStyle:LineStyle = {color: FlxColor.BLACK, thickness: 1};
var drawStyle:DrawStyle = {smoothing: true};
public var canvas1:FlxShapeCircle;
public var canvas2:FlxShapeCircle;

var videoCamera:FlxCamera;
var zoomar:Bool = false;
var superZoomar:Bool = false;
function create() {
    var index = members.indexOf(boyfriend);
	white = new FlxSprite(-800, -800);
	white.makeGraphic(FlxG.width * 2.3, FlxG.width * 2.3, 0xFFffffff);
	white.scrollFactor.set(0, 0);
	white.blend = 1;

    insert(index, white);
}

function postCreate()
{
	boyfriend.y += 90;
	dad.x -= 400;
	dad.y -= 60;
    var index = members.indexOf(boyfriend);
	canvas1 = new FlxShapeCircle(boyfriend.x + 120,dad.y + 640,100,lineStyle,FlxColor.BLACK);
	insert(index,canvas1);
	canvas1.scale.x = 2;
	canvas1.scale.y = 0.5;
	canvas1.alpha = 0.3;

	canvas2 = new FlxShapeCircle(dad.x + 110,dad.y + 640,100,lineStyle,FlxColor.BLACK);
	insert(index,canvas2);
	canvas2.scale.x = 2;
	canvas2.scale.y = 0.5;
	canvas2.alpha = 0.3;

	fyre=new FlxSprite().loadGraphic(Paths.image('fyre'));
	fyre.setPosition(-294  ,70);
	fyre.alpha=0.4;
	fyre.scale.set(0.4,0.4);
	fyre.scrollFactor.set(0.7,0.7);
	insert(index,fyre);

	bigman=new FlxSprite().loadGraphic(Paths.image('bigman'));
	bigman.setPosition(236   ,205  );
	bigman.alpha=0.4;
	bigman.scale.set(0.7,0.7);
	bigman.scrollFactor.set(0.7,0.7);
	insert(index,bigman);

	blur = new CustomShader("radialBlur");
	blur.cx =  0.5;
	blur.cy =  0.5;
	blur.blurWidth = 0.0;

	camfx = new FlxCamera();
	camfx.bgColor = 0;
	FlxG.cameras.remove(camHUD, false);
	FlxG.cameras.remove(camNewHUD, false);
	FlxG.cameras.add(camfx, false);
	FlxG.cameras.add(camHUD, false);
	FlxG.cameras.add(camNewHUD, false);
	
	vignette=new FlxSprite().loadGraphic(Paths.image('stages/room/vignette'));
	vignette.screenCenter();
	vignette.cameras=[camfx];
	vignette.alpha=0;
	vignette.scrollFactor.set();
	add(vignette);

	eventbackground2 = new FlxSprite(200,-200).makeGraphic(1280,720, 0xFF000000);
	eventbackground2.alpha = 1;
	eventbackground2.updateHitbox();
	eventbackground2.scale.set(10,10);
	eventbackground2.screenCenter(FlxAxes.X);
	eventbackground2.scrollFactor.set(1,1);
	eventbackground2.cameras=[camfx];
	add(eventbackground2);


	videoCamera = new FlxCamera();
    videoCamera.bgColor = 0;
    FlxG.cameras.add(videoCamera, false);

    video = new FlxVideoSprite(FlxAxes.X,FlxAxes.Y);
    video.cameras = [videoCamera];
	video.alpha = 0;
    add(video);

	camGame.zoom = 3;

	
}

function videomidsong(videoname) 
    {
        trace('playvide');
        if (video.load('mods/' + ModsFolder.currentModFolder + '/videos/' + videoname + '.mp4'))
            new FlxTimer().start(0.001, function(tmr:FlxTimer) {
                video.play();
            });
    }
function onPostCountdown(event) {
    event.sprite.visible = false;
    videomidsong('deepcut');
    FlxTween.tween(video, {alpha: 1}, 0.5, {ease: FlxEase.quadInOut});
}

function onSongStart()
{
	new FlxTimer().start(3, function(tmr:FlxTimer)
		{
			FlxTween.tween(video, {alpha: 0}, 2.5, {ease: FlxEase.quadInOut});
			FlxTween.tween(camGame, {alpha: 1, zoom:0.6}, 6, {ease: FlxEase.backInOut});
			FlxTween.tween(eventbackground2, {alpha: 0}, 6, {ease: FlxEase.backInOut});

			

		});
}


var time:Float = 0;
var multi:Float = 0.0;
function update(elapsed)
{
    multi = lerp(multi,0.0,0.125);
    blur.blurWidth = multi;
}
function postUpdate()
{
	video.screenCenter(FlxAxes.XY);
    video.setGraphicSize(FlxG.width, FlxG.height);

		/*var damngod = bigman;
        if (FlxG.keys.pressed.LEFT) damngod.x -= 5;
        if (FlxG.keys.pressed.RIGHT) damngod.x += 5;
        if (FlxG.keys.pressed.UP) damngod.y -= 5;
        if (FlxG.keys.pressed.DOWN) damngod.y += 5;
        if (FlxG.keys.pressed.SPACE) trace(damngod);*/
}
function bump()
{
    FlxG.camera.zoom += 0.015;
    camHUD.zoom += 0.03;
    
} 

function hardbump()
{
    FlxG.camera.zoom += 0.03;
    camHUD.zoom += 0.06;
    multi+= 0.07;
    
} 

function stepHit()
{
	switch(curStep)
	{
		case 128:
			zoomar = true;
		case 384,448,560,624:
			defaultCamZoom = 0.8;
		case 416,480,544,608,688,752,960,1088:
			defaultCamZoom = 0.7;
		case 512,576,640,706,928.992:
			defaultCamZoom = 0.9;
		case 676,740,770,1024:
			defaultCamZoom = 0.6;
		case 768:
			cameraMovementEnabled = true;
			cameraMovementStrength = 2;

		case 896:
			camHUD.flash(FlxColor.WHITE, 0.2);
			superZoomar = true;
			zoomar = false;
			defaultCamZoom = 0.7;
		case 1152:
			superZoomar = false;
			zoomar = true;
			defaultCamZoom = 1;
			FlxTween.tween(vignette, {alpha: 0.6}, 1, {ease: FlxEase.backInOut});
			cameraMovementStrength = 4;
		case 1280:
			defaultCamZoom = 0.7;
			FlxTween.tween(vignette, {alpha: 0}, 1, {ease: FlxEase.backInOut});
			cameraMovementStrength = 3;
		case 1408,1664:
			cameraMovementStrength = 2;
			defaultCamZoom = 0.8;
		case 1532:
			cameraMovementStrength = 3;
			defaultCamZoom = 0.6;
		case 1792:
			camHUD.flash(FlxColor.WHITE, 0.2);
			defaultCamZoom = 0.6;
			superZoomar = true;
			zoomar = false;
		case 1920:
			defaultCamZoom = 0.7;
		case 2048:
			superZoomar = false;
			zoomar = true;
			camHUD.flash(FlxColor.WHITE, 0.2);
			defaultCamZoom = 0.6;
	}
}

function beatHit()
    {
		if (curBeat % 1 == 0)
            {
                fyre.flipX = !fyre.flipX;
				bigman.flipX = !bigman.flipX;

				fyre.y += 20;
				bigman.y += 20;
				FlxTween.tween(fyre, {y:fyre.y  - 20}, 0.4, {ease: FlxEase.backOut});
				FlxTween.tween(bigman, {y: bigman.y  - 20}, 0.4, {ease: FlxEase.backOut});
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
            }
        if (curBeat % 1 == 0 && superZoomar)
            {
                bump();
            }
    } 