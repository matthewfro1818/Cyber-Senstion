import openfl.display.Shader;
import openfl.filters.ShaderFilter;
import funkin.backend.shaders.FunkinShader;
import openfl.display.BitmapData;
import openfl.display.ShaderInput;
import funkin.game.PlayState;
var rubyMid:FlxPoint = null;
var rayTracker:FlxSprite;
public var camRays:FlxCamera;
public var camNoRays:FlxCamera;
public var rayShader:FunkinShader;
public var bloomShader:FunkinShader;
var bloomtime:Float = 0;
function create()
    {
        camGame.scroll.set(dad.getMidpoint().x + 200,dad.getMidpoint().y);

    }
function postCreate() {
    light.blend = 0;
    camGame.scroll.set(dad.getMidpoint().x + 200,dad.getMidpoint().y);
    trace("balls");
    var i = 0;
    for(c in [boyfriend, dad]) {
        i++;

        c.shader = new CustomShader("garage-shadow");
        c.shader.color = [1, 249 / 255, 0.5, 0.33 * ((3 - i) / 2)];
        c.shader.shadowLength = 25 * ((3 - i) / 2);
        c.shader.flipped = c.flipX;
    }

    boyfriend.y = 130;
    boyfriend.cameraOffset.y += 100;
    dad.y +=  40;

    if(dad.curCharacter == 'cm-ruby')
        {
            dad.y -=  40;
        }

    if(PlayState.SONG.meta.displayName != 'Light It Up')
    {

        var index = members.indexOf(dad);
        redad = new Character(dad.x, dad.y, dad.curCharacter, false);
        redad.flipY = true;
        switch(dad.curCharacter)
        {
            case 'cm-ruby':
                redad.x = -114;
                redad.y = 770;

                redad.skew.x = -211;
                redad.skew.y = 0;
            case 'cm-cj':
                redad.x = -99;
                redad.y = 730;
 
                redad.skew.x = -211;
                redad.skew.y = -20;
        }

        redad.color = FlxColor.BLACK;
        redad.alpha = 0.4;
        redad.cameraOffset = dad.cameraOffset;
        redad.cameraOffset.x += 130;
        redad.cameraOffset.y -= 300;

        rebf = new Character(dad.x, dad.y, 'cm-tae', true);
        rebf.flipY = true;
        rebf.x = 590;
        rebf.y = 756;
        rebf.skew.x = -210;
        rebf.skew.y = -175;
        rebf.color = FlxColor.BLACK;
        rebf.alpha = 0.4;
        rebf.cameraOffset = boyfriend.cameraOffset;
        rebf.cameraOffset.y -= 300;
        insert(index, rebf);
        insert(index, redad);

        //Shader
        rayTracker = new FlxSprite(1430,145);
        rayTracker.active = false;
        rayTracker.scale.set(0.75,0.75);
        camRays = new FlxCamera();
        camRays.bgColor = 0;
        if(FlxG.save.data.ShaderHigh) {
        rayShader = new FunkinShader(Assets.getText(Paths.fragShader("godrays-morning")));
        camRays.addShader(rayShader);
        }
        
        camNoRays = new FlxCamera();
        camNoRays.bgColor = 0;
        FlxG.cameras.remove(camHUD, false);
        FlxG.cameras.remove(camNewHUD, false);
        FlxG.cameras.add(camRays, false);
        FlxG.cameras.add(camNoRays, false);
        FlxG.cameras.add(camHUD, false);
        FlxG.cameras.add(camNewHUD, false);
        
        if(FlxG.save.data.ShaderHigh) {
        bloomShader = new FunkinShader(Assets.getText(Paths.fragShader("bloom")));
        camGame.addShader(bloomShader);
        }
        dad.cameras = boyfriend.cameras = [camRays];
        rebf.cameras = redad.cameras = [camRays];
        rayTracker.cameras = [camNoRays];

        if(PlayState.SONG.meta.displayName != 'Coda')
            {
                cpuStrums.characters = [redad,dad];
                playerStrums.characters = [rebf,boyfriend];
            }
    
    
            if(PlayState.SONG.meta.displayName == 'Coda')
                {
                    redad.visible = rebf.visible = false;
                    dad.cameraOffset.y += 200;
                    FlxG.camera.followLerp = 99;
                    strumLines.members[1].characters[0].cameraOffset.x += 300;
                    strumLines.members[1].characters[0].cameraOffset.y += 200;
                    strumLines.members[0].characters[0].setPosition(140 ,125 );
                    strumLines.members[1].characters[0].setPosition(-205 ,225 );
                    strumLines.members[2].characters[0].cameraOffset.x += 300;
                    strumLines.members[6].characters[0].cameraOffset.x = 550;
                    strumLines.members[2].characters[0].setPosition(-105 ,90 );
                    strumLines.members[5].characters[0].setPosition(1020 ,95 );
                    strumLines.members[6].characters[0].setPosition(205,145);
                }
    }
    else
        {
            var index = members.indexOf(sofa);
            remove(bg);
            bg = new FlxSprite(-1050,-425).loadGraphic(Paths.image('stages/garage/evening'));
            bg.scrollFactor.set(0.95,0.95);
            bg.scale.set(0.75,0.75);
            insert(index,bg); 

            fade = new FlxSprite(-1050,-425).loadGraphic(Paths.image('stages/garage/fade'));
            fade.scrollFactor.set(0.95,0.95);
            fade.scale.set(0.75,0.75);
            insert(index,fade); 

            var index = members.indexOf(gf);
            remove(sofa);
            sofa = new FlxSprite(-1050,-525).loadGraphic(Paths.image('stages/garage/sofa-evening'));
            sofa.scrollFactor.set(0.95,0.95);
            sofa.scale.set(0.75,0.75);
            insert(index,sofa);    

            var index = members.indexOf(boyfriend);
            remove(light);
            light = new FlxSprite(-1050,-425).loadGraphic(Paths.image('stages/garage/light-evening'));
            light.scale.set(0.75,0.75);
            insert(index,light);

            dad.x -= 90;
            dad.y += 60;
            gf.y -= 40;
            gf.x -= 120;
            boyfriend.y += 50;

            //
            var index = members.indexOf(dad);
            redad = new Character(dad.x, dad.y, 'cm-cj', false);
            redad.flipY = true;
            redad.y = 775;
            redad.x = -204;
            redad.skew.x = -211;
            redad.skew.y = -20;
            redad.color = FlxColor.BLACK;
            redad.alpha = 0.4;
            redad.cameraOffset = dad.cameraOffset;
            redad.cameraOffset.x += 130;
            redad.cameraOffset.y -= 300;
            
            regf = new Character(gf.x, gf.y, 'cm-ruby', false);
            regf.flipY = true;

            regf.x = -144;
            regf.y = 774;
            regf.skew.x = -46;
            regf.skew.y = 0;
            regf.color = FlxColor.BLACK;
            regf.alpha = 0.4;
            regf.cameraOffset = gf.cameraOffset;
            regf.cameraOffset.y -= 300;
            rebf = new Character(dad.x, dad.y, 'cm-tae', true);
            rebf.flipY = true;
            //1075 892 OLD
            rebf.x = 575;
            rebf.y = 811;
            rebf.skew.x = -210;
            rebf.skew.y = -175;
            rebf.color = FlxColor.BLACK;
            rebf.alpha = 0.4;
            rebf.cameraOffset = boyfriend.cameraOffset;
            rebf.cameraOffset.y -= 300;
            insert(index, rebf);
            insert(index, redad);
            var index = members.indexOf(gf);
            insert(index, regf);
            //Shader
            rayTracker = new FlxSprite(1430,145);
            rayTracker.active = false;
            rayTracker.scale.set(0.75,0.75);

            camRays = new FlxCamera();
            camRays.bgColor = 0;

            if(FlxG.save.data.ShaderHigh) {
            rayShader = new FunkinShader(Assets.getText(Paths.fragShader("godrays")));
            camRays.addShader(rayShader);
            }

            
            camNoRays = new FlxCamera();
            camNoRays.bgColor = 0;

            FlxG.cameras.remove(camHUD, false);
            FlxG.cameras.remove(camNewHUD, false);
            FlxG.cameras.add(camRays, false);
            FlxG.cameras.add(camNoRays, false);
            FlxG.cameras.add(camHUD, false);
            FlxG.cameras.add(camNewHUD, false);
            
            if(FlxG.save.data.ShaderHigh) {
            bloomShader = new FunkinShader(Assets.getText(Paths.fragShader("bloom")));
            camGame.addShader(bloomShader);
            }

            dad.cameras = gf.cameras = boyfriend.cameras = [camRays];
            rebf.cameras = redad.cameras = regf.cameras = [camRays];

            rayTracker.cameras = [camNoRays];

            //Notes
            rubyMid = gf.getGraphicMidpoint();
            for(s in strumLines.members[2]) {
                s.cameras = [camRays];
                s.scrollFactor.set(0.8, 0.8);
                s.alpha = 0.4;
            }

            trace(FlxG.enableAntialiasing);

            //Shadow
            strumLines.members[2].characters = [regf,gf];
            cpuStrums.characters = [redad,dad];
            playerStrums.characters = [rebf,boyfriend];

        }


}

