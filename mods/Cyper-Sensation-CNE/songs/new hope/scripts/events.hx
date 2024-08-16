var time:Float = 0;
function postCreate()
    {
        var index = members.indexOf(boyfriend);
        eventbackground = new FlxSprite(0,0).makeGraphic(1280,720, 0xFF000000);
        eventbackground.alpha = 0;
        eventbackground.updateHitbox();
        eventbackground.scale.set(4,4);
        eventbackground.screenCenter(FlxAxes.X);
        eventbackground.scrollFactor.set();
        insert(index, eventbackground);

        eventwhite = new FlxSprite(0,0).makeGraphic(1280,720, 0xFFFFFFFF);
        eventwhite.alpha = 0;
        eventwhite.updateHitbox();
        eventwhite.scale.set(4,4);
        eventwhite.screenCenter(FlxAxes.X);
        eventwhite.scrollFactor.set();
        insert(index, eventwhite);

        eventbackground2 = new FlxSprite(200,-200).makeGraphic(1280,720, 0xFF000000);
        eventbackground2.alpha = 1;
        eventbackground2.updateHitbox();
        eventbackground2.scale.set(10,10);
        eventbackground2.cameras = [camRays];
        eventbackground2.screenCenter(FlxAxes.X);
        eventbackground2.scrollFactor.set(1,1);
        add(eventbackground2);

        eventbackground3 = new FlxSprite(dad.x,dad.y).makeGraphic(1280,720, 0xFFFFFFFF);
        eventbackground3.alpha = 0;
        eventbackground3.updateHitbox();
        eventbackground3.scale.set(4,4);
        eventbackground3.screenCenter(FlxAxes.X);
        eventbackground3.scrollFactor.set(1,1);
        add(eventbackground3);

        camNewHUD.alpha  = camHUD.alpha = 0;

        cameffect = new FlxCamera();
        cameffect.bgColor = 0;
        FlxG.cameras.add(cameffect, false);

        image = new FlxSprite(0, 0).loadGraphic(Paths.image('stages/tans/heart'));
        image.antialiasing = false;
        image.updateHitbox();
        image.screenCenter(FlxAxes.XY);
        image.cameras = [cameffect];

        image.alpha = 0;

        add(image);

        glitch = new CustomShader('screenglitch');
        glitch.enabled = false;
        camGame.addShader(glitch);
        camNoRays.addShader(glitch);
        camRays.addShader(glitch);

        hudglitch = new CustomShader('hudglitch');
        hudglitch.enabled = false;
        camHUD.addShader(hudglitch);
        camNewHUD.addShader(hudglitch);
        
        addMobileControls();
		mobileControls.visible = true;
    }

    function onCountdown(event)
        {
                event.volume = 0;
                if(event.swagCounter == 3)
                    {
                        for(s in strumLines.members[0]) {
                            s.x -= FlxG.width;
                        }
                    
                        for(s in strumLines.members[1]) {
                            s.x += FlxG.width;
                        }
                    }
        }
function bump()
    {
        FlxG.camera.zoom += 0.015;
        camHUD.zoom += 0.03;
    }        


function onSongStart()
    {
        FlxTween.tween(eventbackground2, {alpha:0}, 10, {ease: FlxEase.cubeIn});
    }
function update(elapsed:Float)
{
    time += elapsed;

    glitch.iTime = time;
    hudglitch.iTime = time;
}
function eheheh(side:Int)
{
    switch(side)
    {
        case 0:
            FlxTween.tween(camGame, {angle: -180}, 1, {ease: FlxEase.backInOut});
            FlxTween.tween(camRays, {angle: -180}, 1, {ease: FlxEase.backInOut});
            FlxTween.tween(camNoRays, {angle: -180}, 1, {ease: FlxEase.backInOut});
            FlxTween.tween(camHUD, {angle: -180}, 1, {ease: FlxEase.backInOut});
            FlxTween.tween(camNewHUD, {angle: -180}, 1, {ease: FlxEase.backInOut});
            
            
        case 1:
            FlxTween.tween(camGame, {angle: 0}, 1, {ease: FlxEase.backInOut});
            FlxTween.tween(camRays, {angle: 0}, 1, {ease: FlxEase.backInOut});
            FlxTween.tween(camNoRays, {angle: 0}, 1, {ease: FlxEase.backInOut});
            FlxTween.tween(camHUD, {angle: 0}, 1, {ease: FlxEase.backInOut});
            FlxTween.tween(camNewHUD, {angle: 0}, 1, {ease: FlxEase.backInOut});
    }
}

function beatHit()
{
    if(curBeat % 2 == 0)
    {
        image.scale.set(1.6,1.6);
        FlxTween.tween(image.scale, {x: 1,y:1}, 0.4, {ease: FlxEase.expoOut});
    }
}

