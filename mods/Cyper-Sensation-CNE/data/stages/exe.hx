var sky:FlxSprite;
var backbush:FlxSprite;
var treeback:FlxSprite;
var topbushes:FlxSprite;
var fgTree1:FlxSprite;
var fgTree2:FlxSprite;
var p3staticbg:FlxSprite;
var backtreesXeno:FlxSprite;
var grassXeno:FlxSprite;
var daP3Static:FlxSprite;
var portchar:FlxSprite;
var portposition:Array<Float> = [-504.5,-216];
public var superZoomShit:Bool = false;
public var supersuperZoomShit:Bool = false;
public var zoomar:Bool = false;
var time:Float = 0;
var thread;
var floatvalve:Float = 0;
//Character
var shadum:Character;
var daisy:Character;
var futo:Character;
var shaStrums:StrumLine;
var strumPos = [[420, 50], [526, 50], [630, 50], [736, 50]]; //BF
var strumPos2 = [[80, 50], [186, 50], [965, 50], [1071, 50]]; // DAD
function onCountdown(event:CountdownEvent) {
    event.cancelled = true;
}

function update(elapsed) {
    time += elapsed;

    if (FlxG.save.data.ShaderHigh) { sky.shader.iTime = time; }
}

function postUpdate(elapsed)
{
	floatvalve += 0.06 * elapsed * 120;
	var sinvalve = Math.sin(floatvalve);
	var cosvalve = Math.cos(floatvalve);
	daisy.y += sinvalve * elapsed * 120;
	daisy.y += cosvalve * elapsed * 120;
}


function postCreate() {
    // playerStrums.cpu = true;

    shadum = new Character(150, -1000, "shadow taeyai");
	insert(members.indexOf(dad), shadum);

    daisy = new Character(1100, -300, "daisy-wrath");
	insert(members.indexOf(dad), daisy);

	futo = new Character(-1500, -130, "futo");
	insert(members.indexOf(dad), futo);

    //shaStrums = new StrumLine([shadum], -0.2, true, controls);
   	// players.push(shadum);
    //shaStrums.generateStrums();

	camGame.zoom = 3;
	FlxTween.tween(camGame, {zoom: 0.8}, 2, {ease: FlxEase.expoOut});

	
    dad.color = FlxColor.fromHSL(dad.color.hue, dad.color.saturation, 0.7, 0.7);
    boyfriend.color = FlxColor.fromHSL(boyfriend.color.hue, boyfriend.color.saturation, 0.7, 0.7);
	shadum.color = FlxColor.fromHSL(shadum.color.hue, shadum.color.saturation, 0.7, 0.7);
	daisy.color = FlxColor.fromHSL(daisy.color.hue, daisy.color.saturation, 0.7, 0.7);
	futo.color = FlxColor.fromHSL(futo.color.hue, futo.color.saturation, 0.7, 0.7);
	idkshade = new FunkinShader(Assets.getText(Paths.fragShader("blend")));
	camGame.addShader(idkshade);

}

