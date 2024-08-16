import haxe.io.Path;
function update() {
    if (virtualPad.buttonX.justPressed) {
        CoolUtil.playMenuSong();
        FlxG.switchState(new MainMenuState());
    }
}
function onSongEnd()
{
    FlxG.switchState(new MainMenuState());
}