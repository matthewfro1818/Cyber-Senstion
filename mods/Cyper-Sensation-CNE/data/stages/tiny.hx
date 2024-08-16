import funkin.system.FunkinSprite;
import haxe.io.Path;

import flixel.addons.display.shapes.FlxShapeCircle;
var lineStyle:LineStyle = {color: FlxColor.BLACK, thickness: 1};
var drawStyle:DrawStyle = {smoothing: true};
public var canvas1:FlxShapeCircle;
public var canvas2:FlxShapeCircle;
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
	boyfriend.y += 70;
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
	canvas2.alpha = 0.3;
}