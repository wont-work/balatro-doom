## installation

- install [steamodded](https://github.com/Steamodded/smods/wiki)
- place files in `%APPDATA%/balatro/mods/doom`
- download doom.dll from https://github.com/wont-work/doomgeneric/tree/lua and place it next to `main.lua`
- download [`doom1.wad`](https://www.doomworld.com/classicdoom/info/shareware.php) and place it next to `doom.dll`
- back up and replace the `lua51.dll` in the balatro game folder with the one from `PUT_IN_BALATRO_FILES` 
    - because i have no idea how C toolchains work and this one i downloaded just to debug a crash actually fixes said crash
    - this updates your luajit version which may break other mods or parts of the game i have not yet tested
    - for transparency's sake, the file is the one from the `love-windows-x64` artifact of run https://github.com/love2d/love/actions/runs/12726794131/