function create()
{
    thread = EngineUtil.startMultithreadedScript(Paths.script('songs/cyber trouble/char-thread'));
    defaultCamZoom = 1;
    startedCountdown = true;
    preloadCharacter('shadow taeyai',150,0,false);
    preloadCharacter('daisy-wrath',1000,100,false);
	preloadCharacter('futo',-200,100,false);
    var i = 0;
    for(c in [boyfriend, dad]) {
        i++;
      
        c.shader = new CustomShader("garage-shadow");
        c.shader.color = [1, 120 / 236, 0.9, 0.33 * ((3 - i) / 2)];
        c.shader.shadowLength = 25 * ((3 - i) / 2);
        c.shader.flipped = c.flipX;
    }

    portchar = new FlxSprite(portposition[0] - 1200, -216).loadGraphic(Paths.image('stages/exe/CC'));
    portchar.scrollFactor.set(1,1);
    portchar.alpha = 0;
    portchar.scale.set(0.8,0.8);
    portchar.cameras = [camHUD];
    trace(portchar.y);
    add(portchar);  



    sky = new FlxSprite(-621.1, -395.65).loadGraphic(Paths.image('stages/exe/Phase3/glitch'));
    sky.scrollFactor.set(1,1);
    add(sky);

    if (FlxG.save.data.ShaderHigh) {
    sky.shader = new CustomShader('glitch');
    sky.shader.enabled = true;
    }
    trace('fuck LOL');

    backbush= new FlxSprite(-621.1, -395.65).loadGraphic(Paths.image('stages/exe/Phase3/normal/BackBush'));
    backbush.scrollFactor.set(1,1);
    add(backbush);

    treeback = new FlxSprite(-621.1, -395.65).loadGraphic(Paths.image('stages/exe/Phase3/normal/TTTrees'));
    treeback.active = false;
    add(treeback);

    topbushes = new FlxSprite(-621.1, -395.65).loadGraphic(Paths.image('stages/exe/Phase3/normal/TopBushes'));
    topbushes.active = false;
    add(topbushes);


    fgTree1 = new FlxSprite(-621.1, -395.65).loadGraphic(Paths.image('stages/exe/Phase3/normal/FGTree1'));
    fgTree1.scrollFactor.set(0.7,0.7);
    fgTree1.active = false;


    fgTree2 = new FlxSprite(-621.1, -395.65).loadGraphic(Paths.image('stages/exe/Phase3/normal/FGTree2'));
    fgTree2.scrollFactor.set(0.7,0.7);
    fgTree2.active = false;

    p3staticbg = new FlxSprite(0, 0).loadGraphic(Paths.image("stages/exe/NewTitleMenuBG"));
    p3staticbg.frames = Paths.getSparrowAtlas('stages/exe/NewTitleMenuBG');
    p3staticbg.animation.addByPrefix('idle', "TitleMenuSSBG instance 1", 24);
    p3staticbg.animation.play('idle');
    p3staticbg.screenCenter();
    p3staticbg.scale.x = 4.5;
    p3staticbg.scale.y = 4.5;
    p3staticbg.visible = false;
    add(p3staticbg);

    backtreesXeno = new FlxSprite(-621.1, -395.65).loadGraphic(Paths.image('stages/exe/Phase3/xeno/BackTrees'));
    backtreesXeno.active = false;
    backtreesXeno.visible = false;
    add(backtreesXeno);

    grassXeno = new FlxSprite(-621.1, -395.65).loadGraphic(Paths.image('stages/exe/Phase3/xeno/Grass'));
    grassXeno.active = false;
    grassXeno.visible = false;
    add(grassXeno);




    add(fgTree1);
    add(fgTree2);

	
	remove(dad);
    remove(boyfriend);
    dad.setPosition(150, -60);
    boyfriend.setPosition(1000, -60);
	insert(members.indexOf(fgTree1), dad);
	insert(members.indexOf(fgTree1), boyfriend);


}

