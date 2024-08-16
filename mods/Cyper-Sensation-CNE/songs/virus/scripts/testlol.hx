import openfl.Lib;
import openfl.display.ShaderInput;
import openfl.display.BitmapData;
import openfl.display.Shader;
import openfl.filters.ShaderFilter;
var screenshader:CustomShader;
var time:Float = 0;
var on:Bool = false;
function postCreate() {
    screenshader = new CustomShader('glitchscreen');
    //screenshader.iChannel1 = Assets.getBitmapData(Paths.image("noise"));
    screenshader.uEnabled = false;
    addGameShader(screenshader);
}

function postUpdate(elapsed:Float) {
    if(on)
        {
            time += elapsed;
            screenshader.iTime = time;
            screenshader.density = (camHUD.zoom - 1) / 0.095;
        }

}

function stepHit(curStep) {
    switch (curStep)
    {
        case 1246:
            screenshader.uEnabled = false;
            on = false;
        case 1456:
            screenshader.uEnabled = false;
            on = false;
            
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