import openfl.Lib;

var floatvalve:Float = 0;
var defwindowX:Float = Lib.application.window.x;
var defwindowY:Float = Lib.application.window.y;
var xLerp:Float = FlxMath.lerp(Lib.application.window.x, defwindowX, 0.95);
var yLerp:Float = FlxMath.lerp(Lib.application.window.y, defwindowY, 0.95);

function postCreate()
{
	var index = members.indexOf(dad);	
    lastroombg = new FlxSprite(-600, -200).loadGraphic(Paths.image('stages/lastroom/BG'));
	lastroombg.scale.set(1.3,1.3);
	insert(index,lastroombg);
	
    beam = new FlxSprite(-600, -200).loadGraphic(Paths.image('stages/lastroom/beam'));
	beam.scrollFactor.set(0.9, 0.9);
	beam.scale.set(1.3,1.3);
	beam.alpha = 0;
	add(beam);

	boyfriend.setPosition(1120,370);
	dad.setPosition(-100,100);
	
}

function postUpdate(elapsed:Float)
{
	floatvalve += 0.06 * elapsed * 120;

	var lerp = FlxEase.sineOut(curBeatFloat % 1);
	var sinvalve = Math.sin(floatvalve);
	var cosvalve = Math.cos(floatvalve);

	beam.alpha = 0.7 + (0.25 * Math.sin(Math.PI * curBeatFloat / 4));
	dad.y += sinvalve * elapsed * 120;
	dad.y += cosvalve * elapsed * 120;
}

var winPos = [defwindowX, defwindowX];
var curWinPos = [Lib.application.window.x, Lib.application.window.y];

var singleftgo:FlxTween;
var singrightgo:FlxTween;
var singupgo:FlxTween;
var singdowngo:FlxTween;

function onCameraMove(event)
{
	var char = event.ratio >= 0.5 ? boyfriend : dad;


    winPos[0] = xLerp;
    winPos[1] = yLerp;
	switch (char.getAnimName())
	{
		case "singLEFT", "singLEFT-alt", "singLEFTmiss":
            //winPos[0] -= 60;
		case "singRIGHT", "singRIGHT-alt", "singRIGHTmiss":
           // winPos[0] += 60;
		case "singDOWN", "singDOWN-alt", "singDOWNmiss":
            //winPos[1] += 60;
		case "singUP", "singUP-alt", "singUPmiss":
           // winPos[1] -= 60;
	}
}

function update(elapsed:Float) {
    curWinPos[0] = lerp(curWinPos[0], winPos[0], 0.25);
    curWinPos[1] = lerp(curWinPos[1], winPos[1], 0.25);
    Lib.application.window.x = Std.int(curWinPos[0]);
    Lib.application.window.y = Std.int(curWinPos[1]);
}
