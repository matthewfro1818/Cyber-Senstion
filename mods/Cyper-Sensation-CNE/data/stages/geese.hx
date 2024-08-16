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


function postCreate() {
    boyfriend.cameraOffset.x -= 200;

    

    boyfriend.cameraOffset.y -= 60;



    switch(dad.curCharacter)
    {
        case 'sticky':
            dad.y -= 340;
            dad.x -= 300;
            dad.cameraOffset.x -= 200;
            dad.cameraOffset.y -= 360;
        case 'geese':
            dad.y = 370;
            dad.x -= 300;
        case 'fever':
            dad.color = FlxColor.fromHSL(dad.color.hue, dad.color.saturation, 0.7, 0.7);
        case 'shini':
            dad.color = FlxColor.fromHSL(dad.color.hue, dad.color.saturation, 0.7, 0.7);
            dad.y += 80;
            dad.x -= 50;
            dad.cameraOffset.y -= 100;
    }


    boyfriend.color = FlxColor.fromHSL(boyfriend.color.hue, boyfriend.color.saturation, 0.7, 0.7);

    idkshade = new FunkinShader(Assets.getText(Paths.fragShader("blend")));
	camGame.addShader(idkshade);

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


    
