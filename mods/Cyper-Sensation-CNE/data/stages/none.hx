function create()
    {
        trace('HELP ME!');
        gf.visible = false;

        dad.cameraOffset.x -= 100;
        defaultCamZoom = 0.5;
        dad.playAnim('enter');
        boyfriend.visible = false;
    }
function postCreate()
{
    cpuStrums.forEach(function(spr:FlxSprite)
        {
            spr.alpha = 0;    
            spr.x -= FlxG.width;						
        });
}
function onCountdown(event) 
{
    event.volume = 0;
    event.cancel();
}