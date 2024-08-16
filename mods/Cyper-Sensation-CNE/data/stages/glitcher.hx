
var virusShaderEnabled:Bool = false;
var screeneffect:CustomShader;

var time:Float = 0;
function postCreate()
    {

        glitchbg.shader = new CustomShader('virus');
        glitchbg.shader.uEnabled = true;
        glitchbg.shader.screenSize = [1280, 720];
        glitchbg.shader.colorMultiplier = 0.1;
        glitchbg.shader.colorTransform = true;

        wire.visible = true;
        wire.shader = new CustomShader('glitch');
        wire.shader.enabled = true;
        wire.alpha = 0.3;

        dad.shader = new CustomShader('virus');
        dad.shader.uEnabled = true;
        dad.shader.colorMultiplier = 0.1;
        dad.shader.colorTransform = true;

        //boyfriend.color = FlxColor.fromHSL(boyfriend.color.hue, boyfriend.color.saturation, 0.4, 0.4);
        boyfriend.shader = new CustomShader('hex-shadow');

    }

    function update(elapsed) {
        time += elapsed;
    
        glitchbg.shader.time = time;

        wire.shader.iTime = time;
    }

    
function stepHit(curStep) {
    switch (curStep)
    {
        case 66:
            glitchbg.shader.uEnabled = false;
            FlxTween.tween(wire, {alpha: 0}, 0.2, {ease: FlxEase.circInOut});
            //Transition to normal
        case 65:
            camZoomingInterval = 1;
        case 576,1087,1359,1391,1423,1455:
            glitchbg.shader.uEnabled = true;

            FlxTween.tween(wire, {alpha: 0.4}, 0.2, {ease: FlxEase.cubeOut});
        case 832,1343,1375,1407,1439,1471:
            glitchbg.shader.uEnabled = false;
            FlxTween.tween(wire, {alpha: 0}, 0.2, {ease: FlxEase.circInOut});
        case 1727:
            camZoomingInterval = 4;
        case 2236:
            camHUD.fade(0xFF000000, Conductor.crochet / 500, false);
    }
}