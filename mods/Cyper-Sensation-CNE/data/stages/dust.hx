import funkin.system.FunkinSprite;
import haxe.io.Path;
import flixel.util.FlxSave;
import funkin.backend.assets.ModsFolder;
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

    var index = members.indexOf(boyfriend);
    bg = new FlxSprite(-400).loadGraphic(Paths.image('stages/tans/bg'));
    bg.scrollFactor.set(1,1);
    bg.scale.set(1.3,1.3);

    light = new FlxSprite(-400).loadGraphic(Paths.image('stages/tans/light'));
    light.scrollFactor.set(1,1);
    light.scale.set(1.3,1.3);

    front = new FlxSprite(-400).loadGraphic(Paths.image('stages/tans/front'));
    front.scrollFactor.set(0.9,0.9);
    front.scale.set(1.3,1.3);

    insert(index,bg);
    insert(index,light);
    add(front);
    bg.color = FlxColor.CYAN;
    light.color = FlxColor.CYAN;
    front.color = FlxColor.CYAN;
	var index = members.indexOf(dad);
    redad = new Character(dad.x, dad.y, 'sans', false);
	redad.flipX = true;
    redad.flipY = true;
	redad.x = 1951;
    redad.y = 1305;

    redad.skew.x = 9;
    redad.color = FlxColor.BLUE;
    redad.alpha = 0.1;
	insert(index, redad);
	var index = members.indexOf(boyfriend);
    rebf = new Character(boyfriend.x, boyfriend.y, 'taeyai-v2', true);
    rebf.flipX = true;
    rebf.flipY = true;
	rebf.x = 261 + 37;
    rebf.y = 1455;

    rebf.skew.x = -19;
	rebf.skew.y = 5;
    rebf.blend = 0;
    rebf.color = FlxColor.CYAN;
    rebf.alpha = 0.1;
    
    insert(index, rebf);

    bg.color = 0xFF212bde;
    light.color = 0xFF212bde;
    front.color = 0xFF212bde;
    
    var i = 0;
	for(c in [boyfriend, dad]) {
        i++;

        c.shader = new CustomShader("garage-shadow");
        c.shader.color = [1, 255 / 255, 0.5, 0.33 * ((3 - i) / 2)];
        c.shader.shadowLength = 25 * ((3 - i) / 2);
        c.shader.flipped = c.flipX;
    }

		rayTracker = new FlxSprite(600,170);
        rayTracker.active = false;
        rayTracker.scale.set(0.75,0.75);
        camRays = new FlxCamera();
        camRays.bgColor = 0;
        if (FlxG.save.data.ShaderHigh) {
        rayShader = new FunkinShader(Assets.getText(Paths.fragShader("godray-sans")));
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
        
        boyfriend.color = FlxColor.fromHSL(boyfriend.color.hue, boyfriend.color.saturation, 0.4, 0.4);
        dad.color = FlxColor.fromHSL(dad.color.hue, dad.color.saturation, 0.4, 0.4);

        if (FlxG.save.data.ShaderHigh) {
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


            


            idkshade = new FunkinShader(Assets.getText(Paths.fragShader("blend")));
            camRays.addShader(idkshade);

        

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
	
	        if (FlxG.save.data.ShaderHigh) {
			rayShader._LightPos = [rayPos.x / camRays.width, rayPos.y / camRays.height];
			}
	
			rayPos.put();

		}