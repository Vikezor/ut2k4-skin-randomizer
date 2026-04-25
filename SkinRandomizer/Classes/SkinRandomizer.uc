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

    // Set mesh, skip for now, caused crashes when testing, vibecoding ho :D
    //P.LinkMesh(Mesh(DynamicLoadObject(Rec.MeshName, class'Mesh')));

    // Apply body + face skins
    if (Rec.BodySkinName != "")
        P.Skins[0] = Material(DynamicLoadObject(Rec.BodySkinName, class'Material'));

    if (Rec.FaceSkinName != "")
        P.Skins[1] = Material(DynamicLoadObject(Rec.FaceSkinName, class'Material'));

    // Optional: update species (affects movement, sounds, etc.)
    //if (Rec.Species != "")
    //    P.Species = class<xPawnSpecies>(DynamicLoadObject(Rec.Species, class'Class'));

    // Force update
    // P.SetupPlayerRecord();
}

defaultproperties
{
    FriendlyName="Skin Randomizer Mutator"
    Description="Randomizes player skin when player is spawned"
}