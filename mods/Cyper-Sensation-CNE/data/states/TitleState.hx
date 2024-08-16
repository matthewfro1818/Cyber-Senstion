import flixel.util.FlxColor;
import funkin.game.HudCamera;
import flixel.FlxCamera;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import funkin.game.Stage;
import funkin.game.cutscenes.Cutscene;
import hxvlc.flixel.FlxVideo;
import funkin.game.cutscenes.ScriptedCutscene;
import funkin.game.cutscenes.VideoCutscene;
import hxvlc.flixel.FlxVideoSprite;
import haxe.io.FPHelper;
import funkin.backend.assets.ModsFolder;
import funkin.backend.MusicBeatState;
var titleTextSecond:FlxSprite;
var lasers:FlxSprite;
var logo:FlxSprite;
var videoCamera:FlxCamera;
public var skippable:Bool = true;
public static var ended:Bool = false;
function create() {
    trace('Last Hope? ' + FlxG.save.data.lasthope);
    if(!ended & !FlxG.save.data.lasthope)
    {
        videoCamera = new FlxCamera();
        videoCamera.bgColor = 0;
        FlxG.cameras.add(videoCamera, false);
        video = new FlxVideoSprite(FlxAxes.X,FlxAxes.Y);
        video.bitmap.onEndReached.add(close);
        trace(video.bitmap.onEndReached);
        video.cameras = [videoCamera];
        
        add(video);
        introsfx = FlxG.sound.load(Paths.sound('intro'), 1);
	
        playvideo('intro_1');
        skippedIntro = false;
        
        
    }

}

function playvideo(videoname) {
    trace('playvide');
    if (video.load('mods/' + ModsFolder.currentModFolder + '/videos/' + videoname + '.mp4'))
        new FlxTimer().start(0.001, function(tmr:FlxTimer) {
            video.play();
            introsfx.play();
        });
}

function videokill()
{
    video.destroy();
    introsfx.stop();
    videoCamera.visible = false;
}

function close()
    {
        remove(video);
        videoCamera.visible = false;
        FlxG.camera.flash(FlxColor.WHITE, 1);
        ended = true;
        trace(ended);
    }

function postCreate() {
    if(FlxG.save.data.lasthope)
        {
                FlxG.sound.music.stop();
                PlayState.storyWeek = 'last';
                PlayState.storyPlaylist = ['last hope'];
            
                trace(PlayState.storyPlaylist);
                PlayState.isStoryMode = true;
                PlayState.chartingMode = false;
                MusicBeatState.nextFrameSkip = true;
                MusicBeatState.skipTransIn = MusicBeatState.skipTransOut = true;
                PlayState.__loadSong(PlayState.storyPlaylist[0], 'regular');
                new FlxTimer().start(1, function(tmr:FlxTimer)
                {
                    FlxG.switchState(new PlayState());
                });
        }
    titleText.screenCenter(FlxAxes.X);
    
    titleTextSecond = new FlxSprite();
    titleTextSecond.frames = titleText.frames;
    titleTextSecond.setPosition(titleText.x, titleText.y);
    titleTextSecond.antialiasing = true;
    insert(members.indexOf(titleText), titleTextSecond);
    

    // TODO: DO A MORE OPTIMIZED WAY ON CODENAME
    for(spr in titleScreenSprites)
    {
        if(FlxG.save.data.thaiSub)
        {
            if(spr.name == 'logo-th')
                {
                    logo = spr;
                }
            if(spr.name == 'logo')
                {
                    spr.visible = false;
                }
        }
        else
        {

            if(spr.name == 'logo')
             {
                logo = spr;
             }
             if(spr.name == 'logo-th')
                {
                    spr.visible = false;
                }

        }
        switch(spr.name) {
            case "lasers":
                lasers = spr;
        }
    }

    versionShit = new FunkinText(5, FlxG.height - 2, 0, 'Cyber Sensation: Malware Breakout V1');
    versionShit.scrollFactor.set();
    versionShit.y -= versionShit.height;
    add(versionShit);

}

function postUpdate(elapsed:Float) {
    if(FlxG.save.data.lasthope) 
    {FlxG.sound.music.stop();}

    if(!FlxG.save.data.lasthope)
    {
        var lerp = FlxEase.sineOut(curBeatFloat % 1);
        titleTextSecond.scale.set(FlxMath.lerp(1.025, 1, lerp), FlxMath.lerp(1.05, 1, lerp));
        titleTextSecond.alpha = (1 - lerp) * 0.5;
    
        lasers.alpha = 0.5 + (0.25 * Math.sin(Math.PI * curBeatFloat / 4));

        if(!ended)
            {
                video.screenCenter(FlxAxes.XY);
                video.setGraphicSize(FlxG.width, FlxG.height);
                if (video.bitmap.isPlaying && controls.ACCEPT) {
                    videokill();
                    ended = true;
                    skippedIntro = true;
                }
            }
    }





}