function stepHit()
{
    switch(curStep)
    {
        case 48:
            FlxTween.tween(camHUD, {alpha: 1}, 1, {ease: FlxEase.cubeIn});
                FlxTween.tween(camNewHUD, {alpha:1},1, {ease: FlxEase.cubeIn});
                for(s in strumLines.members[0]) {
                    FlxTween.tween(s, {x:s.x + FlxG.width}, 1.5, {ease: FlxEase.expoOut});
                }
            
                for(s in strumLines.members[1]) {
                    FlxTween.tween(s, {x:s.x - FlxG.width}, 1.5, {ease: FlxEase.expoOut});
                }  
        case 191:
            camZooming = false;
            FlxTween.tween(camGame, {zoom: 1},1, {ease: FlxEase.backInOut});
        case 248:
            FlxTween.tween(camGame, {zoom: 0.4},1, {ease: FlxEase.backInOut});
        case 256:
            camZooming = true;
            eheheh(0);
        case 320:
            eheheh(1);
        case 384:
            camZooming = false;
            FlxTween.tween(camGame, {zoom: 1},1, {ease: FlxEase.backInOut});
        case 432:
            glitch.enabled = true;
            hudglitch.enabled = true;
            new FlxTimer().start(0.5, function(tmr:FlxTimer)
            {
                glitch.enabled = false;
                hudglitch.enabled = false;
                camGame.alpha = camNoRays.alpha = camHUD.alpha = camNewHUD.alpha = 0;
                eventbackground2.alpha = 1;
                cpuStrums.forEach(function(spr:FlxSprite)
                    {
                        
                        spr.visible = false;					
                    });
            });
        case 448:
            FlxTween.tween(image, {alpha: 1}, 10, {ease: FlxEase.backInOut});
            
        case 567:
            FlxTween.tween(camHUD, {alpha: 1}, 0.5, {ease: FlxEase.backInOut});
        case 694:
            dad.colorTransform.redOffset = dad.colorTransform.greenOffset = dad.colorTransform.blueOffset = 255;
            boyfriend.colorTransform.redOffset = boyfriend.colorTransform.greenOffset = boyfriend.colorTransform.blueOffset = 255;
            FlxTween.tween(eventbackground2, {alpha: 0},1, {ease: FlxEase.expoOut});
            eventbackground.alpha = 1;
            image.alpha = 0;
            FlxTween.tween(camGame, {zoom: 1},3, {ease: FlxEase.backInOut});
        case 703:
            dad.colorTransform.redOffset = dad.colorTransform.greenOffset = dad.colorTransform.blueOffset = 0;
            boyfriend.colorTransform.redOffset = boyfriend.colorTransform.greenOffset = boyfriend.colorTransform.blueOffset = 0;
            eventbackground.alpha = 0;
            eventbackground2.alpha = 1;
        case 716:
            camGame.alpha = camNoRays.alpha = camHUD.alpha = camNewHUD.alpha = 1;
            camGame.flash(FlxColor.WHITE, 0.5);
            eventbackground.alpha = 0;
            eventbackground2.alpha = 0;
            camZooming = true;
            FlxTween.tween(camGame, {zoom: 0.4},3, {ease: FlxEase.backInOut});
            cpuStrums.forEach(function(spr:FlxSprite)
                {
                    
                    spr.visible = true;					
                });
        case 848:
            camZooming = false;
            FlxTween.tween(camGame, {zoom: 1},1, {ease: FlxEase.backInOut});
            glitch.enabled = true;
            hudglitch.enabled = true;
            new FlxTimer().start(0.5, function(tmr:FlxTimer)
            {
                glitch.enabled = false;
                hudglitch.enabled = false;
            });
        
        case 861:
            eheheh(0);
            dad.playAnim('eye');
        case 863:
            camHUD.flash(FlxColor.WHITE, 0.5);
            FlxTween.tween(camGame, {zoom: 0.4},1, {ease: FlxEase.backInOut});
        case 976:
            eheheh(1);
        case 1103:
            FlxTween.tween(eventbackground2, {alpha: 1}, 2, {ease: FlxEase.backInOut});
            
    }
}

function onNoteHit(event)
    {
        event.enableCamZooming = false;
    }

    function Countdown(swagCounter:Int) {
        switch(swagCounter) {
            case 0:
                three = new FunkinText(0, 0, 0, '3', 72, true);
                three.antialiasing = true;
                three.updateHitbox();
                three.cameras = [cameffect];
                three.screenCenter(FlxAxes.XY);
                
                
                add(three);


                FlxTween.tween(three, {alpha: 0}, Conductor.crochet / 1000, {
                    ease: FlxEase.cubeIn
                });

            case 1:
               
    
            two = new FunkinText(0, 0, 0, '2', 72, true);
            two.antialiasing = true;
            two.updateHitbox();
            two.cameras = [cameffect];
            two.screenCenter(FlxAxes.XY);
            

            add(two);
    
            FlxTween.tween(two, {alpha: 0}, Conductor.crochet / 1000, {
                ease: FlxEase.cubeIn
            });
    
            case 2:
               
    
            one = new FunkinText(0, 0, 0, '1', 72, true);
            one.antialiasing = true;
            one.updateHitbox();
            one.cameras = [cameffect];
            one.screenCenter(FlxAxes.XY);
            add(one);

    

                FlxTween.tween(one, {alpha: 0}, Conductor.crochet / 1000, {
                    ease: FlxEase.cubeIn
                });
            case 3:
              
    
                go = new FunkinText(0, 0, 0, 'GO!', 72, true);
                go.antialiasing = true;
                go.updateHitbox();
                go.cameras = [cameffect];
                go.screenCenter(FlxAxes.XY);
                
                add(go);

    
                FlxTween.tween(go, {width: 215, height: 33}, Conductor.crochet / 1000, {
                    ease: FlxEase.cubeOut,
                    onComplete: function() {
                        go.destroy();
                        remove(go, true);
                    }
                });
                FlxTween.tween(go, {alpha: 0}, Conductor.crochet / 1000, {
                    ease: FlxEase.cubeIn, onComplete: function() {
                        go.destroy();
                        remove(go);
                        one.destroy();
                        remove(one);
                        two.destroy();
                        remove(two);
                        three.destroy();
                        remove(three);
                    }
                });
                
        }
        
    }