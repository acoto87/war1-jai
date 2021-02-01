WarCampaignMapType :: enum {
    Humans01 :: 117;
    Orcs01;
    Humans02;
    Orcs02;
    Humans03;
    Orcs03;
    Humans04;
    Orcs04;
    Humans05;
    Orcs05;
    Humans06;
    Orcs06;
    Humans07;
    Orcs07;
    Humans08;
    Orcs08;
    Humans09;
    Orcs09;
    Humans10;
    Orcs10;
    Humans11;
    Orcs11;
    Humans12;
    Orcs12;
    Custom;
}

WarCampaignMapData :: struct {
    type: WarCampaignMapType;
    checkObjectivesFunc: WarCheckObjectivesFunc;
    objectives: string;
    briefingAudioId: WarAudioId;
    briefingText: string;
    briefingDuration: f32;
}

WarCheckObjectivesFunc :: #type (ctx: *WarContext) -> WarLevelResult;

getCampaignData :: (type: WarCampaignMapType) -> WarCampaignMapData {
    index := 0;
    while (index < campaignsData.count && campaignsData[index].type != type) {
        index += 1;
    }

    assert(index < campaignsData.count);
    return campaignsData[index];
}

checkMap01Objectives :: (ctx: *WarContext) -> WarLevelResult {
    // WarMap* map = context->map;
    // WarPlayerInfo* player = &map->players[0];

    // WarUnitType farmType = getUnitTypeForRace(WAR_UNIT_FARM_HUMANS, player->race);
    // WarUnitType barracksType =getUnitTypeForRace(WAR_UNIT_BARRACKS_HUMANS, player->race);

    // if (getNumberOfBuildingsOfType(context, player->index, farmType, true) >= 6 &&
    //     getNumberOfBuildingsOfType(context, player->index, barracksType, true) >= 1)
    // {
    //     return WAR_LEVEL_RESULT_WIN;
    // }

    // if (getTotalNumberOfUnits(context, player->index) == 0)
    // {
    //     return WAR_LEVEL_RESULT_LOSE;
    // }

    return WarLevelResult.None;
}

checkMap02Objectives :: (ctx: *WarContext) -> WarLevelResult {
    // WarMap* map = context->map;
    // WarPlayerInfo* player = &map->players[0];
    // WarPlayerInfo* enemy = &map->players[1];

    // if (getTotalNumberOfDudes(context, enemy->index) == 0)
    // {
    //     return WAR_LEVEL_RESULT_WIN;
    // }

    // if (getTotalNumberOfUnits(context, player->index) == 0)
    // {
    //     return WAR_LEVEL_RESULT_LOSE;
    // }

    return WarLevelResult.None;
}

checkCustomMapObjectives :: (ctx: *WarContext) -> WarLevelResult {
    // WarMap* map = context->map;
    // WarPlayerInfo* player = &map->players[0];
    // WarPlayerInfo* enemy = &map->players[1];

    // if (getTotalNumberOfUnits(context, enemy->index) == 0)
    // {
    //     return WAR_LEVEL_RESULT_WIN;
    // }

    // if (getTotalNumberOfUnits(context, player->index) == 0)
    // {
    //     return WAR_LEVEL_RESULT_LOSE;
    // }

    return WarLevelResult.None;
}

#scope_file

