import funkin.game.PlayState;
import funkin.backend.utils.NativeAPI;
var botplaytxt:FunkinText;
var speed:Float = 1;
var cutscene:Float = 0;
function postCreate(){
    botplaytxt = new FunkinText(525, 547, 0, "BOTPLAY", 24, true);
    botplaytxt.visible = false;
    botplaytxt.screenCenter(FlxAxes.X);
	botplaytxt.cameras = [camHUD];
	add(botplaytxt);
	
	if (FlxG.save.data.BotPlay) {
    addVirtualPad('NONE', 'A');
	addVirtualPadCamera();
	}
	
	/*
	if (downscroll) {
	creatortxt = new FunkinText(25, 1310, 0, "Fixed/Patched By KralOyuncuRBX", 24, true);
    creatortxt.visible = true;
	creatortxt.cameras = [camNewHUD];
	add(creatortxt);
	}
	if (!downscroll) {
	creatortxt = new FunkinText(25, 25, 0, "Fixed/Patched By KralOyuncuRBX", 24, true);
    creatortxt.visible = true;
	creatortxt.cameras = [camNewHUD];
	add(creatortxt);
	}
	*/
}

function update(elapsed:Float) {
        if(controls.ACCEPT && FlxG.save.data.BotPlay)
        {
            playerStrums.cpu = !playerStrums.cpu;
            botplaytxt.visible = !botplaytxt.visible;
            addVirtualPad('NONE', 'A_B_X_Y');
	        addVirtualPadCamera();
	        if(!playerStrums.cpu) { addVirtualPad('NONE', 'A'); addVirtualPadCamera(); }
        }

        if (FlxG.keys.pressed.THREE || virtualPad.buttonB.justPressed) speed += 0.1;
        if (FlxG.keys.pressed.ONE || virtualPad.buttonY.justPressed) speed -= 0.1;
        
        if (FlxG.keys.justPressed.TWO || virtualPad.buttonX.justPressed) speed = 1;
        if (FlxG.keys.pressed.FIVE) PlayState.instance.endSong();
                
        if (FlxG.keys.justPressed.O) NativeAPI.allocConsole();

        //TODO: make it work with note miss effects
        FlxG.timeScale = inst.pitch = vocals.pitch = speed;
        
}


PauseSubState.script = 'data/scripts/pause';

function destroy() {
    FlxG.timeScale = 1;
}
