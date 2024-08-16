
import funkin.backend.assets.ModsFolder;
import funkin.backend.shaders.FunkinShader;
import openfl.filters.ShaderFilter;
import openfl.utils.Assets;

var start:Bool = true;
var floatvalve:Float = 0;
var rebf:Character;
var light:FlxSprite;
function create() {
    


    var index = members.indexOf(dad);
    rebf = new Character(dad.x, dad.y, 'bf', false);
    rebf.flipX = false;
    rebf.flipY = true;
    rebf.y = 450;
    rebf.x = 891;
    rebf.skew.x = 36;
    rebf.blend = 0;
    rebf.color = FlxColor.RED;
    rebf.alpha = 0.1;
    if(PlayState.SONG.meta.displayName != 'Errorians' | PlayState.SONG.meta.displayName != 'Our Hope')
    {
      insert(index, rebf);

      for(s in strumLines.members[0]) {
        s.color = FlxColor.fromHSL(s.color.hue, 0.9, 0.4, 0.4);
     }
    }
    

    light = new FlxSprite(-1080, -865).loadGraphic(Paths.image('stages/shadow/light'));
    light.scale.set(1.5,1.5);
	light.alpha = 1;
	add(light);

    idkshade = new FunkinShader(Assets.getText(Paths.fragShader("blend")));
	camGame.addShader(idkshade);
}

function onPostNoteCreation(event)
    {

                    if(event.strumLineID == 0)
                    event.note.color = FlxColor.fromHSL(event.note.color.hue, 0.9, 0.4, 0.4);
                
    }
    


function onCountdown(event) {
    if (event.swagCounter == 0)
        {
            FlxTween.tween(camGame, {zoom: 0.4}, 2, {ease: FlxEase.cubeOut});
        }
   
}

function postCreate() {
    camGame.zoom = 1;
    camGame.scroll.set(-300,110);
    
    dad.x = -840;
    dad.y = -210;


          for(s in strumLines.members[0]) {
            s.color = FlxColor.fromHSL(s.color.hue, 0.9, 0.4, 0.4);
         }
        

    var i = 0;
        i++;

        dad.shader = new CustomShader("garage-shadow");
        dad.shader.color = [3, 249 / 255, 0.5, 0.33 * ((3 - i) / 3)];
        dad.shader.shadowLength = 35 * ((3 - i) / 2);
        dad.shader.flipped = false;

        boyfriend.shader = new CustomShader("garage-shadow");
        boyfriend.shader.color = [2, 249 / 255, 0.5, 0.33 * ((3 - i) / 3)];
        boyfriend.shader.shadowLength = 25 * ((3 - i) / 2);
        boyfriend.shader.flipped = true;
    
        boyfriend.color = FlxColor.fromHSL(boyfriend.color.hue, boyfriend.color.saturation, 0.4, 0.4);
        
        dad.color = FlxColor.fromHSL(dad.color.hue, dad.color.saturation, 0.4, 0.4);
    
} 


function postUpdate(elapsed:Float) { 

    

            floatvalve += 0.06 * elapsed * 120;
        
            var sinvalve = Math.sin(floatvalve);
            var cosvalve = Math.cos(floatvalve);
        
            dad.y += sinvalve * elapsed * 120;
            dad.y += cosvalve * elapsed * 120;
        


        if(PlayState.SONG.meta.displayName != 'Errorians' | PlayState.SONG.meta.displayName != 'Our Hope')
        {
            if(start)
                {
                    playerStrums.characters = [boyfriend,rebf];
        
                    if (curCameraTarget == 0)  
                        {
                            camFollow.setPosition(-400, -100);
                        }  
                        else  
                        { 
                            
                            camFollow.setPosition(640, 500);
                        } 
                }
            else
                {
                    camFollow.setPosition(300, -110);
                }
        }

            
    

    


} 

function stepHit()
    {
        switch(curStep){
            case 16:
                start = true;
            }

        if(PlayState.SONG.meta.displayName == "Our Hope")
        {
            switch(curStep)
            {
                case 5592:
                    light.alpha = 0;
                case 5857:
                    light.alpha = 1;
            }
        }

        if(PlayState.SONG.meta.displayName == 'Malware')
            {
                switch(curStep){
                        case 1167:
                            FlxTween.tween(light, {alpha: 0}, 1, {ease: FlxEase.cubeOut});
                            FlxTween.tween(dad, {alpha: 0}, 1, {ease: FlxEase.cubeOut});
                            FlxTween.color(boyfriend, 1, 0xFFd11608, 0xFF000000, {ease:FlxEase.cubeOut});
                            FlxTween.tween(rebf, {alpha: 0}, 1, {ease: FlxEase.cubeOut});
                            hook = true;
                        case 1424:
                            hook = false;
                            FlxTween.tween(camGame, {zoom: 0.4}, 3, {ease: FlxEase.cubeOut});
                            FlxTween.tween(light, {alpha: 1}, 2, {ease: FlxEase.cubeOut});
                            FlxTween.tween(dad, {alpha: 1}, 2, {ease: FlxEase.cubeOut});
                            colortween = FlxTween.color(boyfriend, 2, 0xFF000000, 0xFFFFFFFF, {ease:FlxEase.cubeOut});
                            FlxTween.tween(rebf, {alpha: 0.1}, 1, {ease: FlxEase.cubeOut});
                        case 1440:
                            if(colortween != null) {
                                colortween.cancel();
                            }
                            FlxTween.tween(camGame, {zoom: 0.6}, 3, {ease: FlxEase.cubeOut});
                           

                            boyfriend.color = FlxColor.fromHSL(boyfriend.color.hue, boyfriend.color.saturation, 0.4, 0.4); 
                
                    }
            }
    }


function addGameShader(shader:FlxShader)
    {
        var filter:ShaderFilter = null;
        if (FlxG.game._filters == null)
            FlxG.game._filters = [];
        FlxG.game._filters.push(filter = new ShaderFilter(shader));
        return filter;
    }
    function destroy() FlxG.game.setFilters([]);



    
