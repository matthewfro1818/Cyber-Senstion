public var superZoomShit:Bool = false;
public var supersuperZoomShit:Bool = false;
public var zoomar:Bool = false;

function create()
{

}

function bump()
    {
        FlxG.camera.zoom += 0.015;
        camHUD.zoom += 0.03;
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

function stepHit()
    {
        switch(curStep)
        {
            case 256:
                camHUD.flash(FlxColor.WHITE, 0.5);
            case 320,336,352,448,464,480:
                defaultCamZoom += 0.1;
            case 384:
                camHUD.flash(FlxColor.WHITE, 0.5);
                defaultCamZoom = 0.9;
            case 512,1280:
                camHUD.flash(FlxColor.WHITE, 0.5);
                defaultCamZoom = 0.8;
                zoomar = true;
            case 784,800,816,832,872,880,912,928,944,960,968,976,984:
                defaultCamZoom += 0.1;
            case 792,808,824,840,848,856,864,888,904,920,936,952,992,1000,1008,1016:
                switch(curCameraTarget)
                {
                    case 0:
                        if(defaultCamZoom > 0.7)
                            defaultCamZoom -= 0.1;
                        else
                            defaultCamZoom += 0.1;
                    case 1:
                        if(defaultCamZoom > 0.8)
                            defaultCamZoom -= 0.1;
                        else
                            defaultCamZoom += 0.1;
                }

            case 896:
                defaultCamZoom = 0.8;
            case 1024:
                camHUD.flash(FlxColor.WHITE, 0.5);
                defaultCamZoom = 1.1;
                zoomar = false;
            case 1152:
                camHUD.flash(FlxColor.WHITE, 0.5);
                defaultCamZoom = 0.9;
            case 1536:
                camHUD.flash(FlxColor.WHITE, 0.5);
                defaultCamZoom += 0.1;
            case 1544,1568,1584,1600,1624,1632,1648,1664,1704,1712,1720,1728,1753,1760,1768,1782,1790:
                defaultCamZoom -= 0.1;
            case 1552,1560,1576,1592,1608,1616,1620,1622,1640,1656,1672,1680,1688,1696,1736,1744,1746,1748,1750,1776:
                defaultCamZoom += 0.1;
            case 1792:
                camHUD.flash(FlxColor.WHITE, 0.5);
                defaultCamZoom = 0.8;
                zoomar = false;
            case 1856,1872,1888,1984,2000,2016:
                defaultCamZoom += 0.1;
            case 1904,2032:
                defaultCamZoom -= 0.1;
            case 1920:
                defaultCamZoom = 0.8;
        }
    }