function onPostCountdown(event) {
    event.sprite.cameras  = [camNewHUD];
}

function update(elapsed:Float) {
    bloomtime += elapsed;
    
    if(FlxG.save.data.ShaderHigh) {
    bloomShader.iTime = bloomtime;
    }

    if(PlayState.SONG.meta.displayName == 'Light It Up')
    {
        for(s in strumLines.members[2]) {
            s.x = rubyMid.x + (Note.swagWidth * (s.ID - 1.5)) + (30 * Math.sin((curBeatFloat + s.ID) * Math.PI / 16));
            s.y = rubyMid.y - 100- (40 * Math.sin((curBeatFloat + s.ID) * Math.PI / 4));
            s.angle = (40 * Math.sin((curBeatFloat + s.ID) * Math.PI / 10));
        }
    }


}

function postUpdate(elapsed:Float)
    {
       //camFollow.setPosition(400, 500);
       // redad.alpha  =0;
		camRays.scroll.set(camGame.scroll.x, camGame.scroll.y);
		camRays.zoom = camGame.zoom;
		camNoRays.scroll.set(camGame.scroll.x, camGame.scroll.y);
		camNoRays.zoom = camGame.zoom;

        
        var rayPos = rayTracker.getGraphicMidpoint(null, camRays);

		rayPos.y -= camRays.height / 2;
		rayPos.x -= camRays.width / 2;
		rayPos.x *= camRays.zoom;
		rayPos.y *= camRays.zoom;
		rayPos.x += camRays.width / 2;
		rayPos.y += camRays.height / 2;

        if(FlxG.save.data.ShaderHigh) {
		rayShader._LightPos = [rayPos.x / camRays.width, rayPos.y / camRays.height];
		}

		rayPos.put();

        if(startedCountdown)
        {
            light.y = rayPos.x;
            light.x = rayPos.y;
        }

        if(PlayState.SONG.meta.displayName != 'Light It Up')
        {

            switch(dad.curCharacter)
            {
                case 'cm-ruby':
                    switch(strumLines.members[0].characters[0].getAnimName()) 
                    {
                        case "singUP": 
                            redad.x = -134;
                            redad.y = 805;
                        case "singDOWN":
                            redad.x = -94;
                            redad.y = 740;
                        default:
                            redad.x = -114;
                            redad.y = 770;
                    }

                    case  'cm-cj':
                        switch(strumLines.members[0].characters[0].getAnimName()) 
                        {
                            case "singUP": 
                                redad.x = -204;
                                redad.y = 760;
                            case "singDOWN":
                                redad.x = -79;
                                redad.y = 695;
                            case "singRIGHT":
                                redad.x = -99;
                                redad.y = 780;
                            default:
                                redad.x = -99;
                                redad.y = 730;
                        }

            }
            //Player
            switch(strumLines.members[1].characters[0].getAnimName()) {
                case "singDOWN","singRIGHT": 
                    rebf.x = 600;
                    rebf.y = 731;
                case "singUP": 
                    rebf.x = 590;
                    rebf.y = 786;
                default:
                    rebf.x = 590;
                    rebf.y = 756;
                    
            }

        }
        else
        {
            switch(curCameraTarget)
            {
                case 0:
                    camFollow.setPosition(282, 542.5);
                case 1:
                    camFollow.setPosition(792, 514.5);
                case 2:
                    camFollow.setPosition(391, 473.5);
            }

            switch(strumLines.members[1].characters[0].getAnimName()) {
                case "singDOWN": 
                    rebf.x = 610;
                    rebf.y = 771;
                case "singUP": 
                    rebf.x = 575;
                    rebf.y = 851;
                case "singRIGHT",'singLEFT': 
                    rebf.x = 575;
                    rebf.y = 811;
                default:
                    rebf.x = 575;
                    rebf.y = 811;
         
            }
    
    
    
            switch(strumLines.members[0].characters[0].getAnimName()) {
                case "singUP": 
                    redad.x = -319;
                    redad.y = 1015;
                default:
                    redad.x = -204;
                    redad.y = 775;
    
         
            }
    
            switch(strumLines.members[2].characters[0].getAnimName()) {
                //case "singRIGHT",'singLEFT': 
                   // regf.x = -144;
                    //regf.y = 774;
                case "singDOWN": 
                    regf.x = -89;
                    regf.y = 774;
                case "singUP": 
                    regf.x = -144;
                    regf.y = 829;
                default:
                    regf.x = -144;
                    regf.y = 774;
    
         
            }
        }







       /* var damngod = strumLines.members[2].characters[0];
        if (FlxG.keys.pressed.LEFT) damngod.x -= 5;
        if (FlxG.keys.pressed.RIGHT) damngod.x += 5;
        if (FlxG.keys.pressed.UP) damngod.y -= 5;
        if (FlxG.keys.pressed.DOWN) damngod.y += 5;
        if (FlxG.keys.pressed.SPACE) trace(damngod);*/


    }

function onStrumCreation(event)
    {
        if (event.player == 2)
            event.cancelAnimation();
    
    }
    
    function onPostNoteCreation(event)
        {
    
            if(event.strumLineID == 2)
                {
                    event.note.alpha = 0.4;
                }
                  
                
    
        }