public var superZoomShit:Bool = false;
public var supersuperZoomShit:Bool = false;
public var zoomar:Bool = false;

function bump()
    {
        FlxG.camera.zoom += 0.015;
        camHUD.zoom += 0.03;
    }  

function stepHit()
{
    switch(curStep)
    {
        case 320:
            camHUD.flash(FlxColor.WHITE, 0.5);
            superZoomShit = true;
        case 448:
            camHUD.flash(FlxColor.WHITE, 0.5);
        case 576:
            superZoomShit=false;
            zoomar = true;
        case 824:
            zoomar = false;
        case 832:
            camHUD.flash(FlxColor.WHITE, 0.5);
            superZoomShit = true;
        case 952:
            superZoomShit = false;
            camZooming = false;
        case 960:
            camHUD.flash(FlxColor.WHITE, 0.5);
            superZoomShit = camZooming = true;
        case 1088:
            camHUD.flash(FlxColor.WHITE, 0.5);
        case 1216:
            superZoomShit = camZooming = false;
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