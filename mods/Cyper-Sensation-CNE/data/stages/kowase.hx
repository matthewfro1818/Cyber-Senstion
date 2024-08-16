import funkin.system.FunkinSprite;
import haxe.io.Path;

import flixel.addons.display.shapes.FlxShapeCircle;
var lineStyle:LineStyle = {color: FlxColor.BLACK, thickness: 1};
var drawStyle:DrawStyle = {smoothing: true};
public var canvas1:FlxShapeCircle;
public var canvas2:FlxShapeCircle;

var zoomar:Bool = false;
var superZoomar:Bool = false;
var hardZoom:Bool = false;
var multi:Float = 0.0;
var multi3:Float = 0.0;
if (FlxG.save.data.MiddleScroll) {
var strumPos = [[420, 50], [526, 50], [630, 50], [736, 50]]; //BF
var strumPos2 = [[80, 50], [186, 50], [965, 50], [1071, 50]]; // DAD
}
if(!FlxG.save.data.MiddleScroll) {
var strumPos = [[736, 50], [848, 50], [960, 50], [1072, 50]]; //BF
var strumPos2 = [[96, 50], [208, 50], [320, 50], [432, 50]]; // DAD
}

var t:FlxTween;
var t1:FlxTween;
var t2:FlxTween;
var t3:FlxTween;


var t4:FlxTween;
var t5:FlxTween;
var t6:FlxTween;
var t7:FlxTween;

var t8:FlxTween;
var t9:FlxTween;
var t10:FlxTween;
var t11:FlxTween;

var imgT:FlxTween;
var imgT2:FlxTween;

var timetobump:Bool = false;
var timetodie:Bool = false;
var imgGrps:FlxSpriteGroup;

function create() {
    var index = members.indexOf(strumLines.members[2].characters[0]);
	white = new FlxSprite(-800, -800);
	white.makeGraphic(FlxG.width * 2.3, FlxG.width * 2.3, 0xFFffffff);
	white.scrollFactor.set(0, 0);
	white.blend = 1;

    insert(index, white);
}

