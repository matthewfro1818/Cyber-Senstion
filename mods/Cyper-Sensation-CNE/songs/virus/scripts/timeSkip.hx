// TODO: REMOVE
return;
var time = 84500;

function postCreate() {
    for(sl in strumLines.members)
        sl.onNoteUpdate.add(updateNote);
    //camHUD.addShader(iLikeToMoveItMoveIt);
    
}

function update(elapsed) {
    if (!startingSong) {
        if (Conductor.songPosition < time)
            Conductor.songPosition = FlxG.sound.music.time = vocals.time = time;
    }
}

function updateNote(event) {
    if (event.note.strumTime < time) {
        event.cancel();
        deleteNote(event.note);
    }
}