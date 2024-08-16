import funkin.system.FunkinSprite;
import haxe.io.Path;
import flixel.addons.display.FlxBackdrop;

import flixel.addons.display.shapes.FlxShapeCircle;
var lineStyle:LineStyle = {color: FlxColor.BLACK, thickness: 1};
var drawStyle:DrawStyle = {smoothing: true};
public var canvas1:FlxShapeCircle;
public var canvas2:FlxShapeCircle;
public var zoomar:Bool = false;
function create() {
    var index = members.indexOf(boyfriend);
	bg = new FlxBackdrop(Paths.image('stages/monika/bg'), FlxAxes.XY,-80,-20);
	bg.scale.set(4,4);
	bg.velocity.set(-150,150);  

	bg2 = new FlxBackdrop(Paths.image('stages/monika/bg'), FlxAxes.X,FlxAxes.Y);
	bg2.scale.set(4,4);
	bg2.velocity.set(-150,150);  

    insert(index, bg);

	
    var index = members.indexOf(boyfriend);
	floor = new FunkinSprite(-280, -310).loadGraphic(Paths.image('stages/monika/floor'));
	floor.scale.set(3,3);
	floor.screenCenter(FlxAxes.XY);
	floor.y += 600;
	insert(index, floor);

	boyfriend.x += 330;
	boyfriend.y -= 250;
	dad.x -= 460;
	dad.y -= 40;

	dad.scrollFactor.set(1.3,1.3);
	boyfriend.scrollFactor.set(1.3,1.3);
	floor.scrollFactor.set(1.3,1.3);


}

function bump()
    {
        FlxG.camera.zoom += 0.015;
        camHUD.zoom += 0.03;
    }  

function flash()
{
	camHUD.flash(FlxColor.WHITE, 0.5);
}

function zoomplz()
{
	zoomar = !zoomar;
}

function beatHit()
    {
    
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

function postCreate()
{
    var index = members.indexOf(boyfriend);
	canvas1 = new FlxShapeCircle(boyfriend.x  + 150,boyfriend.y + 580,100,lineStyle,FlxColor.BLACK);
	insert(index,canvas1);
	canvas1.scale.x = 2;
	canvas1.scale.y = 0.5;
	canvas1.alpha = 0.2;

	canvas2 = new FlxShapeCircle(dad.x + 200,dad.y + 300,100,lineStyle,FlxColor.BLACK);
	insert(index,canvas2);
	canvas2.scale.x = 2;
	canvas2.scale.y = 0.5;
	canvas2.alpha = 0.2;

	canvas1.scrollFactor.set(1.3,1.3);
	canvas2.scrollFactor.set(1.3,1.3);
}

function postUpdate()
{
	floor.skew.x = (-((FlxG.camera.scroll.x + (FlxG.width / 2)) - floor.getMidpoint().x)  * floor.scrollFactor.y) / Math.PI / floor.width;
   
}