import XMonad
import XMonad.Config.Gnome

main = xmonad $ gnomeConfig
        { 
        terminal = "gnome-terminal"
        , modMask = mod4Mask -- set the mod key to the windows key
        }