function postCreate()
{
	gffake = strumLines.members[0].characters[0];
    pico = strumLines.members[2].characters[0];

    gfStrum = strumLines.members[0];
    bfStrum = strumLines.members[1];
    picoStrum = strumLines.members[2];
    
    if(FlxG.save.data.MiddleScroll)
    {
        // Player MiddleScroll
        // TaeYai
        strumLines.members[1].members[0].setPosition(420,50);
        strumLines.members[1].members[1].setPosition(526,50);
        strumLines.members[1].members[2].setPosition(630,50);
        strumLines.members[1].members[3].setPosition(736,50);
        
        // Opponent Middle Scroll
        // Girlfriend
        strumLines.members[0].members[0].setPosition(80,50);
        strumLines.members[0].members[1].setPosition(186,50);
        strumLines.members[0].members[2].setPosition(965,50);
        strumLines.members[0].members[3].setPosition(1071,50);
        // Pico
        strumLines.members[2].members[0].setPosition(80,50);
        strumLines.members[2].members[1].setPosition(186,50);
        strumLines.members[2].members[2].setPosition(965,50);
        strumLines.members[2].members[3].setPosition(1071,50);
    }

	pico.y += 70;
	boyfriend.y += 70;
	boyfriend.flipX = false;
	boyfriend.isPlayer = true;

	pico.setPosition(-80,515);

	gffake.setPosition(-240,665);
	gffake.visible = pico.visible = false;

	for(s in gfStrum) {
		s.alpha = 0;
	 }
 
	 
	 for(s in picoStrum) {
		 s.alpha = 0;
	  }

    var index = members.indexOf(boyfriend);
	canvas1 = new FlxShapeCircle(boyfriend.x+20,boyfriend.y + 630,100,lineStyle,FlxColor.BLACK);
	insert(index,canvas1);
	canvas1.scale.x = 2;
	canvas1.scale.y = 0.5;
	canvas1.alpha = 0.3;

    var index = members.indexOf(pico);
	canvas2 = new FlxShapeCircle(-210,1275,100,lineStyle,FlxColor.BLACK);
	insert(index,canvas2);
	canvas2.scale.x = 2;
	canvas2.scale.y = 0.4;
	canvas2.alpha = 0.3;

	canvas3 = new FlxShapeCircle(75,1160,100,lineStyle,FlxColor.BLACK);
	insert(index,canvas3);
	canvas3.scale.x = 2;
	canvas3.scrollFactor = pico.scrollFactor;
	canvas3.scale.y = 0.5;
	canvas3.alpha = 0.3;

	eventbackground = new FlxSprite(0,0).makeGraphic(1280,720, 0xFF000000);
    eventbackground.alpha = 0;
    eventbackground.updateHitbox();
    eventbackground.scale.set(4,4);
    eventbackground.screenCenter(FlxAxes.X);
    eventbackground.scrollFactor.set();
    insert(index, eventbackground);

	eventbackground2 = new FlxSprite(200,-200).makeGraphic(1280,720, 0xFF000000);
	eventbackground2.alpha = 1;
	eventbackground2.updateHitbox();
	eventbackground2.scale.set(10,10);
	eventbackground2.cameras = [camGame];
	eventbackground2.screenCenter(FlxAxes.X);
	eventbackground2.scrollFactor.set(1,1);
	add(eventbackground2);



	
	camNewHUD.alpha = 0;

	camfx = new FlxCamera();
	camfx.bgColor = 0;
	FlxG.cameras.remove(camHUD, false);
	FlxG.cameras.remove(camNewHUD, false);
	FlxG.cameras.add(camfx, false);
	FlxG.cameras.add(camHUD, false);
	FlxG.cameras.add(camNewHUD, false);
	
	vignette=new FlxSprite().loadGraphic(Paths.image('stages/room/vignette'));
	vignette.screenCenter();
	vignette.cameras=[camfx];
	vignette.alpha=1;
	vignette.scrollFactor.set();
	add(vignette);

	crazyBG = new FlxSprite();
    crazyBG.loadGraphic(Paths.image("tex2"));

    crazyBG.antialiasing = true;
    crazyBG.setGraphicSize(FlxG.width,FlxG.height);
	crazyBG.cameras=[camfx];
	crazyBG.screenCenter(FlxAxes.XY);
	crazyBG.alpha = 0.1;
	crazyBG.visible = false;
	crazyBG.scrollFactor.set(1,1);



    imgGrps = new FlxSpriteGroup(0,0);
    imgGrps.cameras = [camfx];
	add(imgGrps);
	for(i in 0...2)
		{
			illusionPic = new FlxSprite(0,0);
			illusionPic.loadGraphic((Paths.image('illusion/'+i)));
			illusionPic.scrollFactor.set(0, 0);
			illusionPic.alpha = 0;
			illusionPic.cameras = [camfx];
			illusionPic.setGraphicSize(FlxG.width, FlxG.height);
			illusionPic.screenCenter(FlxAxes.XY);
			imgGrps.add(illusionPic);

		}
	add(crazyBG);
	
    idkshade = new FunkinShader(Assets.getText(Paths.fragShader("blend")));


	chromaticGame = new CustomShader("stupid");
	chromaticGame.chromaticAmount = 0.002;

	illusion = new CustomShader("illusion");
	if(FlxG.save.data.ShaderHigh)
    {
	drunk = new CustomShader("itfake");
	}
	crazyShad = new CustomShader("crazy");
	camGame.addShader(chromaticGame);
	crazyBG.shader = crazyShad;
	
	camGame.addShader(idkshade);

	blur = new CustomShader("radialBlur");
	blur.cx =  0.5;
	blur.cy =  0.5;
	blur.blurWidth = 0.0;
	camGame.addShader(blur);
	camHUD.addShader(blur);
	camNewHUD.addShader(blur);

	virusShader = new CustomShader('virus');
	virusShader.uEnabled = false;
	virusShader.screenSize = [1280, 720];
	virusShader.colorMultiplier = 1;
	virusShader.colorTransform = true;

	camGame.addShader(virusShader);
	camHUD.addShader(virusShader);
	camNewHUD.addShader(virusShader);

	boyfriend.color = FlxColor.fromHSL(boyfriend.color.hue, boyfriend.color.saturation, 0.7, 0.7);
	camZooming = false;
}
var whatit;
function jumpscare()
	{
		if(imgT != null) {imgT.cancel();}
		if(whatit != null) {whatit.alpha = 0;}
		whatit = imgGrps.members[FlxG.random.int(0,2)];
		whatit.alpha = 1;
		imgT = FlxTween.tween(whatit, {alpha: 0}, 1,{ease: FlxEase.quadInOut});
	}

