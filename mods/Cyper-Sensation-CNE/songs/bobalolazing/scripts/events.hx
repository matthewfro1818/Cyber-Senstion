import funkin.game.cutscenes.Cutscene;
import hxvlc.flixel.FlxVideoSprite;
import funkin.game.cutscenes.ScriptedCutscene;
import funkin.game.cutscenes.VideoCutscene;
import funkin.backend.assets.ModsFolder;
import funkin.backend.shaders.FunkinShader;
import openfl.filters.ShaderFilter;
import openfl.utils.Assets;

var videoCamera:FlxCamera;

var colorTransformShader:FunkinShader;
var cutsceneCamera:FlxCamera;
var video:FlxVideoSprite;
function create() {
    

    videoCamera = new FlxCamera();
    videoCamera.bgColor = 0;
    FlxG.cameras.add(videoCamera, false);

    video = new FlxVideoSprite(FlxAxes.X,FlxAxes.Y);
    video.cameras = [videoCamera];

    add(video);

    colorTransformShader = new FunkinShader(Assets.getText(Paths.fragShader("colorTransform")));
	colorTransformShader.redMultiplier = 1;
	colorTransformShader.greenMultiplier = 1;
	colorTransformShader.blueMultiplier = 1;
	colorTransformShader.alphaMultiplier = 1;
	colorTransformShader.redOffset = 0;
	colorTransformShader.greenOffset = 0;
	colorTransformShader.blueOffset = 0;
	colorTransformShader.alphaOffset = 0;
    camGame.addShader(colorTransformShader);





}

function videokill()
{
	video.destroy();
}


function videomidsong(videoname) 
    {
        trace('playvide');
        if (video.load('mods/' + ModsFolder.currentModFolder + '/videos/' + videoname + '.mp4'))
            new FlxTimer().start(0.001, function(tmr:FlxTimer) {
                video.play();
            });
    }

function postCreate() {

    camFX = new FlxCamera();
    camFX.bgColor = 0;
    FlxG.cameras.add(camFX, false);

    red = new FlxSprite(-800, -800);
	red.makeGraphic(FlxG.width * 2.3, FlxG.width * 2.3, 0xFFdb0000);
	red.scrollFactor.set(0, 0);
	red.alpha = 0;
	red.blend = 0;
	add(red);

    fortnite = new FlxSprite(0, 0).loadGraphic(Paths.image('stages/bob/meme/fortnite'));
	fortnite.scrollFactor.set(0, 0);
	fortnite.alpha = 0;
    fortnite.cameras = [camFX];
    fortnite.scale.set(0.5,0.5);
    fortnite.frames = Paths.getSparrowAtlas('stages/bob/meme/fortnite');
    fortnite.animation.addByPrefix('idle', "frame_", 24,true);
    fortnite.animation.play('idle');
	add(fortnite);


    
    jerma = new FlxSprite(0, 0).loadGraphic(Paths.image('stages/bob/meme/jerma'));
	jerma.scrollFactor.set(0, 0);
	jerma.alpha = 0;
	jerma.blend = 0;
    jerma.cameras = [camHUD];
	add(jerma);
    
    
} 

function postUpdate(elapsed:Float) { 
    video.screenCenter(FlxAxes.XY);
    video.setGraphicSize(FlxG.width, FlxG.height);

    if ((curBeat >= 100 && curBeat < 111) || curBeat >= 115 && curBeat < 128 || (curBeat >= 164 && curBeat < 176) || (curBeat >= 180 && curBeat < 191) || (curBeat >= 227 && curBeat < 256) || (curBeat >= 324 && curBeat < 336) || (curBeat >= 340 && curBeat < 352) || (curBeat >= 356 && curBeat < 369) || (curBeat >= 372 && curBeat < 385) || (curBeat >= 424 && curBeat < 435) || (curBeat >= 440 && curBeat < 467) || (curBeat >= 472 && curBeat < 484)) {
		var mul:Float = 1 + ((1 - ((curBeatFloat / 1) % 1)) * (1/3));
		
		colorTransformShader.redMultiplier = mul;
		colorTransformShader.greenMultiplier = mul;
		colorTransformShader.blueMultiplier = mul;
	} else {
		colorTransformShader.redMultiplier = 1;
		colorTransformShader.greenMultiplier = 1;
		colorTransformShader.blueMultiplier = 1;
	}
    camHUD.angle = lerp(camHUD.angle, 0, 0.125);


} 

function stepHit()
    {
        switch(curStep){
            case 128:
                start = true;
            case 257:
                FlxTween.tween(camGame, {zoom: 3}, 0.4, {ease: FlxEase.circIn});
                FlxTween.tween(red, {alpha: 1}, 0.2, {ease: FlxEase.circIn});
                FlxTween.tween(jerma, {alpha: 1}, 1);
            case 272:
                red.alpha = 0;
                jerma.alpha = 0;
            case 400:
                
                videomidsong('freddy');
                video.alpha = 1;
             case 428:
                FlxTween.tween(video, {alpha: 0}, 0.4, {ease: FlxEase.circIn});
            case 772:
               
                videomidsong('girl');
                FlxTween.tween(video, {alpha: 0.4}, 0.4, {ease: FlxEase.circIn});
               
            case 807:
                FlxTween.tween(video, {alpha: 0}, 0.4, {ease: FlxEase.circIn});

            case 848:
                fortnite.alpha = 1;
            case 864:
                fortnite.x = 900;
            case 880:
                fortnite.x = 0;
                fortnite.y = 400;
            case 896:
                fortnite.x = 900;

            case 912:
                FlxTween.tween(fortnite, {alpha: 0}, 1);
                FlxTween.tween(camGame, {zoom: 1}, 0.3, {ease: FlxEase.circIn});
            case 1679:
                
                videomidsong('spotify-1');
                FlxTween.tween(video, {alpha: 1}, 0.3, {ease: FlxEase.circIn});
            case 1694:
                video.alpha = 0;
                camHUD.flash(FlxColor.RED, 0.3);
            
            case 464,656,747,976,12926.1360,1696,1760,1824:
                FlxTween.tween(camGame, {zoom: 1}, 0.3, {ease: FlxEase.circIn});
        }
    }

    function beatHit()
        {
            if ((curBeat >= 100 && curBeat < 111) || curBeat >= 115 && curBeat < 128 || (curBeat >= 164 && curBeat < 176) || (curBeat >= 180 && curBeat < 191) || (curBeat >= 227 && curBeat < 256) || (curBeat >= 324 && curBeat < 336) || (curBeat >= 340 && curBeat < 352) || (curBeat >= 356 && curBeat < 369) || (curBeat >= 372 && curBeat < 385) || (curBeat >= 424 && curBeat < 435) || (curBeat >= 440 && curBeat < 467) || (curBeat >= 472 && curBeat < 484)) 
            {
                FlxG.camera.zoom += 0.015;
                camHUD.zoom += 0.03;
                camHUD.angle = 2.5 * (curBeat % 2 == 0 ? 1 : -1);
            }
        }



    