campaignsData := WarCampaignMapData.[
    WarCampaignMapData.{
        WarCampaignMapType.Humans01,
        checkMap01Objectives,
        "Build:\n\t6 farms\n\t1 barracks",
        WarAudioId.CampaignHumansIntro01,
        #string DONE
As a test of your abilities, the King has appointed
you as Regent over a small parcel of land. Since
we must keep our armies in the field well supplied,
you are to build the town into a farming center of
no less than 6 farms. Construction of a barracks
for defense is also advised, as our scouts have
reported Orc patrols in the area.
        DONE,
        24.0
    },
    WarCampaignMapData.{
        WarCampaignMapType.Orcs01,
        checkMap01Objectives,
        "Build:\n  6 farms\n  1 barracks",
        WarAudioId.CampaignOrcsIntro01,
        #string DONE
Blackhand has assigned you to an outpost in the
Swamps of Sorrow.  Your task is simple enough
that even the War Chief feels that you are capable
of it. Construct at least 6 farms, so that we may
keep our troops well fed and ready to do battle.
Only a fool would leave his treasures unguarded,
so you must also build a barracks for the defense
of these farms.
        DONE,
        28.0
    },
    WarCampaignMapData.{
        WarCampaignMapType.Humans02,
        checkMap02Objectives,
        "Defend town and\ndestroy orcs",
        WarAudioId.CampaignHumansIntro02,
        #string DONE
The Orcs around Grand Hamlet are becoming
increasingly brazen in their attacks, and our
spies inform us that they are amassing a large
army to march against the town.
The King is sending you, along with a small
detachment of troops, to rally the people and
defend the town against all opposition.
        DONE,
        20.0
    },
    WarCampaignMapData.{
        WarCampaignMapType.Orcs02,
        checkMap02Objectives,
        "Crush all opposition",
        WarAudioId.CampaignOrcsIntro02,
        #string DONE
Like the stinging of a wasp, the attacks from the
humans grow more and more bothersome.
You have been assigned to a small outpost on the
Borderlands of the Swamps of Sorrow.
You are to defend our lands from the incursions
of these ravenous dogs by crushing any opposition
that you encounter.
        DONE,
        22.0
    },
    WarCampaignMapData.{
        WarCampaignMapType.Humans03,
        null,
        "Destroy outpost",
        WarAudioId.CampaignHumansIntro03,
        #string DONE
With Blackhand's raiding parties routed, now is the time for
us to secure a lasting peace in the area around Grand Hamlet.
You must seek out the Orcish outpost of Kyross that lies deep
within the Swamps of Sorrow, and destroy it.
        DONE,
        22.0
    },
    WarCampaignMapData.{
        WarCampaignMapType.Orcs03,
        null,
        "Demolish Grand Hamlet",
        WarAudioId.CampaignOrcsIntro03,
        #string DONE
The Humans are growing strong in Grand Hamlet. An outpost will
be placed under your dictatorship to use as you see fit. You must
then prepare and lead a force to destroy Grand Hamlet and all that
dwell there. Blackhand will brook no survivors - these Humans must
be taught a hard lesson in the ways of humility.
        DONE,
        22.0
    },
    WarCampaignMapData.{
        WarCampaignMapType.Humans04,
        null,
        "Find lothar,\nheal him and bring\nthem out",
        WarAudioId.CampaignHumansIntro04,
        #string DONE
It has been some twenty months since Sir Lothar, one of the crown's
greatest heroes, led an expedition into the Dead Mines to search for
the Lost Tome of Divinity. They were never heard from again.
However, the great knight has recently appeared to the Abbot of
Northshire in a vision - battered and pleading for assistance.
King Llane has ordered you to lead a detachment of warriors and healers
into the mines in an attempt to find Sir Lothar, heal him, and bring him
and any other survivors back alive.
        DONE,
        22.0
    },
    WarCampaignMapData.{
        WarCampaignMapType.Orcs04,
        null,
        "Kill griselda and\nher minions",
        WarAudioId.CampaignOrcsIntro04,
        #string DONE
You are wakened from your nights sleep by a runner from the War Chief.
Blackhand's daughter Griselda has run off with the outlaw Turok's band of Ogres.
Our wolfriders have tracked them to the dungeons hidden beneath the Dead Mines.
Find Turok's band of rebellious pigs and kill them all --- including Griselda.
She must not disobey the commands of her father... ever again.
        DONE,
        22.0
    },
    WarCampaignMapData.{
        WarCampaignMapType.Humans05,
        null,
        "Destroy orcs",
        WarAudioId.CampaignHumansIntro05,
        #string DONE
The Forest of Elwynn is a strategic key to securing the Borderlands.
An outpost near the southeast edge of the forest will serve as your stronghold.
The King has assigned one of his knights to aid you, so that your task of ridding
the area of Blackhand's dark minions may be more readily completed.
        DONE,
        22.0
    },
    WarCampaignMapData.{
        WarCampaignMapType.Orcs05,
        null,
        "Save the outpost\nSlay all humans",
        WarAudioId.CampaignOrcsIntro05,
        #string DONE
On your return from the dungeon, you receive word from advance scouts that the
recently established outpost near the Red Ridge Mountains is under siege.
A group of raiders have been dispatched to assist you in taking back the
outpost and crushing the Human opposition. Your secondary objective is to seek
out and completely destroy their encampment, putting an end to this threat for good.
        DONE,
        22.0
    },
    WarCampaignMapData.{
        WarCampaignMapType.Humans06,
        null,
        "Save the abbey and\ndestroy the traitors",
        WarAudioId.CampaignHumansIntro06,
        #string DONE
The monks of Northshire Abbey are under siege by a band of warriors that have been
convinced by enemy agents to fight against the crown. You will be given a complement
of knights to lead to the Abbey, which is already under attack. Ride hard and fast,
as you must prevent its destruction.  When you have secured the Abbey and beaten back
these treacherous curs, you must then move to destroy the enemy at their source.
        DONE,
        22.0
    },
    WarCampaignMapData.{
        WarCampaignMapType.Orcs06,
        null,
        "Raze sunnyglade\nSave tower",
        WarAudioId.CampaignOrcsIntro06,
        #string DONE
The Humans of Sunnyglade have become fat and lazy with their prosperity.
The town is like a ripe plum waiting to be plucked. You will march upon their
weak Human armies and smash them to pieces. Somewhere in the town is a tower that
you must keep intact so that we may study how their magiks are created. Fail me,
and I will have your head on a pike at the gates of Black Rock Spire.
        DONE,
        22.0
    },
    WarCampaignMapData.{
        WarCampaignMapType.Humans07,
        null,
        "Rescue peasants\nDemolish orcs",
        WarAudioId.CampaignHumansIntro07,
        #string DONE
A raiding party has completely overrun the village of Sunnyglade.
Our scouts report that the survivors have been taken to a hidden Orcish
compound to serve as slaves. You must take a detachment of warriors and
rescue the group of peasants that are imprisoned somewhere in the Orc camp.
Our intelligence confirms that all of the prisoners are together, and that
you must destroy the enclosure to open a path for their escape.
The rebuilding of Sunnyglade is also of the utmost importance,
as you will need their assistance in destroying the Orcish slavers.
        DONE,
        22.0
    },
    WarCampaignMapData.{
        WarCampaignMapType.Orcs07,
        null,
        "Kill Blackhand's troops",
        WarAudioId.CampaignOrcsIntro07,
        #string DONE
The time has come for you to seize control of the Orcish hordes for yourself.
Blackhand has become foolish in the deployment of his personal troops, and has
left an opening that you can now exploit. A key outpost in the Black Morass is
the core of Blackhand's supply lines - not only to his foremost battle groups,
but to his castle at Black Rock Spire, as well. The complete destruction of this
outpost will disrupt his power base long enough for you to secure his overthrow.
        DONE,
        22.0
    },
    WarCampaignMapData.{
        WarCampaignMapType.Humans08,
        null,
        "Slay Medivh and\nall minions",
        WarAudioId.CampaignHumansIntro08,
        #string DONE
A new crisis has arisen that threatens to end the lives of all who would
serve the King. The evil warlock Medivh has begun draining the soul of
the land itself to increase his dark powers. You must take a party into
his tower and destroy him before he summons enough energies to devastate
all who would oppose him. Beware his mastery of the black arts, for
legend speaks of his ability to command the daemons of Hell.
        DONE,
        22.0
    },
    WarCampaignMapData.{
        WarCampaignMapType.Orcs08,
        null,
        "Save garona\nDestroy the abbey",
        WarAudioId.CampaignOrcsIntro08,
        #string DONE
The destruction of Blackhand's outpost has left him in a weak position.
The Shadow Council, sensing your rise in power, orders the assassination
of Blackhand and elevates you to the position of War Chief.
A wolfrider brings you news that our best spy, the half-orc Garona,
has been discovered by the Humans of Northshire Abbey and imprisoned there.
She has valuable information concerning new and powerful magiks that would
aid you in the destruction of your counterpart - King Llane.
Trusting no one to complete this vital mission in time, you must find her,
and then completely destroy the Abbey to protect her secrets.
        DONE,
        22.0
    },
    WarCampaignMapData.{
        WarCampaignMapType.Humans09,
        null,
        "Destroy all traces\nof the orcs",
        WarAudioId.CampaignHumansIntro09,
        #string DONE
The time has come to take the battle into Blackhand's own domain.
King Llane has ordered a full assault upon the Orcs, demanding
that this plague that spreads across the kingdom be eradicated.
To the east of the Borderlands lies the Black Morass where the
Orcish hordes make their encampments. You are to lead an army into
this foul region and destroy every trace of their dark presence.
        DONE,
        22.0
    },
    WarCampaignMapData.{
        WarCampaignMapType.Orcs09,
        null,
        "Crush the two human\noutposts",
        WarAudioId.CampaignOrcsIntro09,
        #string DONE
With your new found magiks, the time is ripe to burn the Human
occupation from our lands. There are two Human outposts to the
south that pose the greatest threat to our security.
Reports from scouts near these towns show that the key to your
success in this confrontation is to hold back the Human forces
at their bridges while you strengthen your attack force.
The glories of combat will be yours as you personally lead the
armies that will reclaim your homelands.
        DONE,
        22.0
    },
    WarCampaignMapData.{
        WarCampaignMapType.Humans10,
        null,
        "Destroy temple raze town\nKill orcs",
        WarAudioId.CampaignHumansIntro10,
        #string DONE
Runners have arrived and informed you of grave news. King Llane
lies dead this day, assassinated by the treacherous Garona, at
Stormwind Keep.  His last command was that you should assume the
mantle of War Leader, and end this battle that has drained the land
of its resources, and now its king. Scouts report that deep within
the Black Morass lies one of Blackhand's darkest seats of power ---
the Temple of the Damned. No peasants dare approach the vile temple,
and only the bravest of your soldiers have agreed to accompany you on
this mission. You must strike boldly and without err, for there will
be no reinforcements.
        DONE,
        22.0
    },
    WarCampaignMapData.{
        WarCampaignMapType.Orcs10,
        null,
        "Destroy the human camp",
        WarAudioId.CampaignOrcsIntro10,
        #string DONE
You have tasted victory, and the craving for more is upon you.
It is clear that one decisive blow to the Humans will make the total
and complete domination of this race a simple matter.
Your spies have gathered intelligence that points to an encampment
near the center of the Human lands where their knights and soldiers
are sent to train. Although they will not be expecting an attack,
they should prove a good fight. The destruction of this site would
greatly weaken their forces, and etch your position as War Chief
in stone. None shall survive!
        DONE,
        22.0
    },
    WarCampaignMapData.{
        WarCampaignMapType.Humans11,
        null,
        "Destroy rockard\nDestroy stonard",
        WarAudioId.CampaignHumansIntro11,
        #string DONE
Here beats the diseased and malevolent heart of Blackhand's plagued lands.
The sister towns of Rockard and Stonard are all that stand between the
forces of the kingdom and Blackhand's stronghold - Black Rock Spire.
After conferring with your warchiefs, the path to victory lays clear.
You must destroy Rockard and Stonard, thereby cutting off all lines of
support and supplies, so that the final offensive can be made upon Black Rock Spire.
        DONE,
        22.0
    },
    WarCampaignMapData.{
        WarCampaignMapType.Orcs11,
        null,
        "Raze moonbrook\nRaze goldshire",
        WarAudioId.CampaignOrcsIntro11,
        #string DONE
The final march to King Llane's home, Stormwind Keep, is at hand.
Only two pathetic settlements stand in the way of the awesome
juggernaut your cruel leadership has created. The Humans have proved
to be amusing opposition, but the hour of doom has come for them.
The complete and utter demolition of the twin cities Goldshire and
Moonbrook will sever the lifeline between the King and his people,
making him a figurehead waiting to be lopped off.
        DONE,
        22.0
    },
    WarCampaignMapData.{
        WarCampaignMapType.Humans12,
        null,
        "Destroy Black Rock Spire\nand all orcs!",
        WarAudioId.CampaignHumansIntro12,
        #string DONE
Black Rock Spire stands before us! The skies above the reeking swamp
fill with the gathering thunderheads that spell doom for the loser in
this final confrontation. Tension hangs like a heavy cloak on your
shoulders as your troops prepare for the battle ahead. Above the din
and chaos that swirls about the battlefield stands the Castle of Blackhand,
its gaze sweeping down upon the battlefield where the destiny of the land
will be decided. Destroy the stronghold and those who would seek to defend it,
and Azeroth will be freed from Blackhand's poisoned grip forever!
        DONE,
        22.0
    },
    WarCampaignMapData.{
        WarCampaignMapType.Orcs12,
        null,
        "Destroy Stormwind Keep\nand all humans!",
        WarAudioId.CampaignOrcsIntro12,
        #string DONE
Stormwind Keep is ours to take! The Orcish hordes gather like buzzards to
carrion, as the moment of destiny is close at hand. A low growl fills the
air as your wolfriders whip their savage mounts into a frenzy. The earth
shakes as catapults are loaded and moved into position. The fires of the
burning rubble about you dance in your eyes as you gaze upon the pristine,
white towers of Castle Stormwind. White that will soon be washed with the
red of King Llane's blood.  With his fall, all of Azeroth will be yours!
        DONE,
        22.0
    },
    WarCampaignMapData.{
        WarCampaignMapType.Custom,
        checkCustomMapObjectives,
        "Destroy enemy",
        0,
        "",
        0.0
    }
];
