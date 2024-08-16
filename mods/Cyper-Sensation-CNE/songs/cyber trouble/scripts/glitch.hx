import openfl.Lib;
import openfl.display.ShaderInput;
import openfl.display.BitmapData;
import openfl.display.Shader;
import openfl.filters.ShaderFilter;
var screenshader:CustomShader;
var timee:Float = 0;
function postCreate() {
    screenshader = new CustomShader('glitchscreen');
    screenshader.uEnabled = true;
    camGame.addShader(screenshader);
}

function postUpdate(elapsed:Float) {
    timee += elapsed;
    screenshader.iTime = timee;
}