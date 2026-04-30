class SkinRandomizer extends Mutator;

var array<xUtil.PlayerRecord> SkinList;
var array<string> VanillaCharacters;


function PostBeginPlay()
{
    local int i;
	local int vanilla;

    Super.PostBeginPlay();
    Log("=== Skin Logger Started ===");

    // Get all player records
    class'xUtil'.static.GetPlayerList(SkinList);
	 Log("Found $ SkinList.Length skins");
    for (i = 0; i < SkinList.Length; i++)
    {
		vanilla = IsVanillaCharacter(SkinList[i].DefaultName);
		if (vanilla != -1)
		{
			Log("** REMOVE **: " $ SkinList[i].DefaultName);
			
			SkinList.Remove(i, 1);
			VanillaCharacters.Remove(vanilla, 1);
			i--;
		}
		else
		{
			Log("KEEP: " $ SkinList[i].DefaultName);
		}
    }

    Log("=== Skin Logger Finished ===");
}

function int IsVanillaCharacter(string Name)
{
	local int i;
	for (i = 0; i < VanillaCharacters.Length; i++)
	{
		if (VanillaCharacters[i] == Name)
			return i;
	}
	return -1;
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
	  VanillaCharacters = ("Brock","Lauren","Prism","Remus","BlackJack","Wraith","Romulus","Satin","Sapphire","Torch","Gorge","Ambrosia","Frostbite","Reinha","Arclite","Cannonball","Rylisa","Siren","Mandible","Thorax","Syzygy","Widowmaker","Cobalt","Rapier","Corrosion","Renegade","Mr.Crow","Harlequin","Fate","Lilith","Brutalis","Ravage","Domina","Subversa","Cleopatra","Horus","Memphis","Roc","Diva","Hyena","Asp","Scarab","Makreth","Damarus","Mokara","Komek","Faraleth","Motig","Nebri","Selig","Malcolm","Tamika","Othello","Riker","Annika","Azure","Aryss","Picard","Jakob","Taye","ClanLord","Drekorig","Dominator","Guardian","Gaargod","Gkublok","Skakruk","Kraagesh","Zarina","Rae","Garrett","Kaela","Greith","Outlaw","Kane","Baird","Ophelia","Xan","Enigma","Divisor","Virus","Matrix","Cathode","Cyclops","Axon","Abaddon","Barktooth","Karag","Kragoth","Thannis","Mekkor","Skrilax","Ariel","Faith","Mystique","Despair","Huntress","Stargazer","Janus","Nemesis","Tiberius","Kain","Rust","Xargon","Cinder","Nova","Perish","Charisma","Silhouette","Dragon","Gaul","Gryphon","Cipher","Phantom","Xantares","Avalanche","Odin","Rampage","Fury","Jezebel","Matriarch","Bulldog","Bullseye","Earthquake","Brutus","Jackhammer","Perdition","Lockdown","Obsidian","Outrage","Medusa","Molotov","Titania","Hydra","Misery","Sorrow","Chaos","Clangor","Vengeance","Delara","SeeSeela","Caskuli","Rathik","Gramatik","Pelosin","Napaket","Timrit","Cyclone","Torque","Shard","Seeker","Vector","Katana","Predator","Incisor","Bastet","Lexa","Nafiret","Anat","Nekhbet","Nephthys","Isis","Maat","Sphinx","Imhotep","Jackyl","Khepry","Luxor","Osiris","Seth","Hathor","Sayiid","Tefenet","Arachne","Ramses","Tranquility","Natron","Sekhmet","Sunspear","Mortis","Darkling","Jigsaw","Avarice","Circe","Septis","Samedi","Succubus")
}
