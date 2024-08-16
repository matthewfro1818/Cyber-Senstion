import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.FlxCamera;

var debris:FlxSprite;
var debris2:FlxSprite;
var debrisback:FlxSprite;
var floatvalve:Float = 0;
var floatvalve2:Float = 0.30;
var bf2:Character;
var bfstrum:StrumLine;
var strumCamera:FlxCamera;
var newcamFollow:FlxObject;
var newprevCamFollow:FlxObject;
var camPoss:FlxPoint;
var taeyaiturn:Bool;
var bfturn:Bool;
var bothturn:Bool;

function postCreate()
{
	var i = members.indexOf(boyfriend);
	debris = new FlxSprite(dad.x - 150, 760).loadGraphic(Paths.image('stages/nonsense/break/Debris'));
	debris.scrollFactor(1, 1);

	debris2 = new FlxSprite(boyfriend.x - 150, 880).loadGraphic(Paths.image('stages/nonsense/break/Debris'));
	debris2.scrollFactor(1, 1);

	debrisback = new FlxSprite(1480, 680).loadGraphic(Paths.image('stages/nonsense/break/Debris_Back'));
	debrisback.scrollFactor(1, 1);
	debrisback.flipX = true;

	bf2 = new Character(1640, debrisback.y - 520, 'bf', true);

	insert(i, debris);
	insert(i, debris2);
	insert(i, bf2);
	insert(i, debrisback);

	strumCamera = new FlxCamera(0, 0, Std.int(FlxG.width / 2), 0);
	strumCamera.bgColor = 0;
	strumCamera.zoom = 0.6;

	bfstrum = new StrumLine([bf2], 0.5, true, false, controls);

	players.push(bfstrum);
	bfstrum.generateStrums();
	for (i in bfstrum.members)
	{
		i.cameras = [strumCamera];
	}

	camPoss = new FlxPoint(bf2.getGraphicMidpoint().x, bf2.getGraphicMidpoint().y);

	var newcamFollow:FlxObject = newprevCamFollow == null ? new FlxObject(camPoss.x, camPoss.y, 2, 2) : newprevCamFollow;
	add(newcamFollow);
	newcamFollow.setPosition(750, 300);
	FlxG.cameras.remove(camHUD, false);
	FlxG.cameras.add(strumCamera, false);
	FlxG.cameras.add(camHUD, false);
	strumCamera.x = 400;
	strumCamera.alpha = 0.6;
	strumCamera.follow(newcamFollow);
	strumCamera.focusOn(newcamFollow.getPosition());
}

function onStrumCreation(event:StrumCreationEvent)
{
}

function onNoteCreation(event:NoteCreationEvent)
{
	if (event.noteType == "Second BF Sing")
	{
		event.note.strumLineID = 2;
	}
}

function stepHit()
{
	if (taeyaiturn)
	{
		FlxTween.tween(boyfriend, {x: 1540}, 0.3, {ease: FlxEase.cubeOut});
		FlxTween.tween(bf2, {x: 1640}, 0.2, {ease: FlxEase.circInOut});
	}
	else if (bfturn)
	{
		FlxTween.tween(bf2, {x: 1440}, 0.3, {ease: FlxEase.cubeOut});
		FlxTween.tween(boyfriend, {x: 2000}, 0.2, {ease: FlxEase.circInOut});
	}
	else if (bothturn)
	{
		FlxTween.tween(boyfriend, {x: 1540}, 0.3, {ease: FlxEase.cubeOut});
		FlxTween.tween(bf2, {x: 1440}, 0.3, {ease: FlxEase.cubeOut});
	}
}

function postUpdate()
{
	var sinvalve = Math.sin(floatvalve);
	var cosvalve = Math.cos(floatvalve);
	var sinvalve2 = Math.sin(floatvalve2);
	debris.x = dad.x - 150;
	debris2.x = boyfriend.x - 150;
	debrisback.x = bf2.x - 150;
	floatvalve += 0.05;
	floatvalve2 -= 0.01;

	dad.y += sinvalve;
	strumCamera.y += cosvalve;
	strumCamera.x -= sinvalve2;
	boyfriend.y += sinvalve;
	bf2.y += cosvalve;
	debris.y += sinvalve;
	debris2.y += sinvalve;
	debrisback.y += cosvalve;
	stuff.y += cosvalve;
	stuff.x += sinvalve2;
}

function onNoteHit(event)
{
	if (event.noteType == "Second BF Sing")
	{
		// Make it not stuck or lag move
		bfturn = true;
		taeyaiturn = false;
		bothturn = false;

		event.character = bf2;
	}
}

var anims = ["singLEFT", "singDOWN", "singUP", "singRIGHT"];

function onPlayerHit(event)
{
	if (event.noteType == "Both BF Sing")
	{
		bothturn = true;
		taeyaiturn = false;
		bfturn = false;
		bf2.playAnim(anims[event.note.notedata], true);
	}
	else
	{
		taeyaiturn = true;
		bfturn = false;
		bothturn = false;
	}
}
