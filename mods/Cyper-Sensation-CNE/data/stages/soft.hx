import funkin.system.FunkinSprite;
import haxe.io.Path;
import flixel.addons.display.FlxBackdrop;

import flixel.addons.display.shapes.FlxShapeCircle;
function create() {

	
    var index = members.indexOf(boyfriend);
	back = new FunkinSprite(-280, -310).loadGraphic(Paths.image('stages/soft/back'));
	back.scale.set(0.7,0.7);
	back.screenCenter(FlxAxes.XY);
	back.scrollFactor.set(0.8,1);
	back.y += 600;


	front = new FunkinSprite(-280, -310).loadGraphic(Paths.image('stages/soft/front'));
	front.scale.set(0.7,0.7);
	front.screenCenter(FlxAxes.XY);
	front.y += 600;

	
	light = new FunkinSprite(-1262 , -354.5 ).loadGraphic(Paths.image('stages/soft/light'));
	light.scale.set(0.7,0.7);
	light.screenCenter(FlxAxes.XY);
	light.y += 600;
	add(light);
	insert(index, front);
	insert(index, back);

	dad.setPosition(-65,1050);
	boyfriend.setPosition(980,1025);

	camGame.scroll.set(dad.getMidpoint().x,dad.getMidpoint().y);


}

function postCreate()
	{

		camGame.scroll.set(dad.getMidpoint().x,dad.getMidpoint().y - 300);
		
	    if(FlxG.save.data.ShaderHigh) {
		bloomShader = new FunkinShader(Assets.getText(Paths.fragShader("bloom")));
		camGame.addShader(bloomShader);
		}

		colorShader = new FunkinShader(Assets.getText(Paths.fragShader("colorgrade")));
        colorShader.topr = 3.1;
        colorShader.topg = 1.1;
        colorShader.topb = 1.1;
        
        colorShader.botr = 3.1;
        colorShader.botg = 1.1;
        colorShader.botb = 1.1; 
        
        camGame.addShader(colorShader);

		chromaticGame = new CustomShader("stupid");
		chromaticGame.chromaticAmount = 0.002;

		camGame.addShader(chromaticGame);

		var i = 0;
        i++;
		dad.shader = new CustomShader("garage-shadow");
        dad.shader.color = [1, 249 / 255, 0.5, 0.33 * ((3 - i) / 2)];
        dad.shader.shadowLength = 35 * ((3 - i) / 2);
        dad.shader.flipped = false;

        boyfriend.shader = new CustomShader("garage-shadow");
        boyfriend.shader.color = [1, 249 / 255, 0.5, 0.33 * ((3 - i) / 3)];
        boyfriend.shader.shadowLength = 25 * ((3 - i) / 2);
        boyfriend.shader.flipped = true;
	}
var bloomtime:Float = 0;
function postUpdate(elapsed)
{
	/*var damngod = light;
	if (FlxG.keys.pressed.LEFT) damngod.x -= 5;
	if (FlxG.keys.pressed.RIGHT) damngod.x += 5;
	if (FlxG.keys.pressed.UP) damngod.y -= 5;
	if (FlxG.keys.pressed.DOWN) damngod.y += 5;
	if (FlxG.keys.pressed.SPACE) trace(damngod);*/

	bloomtime += elapsed;
    
    if(FlxG.save.data.ShaderHigh) {
    bloomShader.iTime = bloomtime;
    }

	if(camGame.zoom < 0.9)
	{
		if(camGame.zoom < 0.7)
		{
			boyfriend.cameraOffset.y = -370;
			boyfriend.cameraOffset.x = -300;
			dad.cameraOffset.x = 500;
			dad.cameraOffset.y = -80;
		}
		else
		{
			boyfriend.cameraOffset.x = 0;
			boyfriend.cameraOffset.y = -200;
		}

	}
	else if(camGame.zoom == 1)
	{
		boyfriend.cameraOffset.x = 0;
		boyfriend.cameraOffset.y = -100;
		dad.cameraOffset.x = 0;
		dad.cameraOffset.y = 0;
	}
	else
	{
		dad.cameraOffset.x = 0;
		dad.cameraOffset.y = 0;
		boyfriend.cameraOffset.y = 0;
	}
}

function stepHit()
{
	if(PlayState.SONG.meta.displayName == 'Yawarakai')
	{
		switch(curStep)
		{
			case 1344:
				light.alpha = 0;
			case 1904:
				light.alpha = 1;
		}
	}

}

