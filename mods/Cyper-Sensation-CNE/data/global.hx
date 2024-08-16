import flixel.FlxG;
import flixel.graphics.FlxGraphic;
import funkin.backend.utils.NativeAPI;

PauseSubState.script = 'data/scripts/pause';
public var bt:FlxTween;
public var bt2:FlxTween;
public var time1:FlxTimer;

function onDiscordPresenceUpdate(event) {
    event.presenceData.largeImageKey = "shaggy";
    event.presenceData.details = event.presenceData.largeImageText = "Zoink!";
    event.presenceData.state = "";
    return;
    if (Std.isOfType(FlxG.state, PlayState) && PlayState.SONG.song.toLowerCase() == "virus") {
        event.presenceData.largeImageKey = "virus";
        event.presenceData.largeImageText = "^ω^";
        event.presenceData.state = "";
        event.presenceData.details = "???";
    } else {
        event.presenceData.details = "i like kissing men";
        event.presenceData.state = "";
    }
}

static var redirectStates:Map<FlxState, String> = [
    FreeplayState => "funkin/menus/FreeplayState",
];



function postStateSwitch()
    {
        camNewHUD = new FlxCamera();
        camNewHUD.bgColor = 0;
        FlxG.cameras.add(camNewHUD, false);

        soundicon = new FlxSprite(0, 0);
        soundicon.cameras = [camNewHUD];
        soundicon.antialiasing = true;
        soundicon.loadGraphic(Paths.image('game/sound/icon'));
        //image.setGraphicSize(FlxG.width * 1.4, FlxG.height * 1.4);
        soundicon.updateHitbox();
        soundicon.screenCenter(FlxAxes.XY);
        soundicon.alpha = 0;
        FlxG.state.add(soundicon);
        bars = new FlxTypedGroup();
        FlxG.state.add(bars);

        for (i in 0...10)
            {
                tmp = new FlxSprite(495+ i* 30, 465);
                tmp.makeGraphic(19, 22, 0xFFFFD0D0);
                tmp.cameras = [camNewHUD];
                tmp.alpha = 0;
                bars.add(tmp);
    
                //by--;
            }

    }
    var volDown = FlxG.sound.volumeDownKeys;
    var volUp = FlxG.sound.volumeUpKeys;
    var mutekey = FlxG.sound.muteKeys;
    function update()
        {
    
            if (FlxG.game.soundTray != null)
                {
                    FlxG.sound.soundTrayEnabled = false;
        
                    
                }
            
                if(FlxG.keys.anyJustReleased(volDown) || FlxG.keys.anyJustReleased(volUp) || FlxG.keys.anyJustReleased(mutekey))
                    {
                        if(bt != null) {bt.cancel();}
                        if(bt2 != null) {bt2.cancel();}
                        if(time1 != null) {time1.cancel();}
                        soundtraycustom();
                    }
        }


        function soundtraycustom():Void
            {
                var globalVolume:Int = Math.round(FlxG.sound.volume * 10);


        
                soundicon.alpha = 1;
                
                for (i in 0...bars.members.length)
                    {
                        var tmps:FlxSprite = bars.members[i];
                        FlxTween.cancelTweensOf(tmps);
                        if (i < globalVolume)
                            {
                                tmps.alpha = 1;
                            }
                            else
                            {
                               
                                tmps.alpha = 0.2;  
                               
                            }
                        if(FlxG.sound.muted) {tmps.alpha = 0;}
                            
                            
                    }
        
                if (FlxG.sound.muted)
                    {
                        globalVolume = 0;
                    }

                    if(FlxG.sound.muted)
                        {
                            soundicon.loadGraphic(Paths.image('game/sound/mute'));
                        }
                    else
                        {
                            soundicon.loadGraphic(Paths.image('game/sound/icon'));
                        }
            

                
                        trace(time1);
                    time1 = new FlxTimer().start(1, function(tmr:FlxTimer)
                        {
                            bt = FlxTween.tween(soundicon, {alpha: 0}, 1, {
                                ease: FlxEase.quadIn
                            });

                            trace(bt);
                            trace(bt2);
                            for (i in 0...bars.members.length)
                                {
                                        var tmps:FlxSprite = bars.members[i];
                                        FlxTween.cancelTweensOf(tmps);
                                        FlxTween.tween(tmps, {alpha: 0}, 1, {
                                            ease: FlxEase.quadIn
                                        });   
                                        
                                }
                            
                        });
                    
                        
            }