function onNoteHit(event)
    {
        event.enableCamZooming = false;
    }

function onStrumCreation(event)
    {
                event.cancelAnimation();
    }

function onPostCountdown(event) {
    event.sprite.visible = false;
    


}

function onCountdown(event)
{
    event.volume = 0;
    if(event.swagCounter == 3)
        {

        
            for(s in strumLines.members[1]) {
                s.x += FlxG.width;
            }
        }
	if(event.swagCounter == 0)
	{

            
                for(s in strumLines.members[1]) {
                    FlxTween.tween(s, {x:s.x - FlxG.width}, 1.5, {ease: FlxEase.expoOut});
                }
	}
}
var time:Float = 0;
function update(elapsed)
{
	chars1.alpha = chars2.alpha = chars3.alpha = 0;

	time += elapsed;
    illusion.iTime = time;
    if(FlxG.save.data.ShaderHigh)
    {
	drunk.iTime = time;
	}
	crazyShad.iTime = time;
	multi3 = lerp(multi3,0.002,0.125);
    chromaticGame.chromaticAmount = multi3;

	multi = lerp(multi,0.0,0.125);
    blur.blurWidth = multi;
	virusShader.time = time;
}

function postUpdate(elapsed)
    {

    }

function bump()
    {
        FlxG.camera.zoom += 0.015;
        camHUD.zoom += 0.03;
		multi3 += 0.003;
    }        

function hardBump()
    {
        FlxG.camera.zoom += 0.3;
        camHUD.zoom += 0.03;
		multi3 += 0.007;
		multi+= 0.05;
    }
function onSongStart()
    {
	
        FlxTween.tween(eventbackground2, {alpha:0.7}, 4, {ease: FlxEase.backInOut});
		FlxTween.tween(camNewHUD, {alpha:1},1, {ease: FlxEase.cubeIn});
		FlxTween.tween(FlxG.camera, {zoom: 1}, 4, {ease: FlxEase.quadInOut});
		FlxTween.tween(camGame, {zoom: 1}, 4, {ease: FlxEase.quadInOut});
    }
function beatHit()
    {
		
		if (curBeat % 2 == 0 && timetodie)
            {
				jumpscare();
            }
        if (curBeat % 1 == 0 && timetodie)
            {
				jumpscare();
            }
		if (curBeat % 2 == 0 && timetobump)
            {
                notebump(true);
            }
        if (curBeat % 1 == 0 && timetobump)
            {
                notebump();
            }

        if (curBeat % 2 == 0 && zoomar)
            {
                FlxG.camera.zoom += 0.010;
                camHUD.zoom += 0.02;
            }

		if (curBeat % 2 == 0 && hardZoom)
            {
                FlxG.camera.zoom += 0.03;
                camHUD.zoom += 0.03;
            }
        if (curBeat % 1 == 0 && hardZoom)
            {
                hardBump();
            }
        if (curBeat % 1 == 0 && zoomar)
            {
                bump();
            }

        if (curBeat % 2 == 0 && superZoomar)
            {
                FlxG.camera.zoom += 0.03;
                camHUD.zoom += 0.06;
                multi3 += 0.002;
            }
        if (curBeat % 1 == 0 && superZoomar)
            {
                bump();
            }
    } 

