import flixel.util.FlxSave;
import funkin.backend.assets.ModsFolder;

public var opponentMode:Bool;

function postCreate()
{
    /*
    for (i in 0...4) {
    strumLines.members[0].members[i].x = -875 + i * 105;
    strumLines.members[1].members[i].alpha = 0.5;
    }
    for (i in 0...2) {
    strumLines.members[1].members[i].x = 1410 + i * 105;
    }
    for (i in 2...4) {
    strumLines.members[1].members[i].x = 2000 + i * 105;
    }
    */

    if(FlxG.save.data.MiddleScroll)
    {
    for (i in 0...4) {
        playerStrums.members[i].x = 420 + i * 105;
        cpuStrums.members[i].y = 50 + i;
        playerStrums.members[i].y = 40 + i;
    }
    for (i in 3...4) {
        playerStrums.members[i].x = 422 + i * 105;
        playerStrums.members[i].y = 38 + i;
    }
    for (i in 2...4) {
        cpuStrums.members[i].x = 756 + i * 105;
        cpuStrums.members[i].y = 47 + i;
    }
    for (i in 0...2) {
        cpuStrums.members[i].x = 80 + i * 105;
    }
    }
}

function update()
{
    /*
    // New Middle Scroll
    for (i in 0...4) {
    strumLines.members[0].members[i].x = 400 + i * 105;
    strumLines.members[1].members[i].alpha = 0.5;
    }
    for (i in 0...2) {
    strumLines.members[1].members[i].x = 100 + i * 105;
    }
    for (i in 2...4) {
    strumLines.members[1].members[i].x = 750 + i * 105;
    }
    */
    
    if(FlxG.save.data.MiddleScroll)
    {
    for (i in 0...4) {
        cpuStrums.members[i].alpha = 0.7;
    }
    }
}


/*
if (FlxG.save.data.MiddleScroll)
{
    if (FlxG.save.data.downscroll)
    {
    for (i in 0...4) {
        playerStrums.members[i].x = 1700 + i * 105;
        cpuStrums.members[i].y = -50 + i;
        cpuStrums.members[i].alpha = 0.7;
    }
    for (i in 2...4) {
        cpuStrums.members[i].x = -525 + i * 105;
    }
    }
    if (!FlxG.save.data.downscroll)
    {
    for (i in 0...4) {
        playerStrums.members[i].x = 1700 + i * 105;
        cpuStrums.members[i].y = 50 + i;
        cpuStrums.members[i].alpha = 0.7;
    }
    for (i in 2...4) {
        cpuStrums.members[i].x = -525 + i * 105;
    }
    }
}
}
*/



/*
for (i in 0...4) {
    cpuStrums.members[i].x = -860 + i * 105;
    cpuStrums.members[i].y = 610 + i;
}
}
*/



/* alternative middle scroll
    for (i in 0...4) {
        playerStrums.members[i].x = 425 + i * 100;
        cpuStrums.members[i].x = -425 + i * 100;
}
}
*/