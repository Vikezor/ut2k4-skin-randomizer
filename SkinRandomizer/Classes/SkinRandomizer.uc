class SkinRandomizer extends Mutator;

var array<xUtil.PlayerRecord> SkinList;


function PostBeginPlay()
{
    local int i;

    Super.PostBeginPlay();
    Log("=== Skin Logger Started ===");

    // Get all player records
    class'xUtil'.static.GetPlayerList(SkinList);
	 Log("Found $ SkinList.Length skins");
    for (i = 0; i < SkinList.Length; i++)
    {
        Log("---------------------------------");
        Log("Character Name: " $ SkinList[i].DefaultName);
        Log("Mesh: " $ SkinList[i].MeshName);
        Log("Body Skin: " $ SkinList[i].BodySkinName);
        Log("Face Skin: " $ SkinList[i].FaceSkinName);
        Log("Portrait: " $ SkinList[i].Portrait);
        Log("Species: " $ SkinList[i].Species);
    }

    Log("=== Skin Logger Finished ===");
}

function ModifyPlayer(Pawn Other)
{
	local int randomIndex;
    local xPawn XP;
	
    Super.ModifyPlayer(Other);

    XP = xPawn(Other);
    if (XP == None)
        return;

    if (SkinList.Length == 0)
        return;

    // Pick random skin
    randomIndex = Rand(SkinList.Length);
	Log("Randomizing character to: " $ SkinList[randomIndex].DefaultName);

    ApplySkin(XP, SkinList[randomIndex]);
}

function ApplySkin(xPawn P, xUtil.PlayerRecord Rec)
{
    if (P == None)
        return;

	P.PlayerReplicationInfo.CharacterName = Rec.DefaultName;
}

defaultproperties
{
    FriendlyName="Skin Randomizer Mutator"
    Description="Randomizes player skin when player is spawned"
}
