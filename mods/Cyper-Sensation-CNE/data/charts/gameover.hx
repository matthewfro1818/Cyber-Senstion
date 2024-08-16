function onGameOver(event)
{
    trace('dead');
    switch(boyfriend.curCharacter)
    {
        case 'taeyai','taeyainoholo','taeyai-player','teayai-v2','veethreeleft','veethree','cm-tae','taescare':
            event.deathCharID= 'taeyaided';
            event.isPlayer = false;   
        case 'taeyaiex':
            event.deathCharID= 'extaliaded';
            event.isPlayer = false; 
        case 'bfex':
            event.deathCharID= 'bfexDEAD';
            event.isPlayer = false; 
    }
   
}