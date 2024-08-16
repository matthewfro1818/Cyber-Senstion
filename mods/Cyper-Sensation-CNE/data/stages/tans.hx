import funkin.system.FunkinSprite;
import haxe.io.Path;
var rayTracker:FlxSprite;
public var camRays:FlxCamera;
public var camNoRays:FlxCamera;
public var rayShader:FunkinShader;
public var bloomShader:FunkinShader;
var bloomtime:Float = 0;
function postCreate() {
	dad.flipX = true;
	boyfriend.flipX = true;

	camGame.zoom = 1;
    camGame.scroll.set(253,310);
    
    boyfriend.cameraOffset.x += 470;
    dad.cameraOffset.x -= 300;
    

    boyfriend.cameraOffset.y -= 700;
    dad.cameraOffset.y -= 700;

	var index = members.indexOf(dad);
    redad = new Character(dad.x, dad.y, 'tans', false);
	redad.flipX = true;
    redad.flipY = true;
	redad.x = 1961;
    redad.y = 1475;

    redad.skew.x = 9;
    redad.color = FlxColor.YELLOW;
    redad.alpha = 0.1;
	insert(index, redad);
	var index = members.indexOf(boyfriend);
    rebf = new Character(boyfriend.x, boyfriend.y, 'bf', true);
    rebf.flipX = true;
    rebf.flipY = true;
	rebf.x = 291;
    rebf.y = 1115;

    rebf.skew.x = -19;
	rebf.skew.y = 5;
    rebf.blend = 0;
    rebf.color = FlxColor.YELLOW;
    rebf.alpha = 0.1;
    
    insert(index, rebf);

    if(PlayState.SONG.meta.displayName== 'Karma')
        {
            
            boyfriend.color = FlxColor.fromHSL(boyfriend.color.hue, boyfriend.color.saturation, 0.4, 0.4);
            dad.color = FlxColor.fromHSL(dad.color.hue, dad.color.saturation, 0.4, 0.4);
        }
    var i = 0;
	for(c in [boyfriend, dad]) {
        i++;

        c.shader = new CustomShader("garage-shadow");
        c.shader.color = [1, 249 / 255, 0.5, 0.33 * ((3 - i) / 2)];
        c.shader.shadowLength = 25 * ((3 - i) / 2);
        c.shader.flipped = c.flipX;
    }

		rayTracker = new FlxSprite(600,170);
        rayTracker.active = false;
        rayTracker.scale.set(0.75,0.75);
        camRays = new FlxCamera();
        camRays.bgColor = 0;
        if (FlxG.save.data.ShaderHigh) {
        rayShader = new FunkinShader(Assets.getText(Paths.fragShader("godrays-morning")));
        camRays.addShader(rayShader);
        }
        
        camNoRays = new FlxCamera();
        camNoRays.bgColor = 0;
        FlxG.cameras.remove(camHUD, false);
        FlxG.cameras.remove(camNewHUD, false);
        FlxG.cameras.add(camRays, false);
        FlxG.cameras.add(camNoRays, false);
        FlxG.cameras.add(camHUD, false);
        FlxG.cameras.add(camNewHUD, false);
        
        if(FlxG.save.data.ShaderHigh)
        {
        bloomShader = new FunkinShader(Assets.getText(Paths.fragShader("bloom")));
        camGame.addShader(bloomShader);
        }
        dad.cameras = boyfriend.cameras = [camRays];
        rebf.cameras = redad.cameras = [camRays];
        rayTracker.cameras = [camNoRays];

        cpuStrums.characters = [redad,dad];
        playerStrums.characters = [rebf,boyfriend];

		playerStrums.forEach(function(spr:FlxSprite)
            {
                  
                spr.x -= 645;
            });
            cpuStrums.forEach(function(spr:FlxSprite)
            {
                
                spr.x += 645;						
            });

        if(PlayState.SONG.meta.displayName== 'Karma')
        {
            
            boyfriend.color = FlxColor.fromHSL(boyfriend.color.hue, boyfriend.color.saturation, 0.4, 0.4);
            dad.color = FlxColor.fromHSL(dad.color.hue, dad.color.saturation, 0.4, 0.4);

            idkshade = new FunkinShader(Assets.getText(Paths.fragShader("blend")));
            camRays.addShader(idkshade);

        }

}

function onCountdown(event) {
    if (event.swagCounter == 0)
        {
            FlxTween.tween(camGame, {zoom: 0.4}, 2, {ease: FlxEase.expoOut});
        }
   
}

function update(elapsed)
	{

	}

	function postUpdate(elapsed:Float)
		{
		   //camFollow.setPosition(400, 500);
		   // redad.alpha  =0;
			camRays.scroll.set(camGame.scroll.x, camGame.scroll.y);
			camRays.zoom = camGame.zoom;
			camNoRays.scroll.set(camGame.scroll.x, camGame.scroll.y);
			camNoRays.zoom = camGame.zoom;
	
			
			var rayPos = rayTracker.getGraphicMidpoint(null, camRays);
	
			rayPos.y -= camRays.height / 2;
			rayPos.x -= camRays.width / 2;
			rayPos.x *= camRays.zoom;
			rayPos.y *= camRays.zoom;
			rayPos.x += camRays.width / 2;
			rayPos.y += camRays.height / 2;
	
			rayShader._LightPos = [rayPos.x / camRays.width, rayPos.y / camRays.height];
	
			rayPos.put();
		}