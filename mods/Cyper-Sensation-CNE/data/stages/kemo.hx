import funkin.game.cutscenes.Cutscene;
import hxvlc.flixel.FlxVideo;
import funkin.game.cutscenes.ScriptedCutscene;
import funkin.game.cutscenes.VideoCutscene;
import funkin.backend.assets.ModsFolder;
import funkin.backend.shaders.FunkinShader;
import openfl.filters.ShaderFilter;
import openfl.utils.Assets;

var start:Bool = false;
var redad:Character;
function create() {
    
}

function onCountdown(event) {
    if (event.swagCounter == 0)
        {
            FlxTween.tween(camGame, {zoom: 0.8}, 2, {ease: FlxEase.bounceOut});
        }
   
}

function postCreate() {
    camGame.zoom = 1;
    camGame.scroll.set(253,310);
    
    boyfriend.cameraOffset.x -= 200;

    

    boyfriend.cameraOffset.y -= 60;


    dad.y += 440;
    dad.x += 240;

    boyfriend.x += 400;
    boyfriend.y += 440;
    

    dad.color = FlxColor.fromHSL(dad.color.hue, dad.color.saturation, 0.7, 0.7);
    boyfriend.color = FlxColor.fromHSL(boyfriend.color.hue, boyfriend.color.saturation, 0.7, 0.7);

    idkshade = new FunkinShader(Assets.getText(Paths.fragShader("blend")));
	camGame.addShader(idkshade);

    var i = 0;
        i++;

        dad.shader = new CustomShader("garage-shadow");
        dad.shader.color = [-4, 249 / 255,1.5, 0.33 * ((3 - i) / 2)];
        dad.shader.shadowLength = 25 * ((3 - i) / 2);
        dad.shader.flipped = false;

        boyfriend.shader = new CustomShader("garage-shadow");
        boyfriend.shader.color = [-3, 249 / 255,1.5, 0.33 * ((3 - i) / 2)];
        boyfriend.shader.shadowLength = 25 * ((3 - i) / 2);
        boyfriend.shader.flipped = true;
    
    
} 

    
