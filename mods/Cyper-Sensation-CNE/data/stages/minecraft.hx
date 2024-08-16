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


    var index = members.indexOf(dad);
    redad = new Character(dad.x, dad.y, 'bob', false);
    redad.flipY = true;
    redad.y = 715;
    redad.x = -29;
    redad.skew.x = -36;
    redad.color = FlxColor.BLACK;
    redad.alpha = 0.4;

    rebf = new Character(dad.x, dad.y, 'taeyai-v2', true);
    rebf.flipY = true;
    //1075 892 OLD
    rebf.y = 1060;
    rebf.x = 956;
    rebf.skew.x = 36;
    rebf.color = FlxColor.BLACK;
    rebf.alpha = 0.4;
    
    insert(index, rebf);
    insert(index, redad);

    bobblock = new FlxSprite(0, 0).loadGraphic(Paths.image("stages/bob/bobblock"));
    bobblock.frames = Paths.getSparrowAtlas('stages/bob/bobblock');
    bobblock.animation.addByPrefix('idle', "bob0", 24,false);

    bobblock.screenCenter(FlxAxes.Y);


    craft = new FlxSprite(0, 0).loadGraphic(Paths.image("stages/bob/craft"));
	craft.antialiasing = true;
	craft.updateHitbox();
	craft.screenCenter(FlxAxes.XY);
    craft.scale.set(0.7,0.7);
    craft.x += 100;
    craft.y += 500;

    bobblock.x = craft.x + 105;
    bobblock.y = craft.y -70;

    //add(bobblock);
	//add(craft);

    camGame.scroll.set(253,310);
    
}

function onCountdown(event) {
    if (event.swagCounter == 0)
        {
            FlxTween.tween(camGame, {zoom: 0.5}, 2, {ease: FlxEase.bounceOut});
        }
   
}

function beatHit()
{
    if (curBeat % 4 == 0)
        {
            bobblock.animation.play('idle');
        }

}

function postCreate() {
    camGame.zoom = 1;
    camGame.scroll.set(253,310);
    
    boyfriend.cameraOffset.x -= 200;
    dad.cameraOffset.x += 200;
    

    boyfriend.cameraOffset.y -= 40;
    rebf.cameraOffset.y = 10;
    dad.cameraOffset.y -= 330;


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

function stepHit()
    {
        switch(curStep){
            case 122:
                FlxTween.tween(camGame, {zoom: 1}, 1, {ease: FlxEase.bounceOut});
                FlxTween.tween(camFollow, {x: 440, y:700}, 1, {ease: FlxEase.bounceOut});
            case 128:
                
               start = true;
            }
        }

function postUpdate(elapsed:Float) { 


   if(start)
    {
        cpuStrums.characters = [dad,redad];
        playerStrums.characters = [boyfriend,rebf];
   
        if (curCameraTarget == 0)  
            {
                defaultCamZoom = 0.8;
                camFollow.setPosition(440, 700);
            }  
            else  
            { 
                defaultCamZoom = 0.6;
                camFollow.setPosition(940, 530);
            } 


            
    switch(strumLines.members[1].characters[0].getAnimName()) {
        case "singUP": 
            rebf.x = 966;
            rebf.y = 1110;
        case "singDOWN": 
            rebf.x = 926;
            rebf.y = 1010;
        default:
            rebf.y = 1060;
            rebf.x = 956;
    }
    }


}



    