function goofyAhhStatic(poopahahahaa:Float)
    {
        var index = members.indexOf(portchar);
        switch (poopahahahaa)
        {
            case 1:
                trace('p3static XDXDXD');
                daP3Static = new FlxSprite().loadGraphic(Paths.image('stages/exe/Phase3Static'));
                daP3Static.frames = Paths.getSparrowAtlas('stages/exe/Phase3Static');
                daP3Static.animation.addByPrefix('P3Static', 'Phase3Static instance 1', 24, false);
                daP3Static.screenCenter();

                daP3Static.scale.x = 4;
                daP3Static.scale.y = 4;
                daP3Static.alpha = 0.5;

                daP3Static.cameras = [camHUD];
                insert(index, daP3Static);
                daP3Static.animation.play('P3Static');

                daP3Static.animation.finishCallback = function(pog:String)
                {
                    trace('ended p3static');
                    daP3Static.alpha = 0;

                    remove(daP3Static);
                }
            }
    }

	function reverse()
	{
        trace('SWAPPING!');
        
        if (FlxG.save.data.MiddleScroll) {
            FlxTween.tween(strumLines.members[0].members[0], {x: strumPos[0][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[0].members[1], {x: strumPos[1][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[0].members[2], {x: strumPos[2][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[0].members[3], {x: strumPos[3][0]}, 0.5, {ease: FlxEase.backInOut});

            FlxTween.tween(strumLines.members[1].members[0], {x: strumPos2[0][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[1].members[1], {x: strumPos2[1][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[1].members[2], {x: strumPos2[2][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[1].members[3], {x: strumPos2[3][0]}, 0.5, {ease: FlxEase.backInOut});        
        }
        if (!FlxG.save.data.MiddleScroll) {
            playerStrums.forEach(function(spr:FlxSprite)
            {
                  
                spr.x -= 645;
            });
            cpuStrums.forEach(function(spr:FlxSprite)
            {
                
                spr.x += 645;						
            });
        }
        
	}

	function noteback()
	{
		trace('note went back');
		
		if (FlxG.save.data.MiddleScroll) {
		    FlxTween.tween(strumLines.members[1].members[0], {x: strumPos[0][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[1].members[1], {x: strumPos[1][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[1].members[2], {x: strumPos[2][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[1].members[3], {x: strumPos[3][0]}, 0.5, {ease: FlxEase.backInOut});

            FlxTween.tween(strumLines.members[0].members[0], {x: strumPos2[0][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[0].members[1], {x: strumPos2[1][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[0].members[2], {x: strumPos2[2][0]}, 0.5,{ease: FlxEase.backInOut});
            FlxTween.tween(strumLines.members[0].members[3], {x: strumPos2[3][0]}, 0.5, {ease: FlxEase.backInOut});        
		}
		if (!FlxG.save.data.MiddleScroll) {
    		playerStrums.forEach(function(spr:FlxSprite)
    		{
    			spr.x += 645;
    		});
    		cpuStrums.forEach(function(spr:FlxSprite)
    		{
    			spr.x -= 645;
    		});
		}
	}
function stepHit() {
    switch (curStep)
				{
					/*
					this shit is goin unused since all the dash sound effects are on ring note hits lol
					case 1431, 1496, 1560, 1624, 1687, 1816, 1879, 1928, 1932, 1944, 2008, 2072, 2136, 2200, 2264:
						strumLineNotes.forEach(function(tospin:FlxSprite)
							{
								FlxTween.angle(tospin, 0, 360, 0.2, {ease: FlxEase.quintOut});
							});
					*/
					case 1:
                        
						goofyAhhStatic(1);
                        FlxTween.tween(portchar, {alpha: 1.3}, 1.5, {ease: FlxEase.quadInOut});
                        FlxTween.tween(portchar, {x: portposition[0]}, 1.5, {ease: FlxEase.quadInOut});
						FlxTween.tween(FlxG.camera, {zoom: 1.3}, 2.5, {ease: FlxEase.quadInOut});
					case 16:
                        
						FlxTween.cancelTweensOf(FlxG.camera);
                        camHUD.flash(FlxColor.WHITE, 0.2);
                        FlxTween.tween(portchar.scale, {x: 1.3, y:1.3}, 0.2, {ease: FlxEase.quadInOut});
                        FlxTween.tween(portchar, {alpha: 0}, 0.3, {ease: FlxEase.quadInOut});
                        
						FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 1, {ease: FlxEase.elasticOut});

                        case 399:
						superZoomShit = true;
					case 400:
						defaultCamZoom = 0.75;
					case 416:
						defaultCamZoom = 0.80;
					case 432:
						defaultCamZoom = 0.85;
					case 448:
						defaultCamZoom = 0.9;
					case 464:
						defaultCamZoom = 0.95;
					case 480:
						defaultCamZoom = 1;
					case 496:
						defaultCamZoom = 1.05;
					case 512:
						defaultCamZoom = 1.1;
					case 527:
						supersuperZoomShit = true;
						superZoomShit = false;
					case 528:
						defaultCamZoom = 0.7;
					case 783:
						supersuperZoomShit = false;
						zoomar = true;
					case 1024:
						goofyAhhStatic(1);
						portchar.loadGraphic(Paths.image('stages/exe/shadum'));
						portchar.x = portposition[0] - 1200;
						portchar.scale.set(1,1);
						FlxTween.tween(portchar, {alpha: 1.3}, 1.5, {ease: FlxEase.quadInOut});
                        FlxTween.tween(portchar, {x: portposition[0]}, 1.5, {ease: FlxEase.quadInOut});
                    case 1038:
                        FlxTween.tween(dad, {x: -1400, y:0}, 0.7, {ease: FlxEase.quadInOut});
					
                        FlxTween.tween(shadum, {x: 150, y:0}, 1, {ease: FlxEase.quadInOut});
						FlxTween.tween(portchar.scale, {x: 1.3, y:1.3}, 0.2, {ease: FlxEase.quadInOut});
                        FlxTween.tween(portchar, {alpha: 0}, 0.3, {ease: FlxEase.quadInOut});
					case 1040:
                            
						defaultCamZoom = 0.9;
						//dad.x -= 400;
					//	dad.y -= 400;
                    
                        
            
            
                        dad = shadum;
						fgTree1.alpha = 0;
						fgTree2.alpha = 0;
	
						backtreesXeno.visible = true;
						grassXeno.visible = true;
						//p3staticbg.visible = true;
						zoomar = false;
	
					case 1158:
						zoomar =true;
					case 1296://AIEEEEEEEEEEEEEEEEEEEEEEEEE
						zoomar =false;

						//dad strums is on bf side, bf strums is on dad side
                        FlxTween.tween(shadum, {x: 150, y:-1200}, 0.3, {ease: FlxEase.quadInOut});
                        FlxTween.tween(daisy, {x: 100, y:-200}, 0.6, {ease: FlxEase.quadInOut});
                        
						reverse();
                        dad = daisy;
                        
                        FlxTween.tween(boyfriend, {x: 150, y:-60}, 0.7, {ease: FlxEase.quadInOut});
                        boyfriend.flipX = true;
						
						//

	
						fgTree1.alpha = 1;
						fgTree2.alpha = 1;
	
						backtreesXeno.visible = false;
						grassXeno.visible = false;
						//p3staticbg.visible = false;
	
						defaultCamZoom = 0.7;
					case 1424:
						superZoomShit = true;
					case 1663:
						superZoomShit = false;
					case 1664:
						supersuperZoomShit = true;
					case 1679:
						supersuperZoomShit = false;
					case 1920:
						defaultCamZoom = 0.8;
					case 1924:
						defaultCamZoom = 0.9;
					case 1928:
						defaultCamZoom = 1.2;
					case 1932:
						defaultCamZoom = 1.4;
					case 1935:
						supersuperZoomShit = true;
					case 1936:
						defaultCamZoom = 0.7;	
					case 2320:

						//back to default
                        FlxTween.tween(daisy, {x: 1100, y:-300}, 0.6, {ease: FlxEase.quadInOut});
                        FlxTween.tween(boyfriend, {x: 1000, y:-60}, 0.6, {ease: FlxEase.quadInOut});
                        boyfriend.flipX = false;
                        FlxTween.tween(shadum, {x: 150, y:0}, 1, {ease: FlxEase.quadInOut});
                        dad = shadum;
						
                        noteback();

						//

					//	dad.x -= 400;
					//	dad.y -= 400;
						supersuperZoomShit = false;
						superZoomShit = false;
						zoomar =true;
	
						defaultCamZoom = 0.9;
	
						fgTree1.alpha = 0;
						fgTree2.alpha = 0;
	
						grassXeno.angle = -30;
						backtreesXeno.y += 70;
	
						backtreesXeno.visible = true;
						grassXeno.visible = true;
						//p3staticbg.visible = true;
					case 2816: 
						goofyAhhStatic(1);
						portchar.loadGraphic(Paths.image('stages/exe/futo'));
						portchar.x = portposition[0] - 1200;
						portchar.scale.set(1,1);
						FlxTween.tween(portchar, {alpha: 1.3}, 1.5, {ease: FlxEase.quadInOut});
                        FlxTween.tween(portchar, {x: portposition[0]}, 1.5, {ease: FlxEase.quadInOut});
					case 2828:
						FlxTween.tween(shadum, {x: 150, y:-1500}, 1, {ease: FlxEase.quadInOut});
					case 2832: //FUTO
						FlxTween.tween(futo, {x: -140}, 0.6, {ease: FlxEase.quadInOut});
						superZoomShit = true;
						zoomar =false;
						dad = futo;
	
						fgTree1.alpha = 1;
						fgTree2.alpha = 1;
	
						fgTree1.x += -50;
	
						backtreesXeno.visible = false;
						grassXeno.visible = false;
	
						defaultCamZoom = 0.7;

						FlxTween.tween(portchar.scale, {x: 1.3, y:1.3}, 0.2, {ease: FlxEase.quadInOut});
                        FlxTween.tween(portchar, {alpha: 0}, 0.3, {ease: FlxEase.quadInOut});
					case 3202:
						goofyAhhStatic(1);
					case 4097:
						goofyAhhStatic(1);

					case 3457:
						goofyAhhStatic(1);
					
					case 4111: //Sha 3
						superZoomShit = false;
						zoomar =true;
						//dad.x -= 400;
						//dad.y -= 400;

						FlxTween.tween(futo, {x: 1800}, 0.6, {ease: FlxEase.quadInOut});
                        FlxTween.tween(boyfriend, {x: 1000, y:-60}, 0.6, {ease: FlxEase.quadInOut});
                     
                        FlxTween.tween(shadum, {x: 150, y:0}, 1, {ease: FlxEase.quadInOut});
                        dad = shadum;
	
						defaultCamZoom = 0.9;
	
						fgTree1.alpha = 0;
						fgTree2.alpha = 0;
	
						grassXeno.angle = -30;
						backtreesXeno.y += 70;
	
						backtreesXeno.visible = true;
						grassXeno.visible = true;
						//p3staticbg.visible = true;
					case 4372:
						camHUD.flash(FlxColor.WHITE, 0.3);
						supersuperZoomShit = true;
					case 4496:
						supersuperZoomShit = false;
						defaultCamZoom = 1;
					case 4500:
						camHUD.flash(FlxColor.WHITE, 0.3);
						supersuperZoomShit = true;
						defaultCamZoom = 0.8;
					case 4620:
						goofyAhhStatic(1);
					case 4624:
						zoomar =false;
						defaultCamZoom = 0.7;
						supersuperZoomShit = false;
						camHUD.flash(FlxColor.WHITE, 0.3);
						dad = strumLines.members[0].characters[0];
						shadum.visible = false;
						dad.setPosition(150, -60);

						defaultCamZoom = 1;
	
						sky.visible = true;
						backbush.visible=true;
						treeback.visible=true;
						topbushes.visible=true;
						fgTree1.alpha = 1;
						fgTree2.alpha = 1;

						backtreesXeno.visible = false;
						grassXeno.visible = false;
						//p3staticbg.visible = false;
					case 4748:
						goofyAhhStatic(1);
						
					
						
					case 4751:
						camHUD.flash(FlxColor.WHITE, 0.3);
						dad.setPosition(-1400, -60);
						dad = futo;
						futo.x = -140;
						defaultCamZoom = 0.9;
					case 4874:
						goofyAhhStatic(1);
					case 4880:
						camHUD.flash(FlxColor.WHITE, 0.3);
						superZoomShit = true;
						futo.visible = false;
						FlxTween.tween(daisy, {x: 100, y:-200}, 0.6, {ease: FlxEase.quadInOut});
                        dad = daisy;
						FlxTween.tween(boyfriend, {x: 150, y:-60}, 0.7, {ease: FlxEase.quadInOut});
                        boyfriend.flipX = true;
						reverse();
					case 5003:
						goofyAhhStatic(1);
					case 5007:
						camHUD.flash(FlxColor.WHITE, 0.3);
						noteback();
						FlxTween.tween(daisy, {x: 1100, y:-300}, 0.6, {ease: FlxEase.quadInOut});
                        FlxTween.tween(boyfriend, {x: 1000, y:-60}, 0.6, {ease: FlxEase.quadInOut});
                        boyfriend.flipX = false;
                        FlxTween.tween(shadum, {x: 150, y:0}, 1, {ease: FlxEase.quadInOut});
                        dad = shadum;
				
	
						defaultCamZoom = 0.9;
	
						fgTree1.alpha = 0;
						fgTree2.alpha = 0;
	
						grassXeno.angle = -30;
						backtreesXeno.y += 70;
	
						backtreesXeno.visible = true;
						grassXeno.visible = true;
						//p3staticbg.visible = true;

					case 5136:
						superZoomShit =	false;
						
						
				}
}

function beatHit()
{
    if (curBeat % 2 == 0 && superZoomShit)
        {
            FlxG.camera.zoom += 0.06;
            camHUD.zoom += 0.08;
        }

        if (curBeat % 1 == 0 && supersuperZoomShit)
        {
            FlxG.camera.zoom += 0.06;
            camHUD.zoom += 0.08;
        }
    if (curBeat % 4 == 0 && FlxG.camera.zoom < 1.35 && zoomar)
        {
            FlxG.camera.zoom += 0.015;
            camHUD.zoom += 0.03;
        }
}