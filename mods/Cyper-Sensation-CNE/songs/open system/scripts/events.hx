if (PlayState.difficulty.toLowerCase() != "regular") return;
public var superZoomShit:Bool = false;
public var supersuperZoomShit:Bool = false;
public var zoomar:Bool = false;
function stepHit()
    {
        switch(curStep)
        {
            case 127:
                zoomar = true;
            case 256:
                zoomar = false;
                superZoomShit = true;
            case 511:
                superZoomShit = false;
                defaultCamZoom=0.9;
            case 701:
                FlxTween.tween(FlxG.camera, {zoom: 0.6}, 8.5, {ease: FlxEase.backIn});
			case 771:
                camHUD.flash(FlxColor.WHITE, 0.4);
                FlxG.camera.zoom += 1.06;
                supersuperZoomShit = true;
                defaultCamZoom=0.6;
            case 1024:
                supersuperZoomShit = false;
                camHUD.flash(FlxColor.WHITE, 0.4);
        }
    }

function beatHit()
{
    if (curBeat % 2 == 0 && superZoomShit)
        {
            FlxG.camera.zoom += 0.03;
            camHUD.zoom += 0.06;
        }
    if (curBeat % 1 == 0 && superZoomShit)
        {
            FlxG.camera.zoom += 0.04;
            camHUD.zoom += 0.07;
        }

        if (curBeat % 1 == 0 && supersuperZoomShit)
        {
            FlxG.camera.zoom += 0.06;
            camHUD.zoom += 0.08;
        }
    if (curBeat % 2 == 0 && zoomar)
        {
            FlxG.camera.zoom += 0.010;
            camHUD.zoom += 0.02;
        }
    if (curBeat % 1 == 0 && zoomar)
        {
            FlxG.camera.zoom += 0.015;
            camHUD.zoom += 0.03;
        }
}