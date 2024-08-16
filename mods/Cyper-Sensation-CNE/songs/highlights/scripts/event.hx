if (PlayState.difficulty.toLowerCase() != "ex") return;
function beatHit(curBeat){
    switch(curBeat){
        case 140:defaultCamZoom=0.9;
        case 148, 207:defaultCamZoom=1;
         case 158:defaultCamZoom=1.1;
         case 164:defaultCamZoom=0.8;
         case 204:defaultCamZoom=0.95;
         case 212:defaultCamZoom=0.85;
         case 248:defaultCamZoom=0.78;
    }
    if ((curBeat >= 68 && curBeat < 100) || (curBeat >= 132 && curBeat < 244)) {
        FlxG.camera.zoom += 0.015;
        camHUD.zoom += 0.03;
    }
}