function stepHit()
{
	if(curStep >= 1296 && curStep < 1552)
	{
		camGame.x = camHUD.x = camfx.x = camNewHUD.x = 0;
		camGame.y = camHUD.y = camfx.y = camNewHUD.y = 0;

		camGame.x += FlxG.random.int(-9,9);
		camGame.y += FlxG.random.int(-9,9);

		camHUD.x += FlxG.random.int(-9,9);
		camHUD.y += FlxG.random.int(-9,9);

		camfx.x += FlxG.random.int(-9,9);
		camfx.y += FlxG.random.int(-9,9);

		camNewHUD.x += FlxG.random.int(-9,9);
		camNewHUD.y += FlxG.random.int(-9,9);		
	}
	switch(curStep)
	{
		case 259:
			FlxTween.tween(camGame, {zoom: 2}, 3, {ease: FlxEase.quadInOut});
			FlxTween.tween(eventbackground2, {alpha:1}, 3, {ease: FlxEase.backInOut});
			FlxTween.tween(camNewHUD, {alpha:0},3, {ease: FlxEase.cubeIn});
			FlxTween.tween(camHUD, {alpha:0},3, {ease: FlxEase.cubeIn});
		case 290:
			eventbackground.alpha = 0.5;
			boyfriend.color = FlxColor.fromHSL(boyfriend.color.hue, boyfriend.color.saturation, 0.6, 0.6);
			gffake.color = FlxColor.fromHSL(gffake.color.hue, gffake.color.saturation, 0.6, 0.6);
			pico.color = FlxColor.fromHSL(pico.color.hue, pico.color.saturation, 0.6, 0.6);
			gffake.visible = pico.visible = true;

			for(s in gfStrum) {
				FlxTween.tween(s, {alpha: 1}, 6, {ease: FlxEase.quadInOut});
			 }
		 
			 
			 for(s in picoStrum) {
				FlxTween.tween(s, {alpha: 1}, 6, {ease: FlxEase.quadInOut});
			  }
			FlxTween.tween(camGame, {zoom: 0.7}, 6, {ease: FlxEase.quadInOut});
			FlxTween.tween(eventbackground2, {alpha:0.1}, 4, {ease: FlxEase.backInOut});
			FlxTween.tween(vignette, {alpha:0.1}, 6, {ease: FlxEase.backInOut});
			FlxTween.tween(camNewHUD, {alpha:1},6, {ease: FlxEase.cubeIn});
			FlxTween.tween(camHUD, {alpha:1},6, {ease: FlxEase.cubeIn});
			camGame.addShader(illusion);
		case 328:
			defaultCamZoom = 0.9;
			camZooming = true;
		case 392:
			defaultCamZoom = 0.6;
		case 452:
			cameraMovementEnabled = true;
			cameraMovementStrength = 4;
		case 464:
			zoomar = true;
		case 584:
			defaultCamZoom = 0.8;
		case 592:
			zoomar = false;
			superZoomar = true;
			camHUD.flash(FlxColor.WHITE, 0.2);
			defaultCamZoom = 0.6;
			camHUD.addShader(illusion);
		case 720:
			superZoomar = false;
		case 850:
			camZooming = false;
			FlxTween.tween(camGame, {zoom: 0.9}, 6, {ease: FlxEase.quadInOut});
			FlxTween.tween(eventbackground2, {alpha:0.6}, 6, {ease: FlxEase.backInOut});
			FlxTween.tween(vignette, {alpha:0.7}, 6, {ease: FlxEase.backInOut});
		case 912:
			camZooming = true;
			defaultCamZoom = 0.9;
		case 975:
			defaultCamZoom = 1;
			FlxTween.tween(eventbackground2, {alpha:0.7}, 1, {ease: FlxEase.backInOut});
			FlxTween.tween(vignette, {alpha:0.9}, 1, {ease: FlxEase.backInOut});
			camGame.angle = 10;
		case 988:
			camGame.visible = false;
		case 992:
			camGame.visible = true;
			camGame.angle = -10;
		case 1004:
			camGame.visible = false;
		case 1014:
			camZooming = false;
			eventbackground2.alpha = 1;
			camGame.visible = true;
			FlxTween.tween(eventbackground2, {alpha:0.4}, 1, {ease: FlxEase.backInOut});
			FlxTween.tween(vignette, {alpha:0.5}, 1, {ease: FlxEase.backInOut});
			camGame.angle = 0;
			FlxTween.tween(camGame, {zoom: 0.7}, 1, {ease: FlxEase.quadInOut});
		case 1040:
			camZooming = true;
			superZoomar = true;
			eventbackground2.alpha = vignette.alpha = 0.1;
			defaultCamZoom = 0.6;
			camHUD.flash(FlxColor.WHITE, 0.2);
			if(FlxG.save.data.ShaderHigh)
            {
			camGame.addShader(drunk);
			}
			timetobump = true;
		case 1296:
			camHUD.flash(FlxColor.WHITE, 0.2);
			virusShader.uEnabled = true;
			if(FlxG.save.data.ShaderHigh)
            {
			camGame.removeShader(drunk);
			camfx.addShader(drunk);
			}
			camfx.addShader(illusion);
			timetodie = true;
			crazyBG.visible = true;
			camGame.alpha = 0.4;
			hardZoom = true;
			zoomar = true;
		case 1424:
			camHUD.flash(FlxColor.WHITE, 0.2);
			virusShader.uEnabled = false;
			defaultCamZoom = 0.9;
			FlxTween.tween(camGame, {zoom: 0.9}, 1, {ease: FlxEase.quadInOut});
			FlxTween.tween(eventbackground2, {alpha:0.6}, 1, {ease: FlxEase.backInOut});
			FlxTween.tween(vignette, {alpha:0.7}, 1, {ease: FlxEase.backInOut});
			if(FlxG.save.data.ShaderHigh)
            {
			camGame.addShader(drunk);
			camfx.removeShader(drunk);
			}
			camfx.removeShader(illusion);
			timetodie = false;
			crazyBG.visible = false;
			camGame.alpha = 1;
			hardZoom = true;
			zoomar = false;
			timetobump = false;
			boyfriend.color = FlxColor.fromHSL(boyfriend.color.hue, boyfriend.color.saturation, 0.4, 0.4);
		case 1552:
			hardZoom = false;
			zoomar = false;
			superZoomar = false;
			FlxTween.tween(eventbackground2, {alpha:0.1}, 4, {ease: FlxEase.backInOut});
			FlxTween.tween(vignette, {alpha:0.1}, 6, {ease: FlxEase.backInOut});
			defaultCamZoom = 0.6;
			if(FlxG.save.data.ShaderHigh)
            {
			camGame.removeShader(drunk);
			}
			camGame.x = camHUD.x = camfx.x = camNewHUD.x = 0;
			camGame.y = camHUD.y = camfx.y = camNewHUD.y = 0;
			boyfriend.color = FlxColor.fromHSL(boyfriend.color.hue, boyfriend.color.saturation, 0.6, 0.6);
		case 1612:
			camZooming = false;
			FlxTween.tween(camGame, {zoom: 0.9}, 1, {ease: FlxEase.backInOut});
			FlxTween.tween(vignette, {alpha:0.5}, 1, {ease: FlxEase.backInOut});
		case 1723,1731,1738,1746,1834,1838,1841,1866,1884,1898,1901,1904,1906:
			camGame.zoom += 0.1;
		case 1752:
			camZooming = true;
			defaultCamZoom = 0.7;
			superZoomar = true;
		case 1779,1823:
			defaultCamZoom = 0.9;
		case 1805,1831,1844,1909:
			defaultCamZoom = 0.7;
		case 1974:
			camZooming = false;
			superZoomar = false;
			FlxTween.tween(camGame, {zoom: 0.9}, 1, {ease: FlxEase.quadInOut});
			FlxTween.tween(eventbackground2, {alpha:0.6}, 1, {ease: FlxEase.backInOut});
			FlxTween.tween(vignette, {alpha:0.7}, 1, {ease: FlxEase.backInOut});
		case 2012:
			FlxTween.tween(camGame, {zoom: 0.7}, 2, {ease: FlxEase.quadInOut});
			FlxTween.tween(eventbackground2, {alpha:0.3}, 2, {ease: FlxEase.backInOut});
			FlxTween.tween(vignette, {alpha:0.4}, 2, {ease: FlxEase.backInOut});
		case 2038:
			camZooming = true;
			superZoomar = true;
			eventbackground2.alpha = vignette.alpha = 0.1;
			defaultCamZoom = 0.6;
			camHUD.flash(FlxColor.WHITE, 0.2);
			if(FlxG.save.data.ShaderHigh)
            {
			camGame.addShader(drunk);
			}
			timetobump = true;
		case 2834:
			camZooming = false;
			superZoomar = false;
			camGame.alpha = camHUD.alpha = camNewHUD.alpha = 0;
			defaultCamZoom = 0.6;
			camHUD.flash(FlxColor.WHITE, 0.2);
			if(FlxG.save.data.ShaderHigh)
            {
			camGame.removeShader(drunk);
			}
			timetobump = false;
		case 2866:
			FlxTween.tween(camNewHUD, {alpha:1},2, {ease: FlxEase.quadInOut});
			FlxTween.tween(camHUD, {alpha:1},2, {ease: FlxEase.quadInOut});
			FlxTween.tween(camGame, {alpha:1},2, {ease: FlxEase.quadInOut});
			
			FlxTween.tween(camGame, {zoom: 0.9}, 2, {ease: FlxEase.quadInOut});
			FlxTween.tween(eventbackground2, {alpha:0.3}, 2, {ease: FlxEase.backInOut});
			FlxTween.tween(vignette, {alpha:0.4}, 2, {ease: FlxEase.backInOut});
		case 2929:
			FlxTween.tween(eventbackground2, {alpha:1}, 3, {ease: FlxEase.backInOut});
			FlxTween.tween(camNewHUD, {alpha:0},2, {ease: FlxEase.quadInOut});
			for(s in gfStrum) {
				FlxTween.tween(s, {alpha: 0}, 3, {ease: FlxEase.quadInOut});
			 }
		 
			 
			 for(s in picoStrum) {
				FlxTween.tween(s, {alpha: 0}, 3, {ease: FlxEase.quadInOut});
			  }
		case 3222:
			camHUD.alpha = 0;
	}

}









