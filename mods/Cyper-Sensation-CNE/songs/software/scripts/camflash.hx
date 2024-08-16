if (PlayState.difficulty.toLowerCase() != "ex") return;

var colorTransformShader:CustomShader;

function postCreate() {
	defaultCamZoom = 0.85;
	cameraMovementEnabled=false;
	colorTransformShader = new CustomShader("colorTransform");
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
function postUpdate(elapsed) {
	if ((curBeat >= 64 && curBeat < 96) || curBeat >= 98 && curBeat < 128 || (curBeat >= 160 && curBeat < 220) || (curBeat >= 224 && curBeat < 288)) {
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

function beatHit() {
	switch (curBeat) {
		case 64:
			cameraMovementEnabled=true;
			defaultCamZoom=0.7;
			camZoomingInterval = 1;
        case 98,160,224: camZoomingInterval = 1;
        case 96,128,220,288: camZoomingInterval = 4;
		case 127, 220:
			defaultCamZoom = 1;
			cameraMovementEnabled=false;
		case 156:
			defaultCamZoom = 0.85;
		case 160, 224:
			defaultCamZoom = 0.9;
	}

    if (curBeat >= 64  && curBeat < 96 || curBeat >= 98 && curBeat < 128 || curBeat >= 160 && curBeat < 220 || curBeat >= 224 && curBeat < 288)
    {
        FlxG.camera.zoom += 0.015;
        camHUD.zoom += 0.03;
        camHUD.angle = 2.5 * (curBeat % 2 == 0 ? 1 : -1);
    }
}

function destroy() FlxG.game.setFilters([]);
