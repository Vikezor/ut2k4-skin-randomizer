# UT 2004 Skin Randomizer

Lists all player skins when joining and randomly selects one of them when player is spawned.  
*NOTE:* Only tested locally, and made for LAN use where available skins are known

## How to use
 1. Copy `SkinRandomizer` under UT2004
 2. Edit `UT2004.ini` and add `EditPackages=SkinRandomizer` under `[Editor.EditorEngine]`
 3. In terminal, navigate to `UT2004/System` and run `ucc make`
 4. Run UT2004 and select `Skin Randomizer Mutator` from the mutator list, the server needs to be run as dedicated for the changes to be visible for others,
    in listen mode only the host's skin will change

*NOTE:* If you change the mutator, delete all files related to `SkinRandomizer` before running make, otherwise it will not apply the changes