function notebump(reverse:Bool = false)
	{
		if(t != null)
		{
			t.cancel(); 
					
		}
	
		if(t1 != null)
		{
			t1.cancel();  
		}
		
		if(t2 != null)
		{
			t2.cancel();  
		}
	
				   
	
		
		if(t3 != null)
		{
			t3.cancel();  
		}
	
		if(t4 != null)
		{
			t4.cancel();  
		}
			
		if(t5 != null)
		{
			t5.cancel();  
		}
	
		if(t6 != null)
		{
			t6.cancel();  
		}
	
		if(t7 != null)
		{
			t7.cancel();  
		}

		if(t8 != null)
		{
			t8.cancel();  
		}
	
		if(t9 != null)
		{
			t9.cancel();  
		}
			
		if(t10 != null)
		{
			t10.cancel();  
		}
	
		if(t11 != null)
		{
			t11.cancel();  
		}

	
		
		if(reverse)
		{
			strumLines.members[1].members[0].angle = -10;
			strumLines.members[1].members[0].x -= 20;
			strumLines.members[1].members[0].y -= 40;
		
			strumLines.members[1].members[1].angle = -10;
			strumLines.members[1].members[1].x -= 40;
			strumLines.members[1].members[1].y += 40;
		
			strumLines.members[1].members[2].angle = 10;
			strumLines.members[1].members[2].x += 40;
			strumLines.members[1].members[2].y += 40;
		
			strumLines.members[1].members[3].angle = 10;
			strumLines.members[1].members[3].x += 20;
			strumLines.members[1].members[3].y -= 40;
		}
		else
		{
			strumLines.members[1].members[0].angle = -10;
			strumLines.members[1].members[0].x -= 40;
			strumLines.members[1].members[0].y += 20;
		
			strumLines.members[1].members[1].angle = -10;
			strumLines.members[1].members[1].x -= 40;
			strumLines.members[1].members[1].y -= 40;
		
			strumLines.members[1].members[2].angle = 10;
			strumLines.members[1].members[2].x += 40;
			strumLines.members[1].members[2].y -= 40;
		
			strumLines.members[1].members[3].angle = 10;
			strumLines.members[1].members[3].x += 40;
			strumLines.members[1].members[3].y += 20;
		}
	
		t = FlxTween.tween(strumLines.members[1].members[0], {x: strumPos[0][0], y: strumPos[0][1], angle:0}, 0.3,{ease: FlxEase.backInOut});
		t1 = FlxTween.tween(strumLines.members[1].members[1], {x: strumPos[1][0], y: strumPos[1][1], angle:0}, 0.3,{ease: FlxEase.backInOut});
		t2 = FlxTween.tween(strumLines.members[1].members[2], {x: strumPos[2][0], y: strumPos[2][1], angle:0}, 0.3,{ease: FlxEase.backInOut});
		t3 = FlxTween.tween(strumLines.members[1].members[3], {x: strumPos[3][0], y: strumPos[3][1], angle:0}, 0.3,{ease: FlxEase.backInOut});
	
		if(reverse)
			{
				strumLines.members[0].members[0].angle = -10;
				strumLines.members[0].members[0].x -= 40;
				strumLines.members[0].members[0].y -= 20;
			
				strumLines.members[0].members[1].angle = -10;
				strumLines.members[0].members[1].x -= 40;
				strumLines.members[0].members[1].y += 40;
			
				strumLines.members[0].members[2].angle = 10;
				strumLines.members[0].members[2].x += 40;
				strumLines.members[0].members[2].y += 40;
			
				strumLines.members[0].members[3].angle = 10;
				strumLines.members[0].members[3].x += 40;
				strumLines.members[0].members[3].y -= 20;

				strumLines.members[2].members[0].angle = -10;
				strumLines.members[2].members[0].x -= 40;
				strumLines.members[2].members[0].y -= 20;
			
				strumLines.members[2].members[1].angle = -10;
				strumLines.members[2].members[1].x -= 40;
				strumLines.members[2].members[1].y += 40;
			
				strumLines.members[2].members[2].angle = 10;
				strumLines.members[2].members[2].x += 40;
				strumLines.members[2].members[2].y += 40;
			
				strumLines.members[2].members[3].angle = 10;
				strumLines.members[2].members[3].x += 40;
				strumLines.members[2].members[3].y -= 20;
			}
			else
			{
				strumLines.members[0].members[0].angle = -10;
				strumLines.members[0].members[0].x -= 20;
				strumLines.members[0].members[0].y += 40;
			
				strumLines.members[0].members[1].angle = -10;
				strumLines.members[0].members[1].x -= 40;
				strumLines.members[0].members[1].y -= 40;
			
				strumLines.members[0].members[2].angle = 10;
				strumLines.members[0].members[2].x += 40;
				strumLines.members[0].members[2].y -= 40;
			
				strumLines.members[0].members[3].angle = 10;
				strumLines.members[0].members[3].x += 20;
				strumLines.members[0].members[3].y += 40;

				strumLines.members[2].members[0].angle = -10;
				strumLines.members[2].members[0].x -= 20;
				strumLines.members[2].members[0].y += 40;
			
				strumLines.members[2].members[1].angle = -10;
				strumLines.members[2].members[1].x -= 40;
				strumLines.members[2].members[1].y -= 40;
			
				strumLines.members[2].members[2].angle = 10;
				strumLines.members[2].members[2].x += 40;
				strumLines.members[2].members[2].y -= 40;
			
				strumLines.members[2].members[3].angle = 10;
				strumLines.members[2].members[3].x += 20;
				strumLines.members[2].members[3].y += 40;
			}
		t4 = FlxTween.tween(strumLines.members[0].members[0], {x: strumPos2[0][0], y: strumPos2[0][1], angle:0}, 0.3,{ease: FlxEase.backInOut});
		t5 = FlxTween.tween(strumLines.members[0].members[1], {x: strumPos2[1][0], y: strumPos2[1][1], angle:0}, 0.3,{ease: FlxEase.backInOut});
		t6 = FlxTween.tween(strumLines.members[0].members[2], {x: strumPos2[2][0], y: strumPos2[2][1], angle:0}, 0.3,{ease: FlxEase.backInOut});
		t7 = FlxTween.tween(strumLines.members[0].members[3], {x: strumPos2[3][0], y: strumPos2[3][1], angle:0}, 0.3,{ease: FlxEase.backInOut});

		t8 = FlxTween.tween(strumLines.members[2].members[0], {x: strumPos2[0][0], y: strumPos2[0][1], angle:0}, 0.3,{ease: FlxEase.backInOut});
		t9 = FlxTween.tween(strumLines.members[2].members[1], {x: strumPos2[1][0], y: strumPos2[1][1], angle:0}, 0.3,{ease: FlxEase.backInOut});
		t10 = FlxTween.tween(strumLines.members[2].members[2], {x: strumPos2[2][0], y: strumPos2[2][1], angle:0}, 0.3,{ease: FlxEase.backInOut});
		t11 = FlxTween.tween(strumLines.members[2].members[3], {x: strumPos2[3][0], y: strumPos2[3][1], angle:0}, 0.3,{ease: FlxEase.backInOut});
	}