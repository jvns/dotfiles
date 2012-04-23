import XMonad
import XMonad.Config.Desktop
import XMonad.Util.Run(spawnPipe)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.UrgencyHook
import XMonad.Util.Scratchpad
import System.Exit
import XMonad.Actions.CycleRecentWS
import XMonad.Actions.CycleWS
import System.IO
 
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
 
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "xterm"
 
-- Width of the window border in pixels.
--
myBorderWidth   = 1
 
-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask
 
-- The mask for the numlock key. Numlock status is "masked" from the
-- current modifier status, so the keybindings will work with numlock on or
-- off. You may need to change this on some systems.
--
-- You can find the numlock modifier by running "xmodmap" and looking for a
-- modifier with Num_Lock bound to it:
--
-- > $ xmodmap | grep Num
-- > mod2        Num_Lock (0x4d)
--
-- Set numlockMask = 0 if you don't have a numlock key, or want to treat
-- numlock status separately.
--
myNumlockMask   = mod2Mask
 
-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
--
-- myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]
myWorkspaces = ["web"] ++ map show [2..7] ++ ["IM"]
 
-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"
 
-- Default offset of drawable screen boundaries from each physical
-- screen. Anything non-zero here will leave a gap of that many pixels
-- on the given edge, on the that screen. A useful gap at top of screen
-- for a menu bar (e.g. 15)
--
-- An example, to set a top gap on monitor 1, and a gap on the bottom of
-- monitor 2, you'd use a list of geometries like so:
--
-- > defaultGaps = [(18,0,0,0),(0,18,0,0)] -- 2 gaps on 2 monitors
--
-- Fields are: top, bottom, left, right.
--
myDefaultGaps   = [(18,0,0,0)]
 
------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
 
    -- launch a terminal
    [ ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
 
    -- launch dmenu
    , ((modMask,               xK_p     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
--    , ((modMask,               xK_u     ), spawn "exe=`echo | dmenu` && eval \"echo $exe >> /home/bork/blah.txt\"")
    , ((modMask,               xK_o     ), spawn "exe=`mpcl playlist | dmenu -i | cut -d ' ' -f 2 | cut -d ')' -f 1` && exec mpcl play $exe | head -n 1")
--    , ((modMask,               xK_l     ), spawn "/home/bork/bin/likesong")
    , ((modMask,               xK_i     ), spawn "locate /home/bork/work | grep -v '/\\.' > ~/scratch/dmenu && file=`dmenu -i <~/scratch/dmenu ` && `gnome-open $file` ")
    , ((modMask,               xK_s     ), spawn "schedule > /dev/null")
    , ((modMask,               xK_y     ), spawn "mpdlyrics")
    , ((modMask,               xK_n     ), cycleRecentWS [xK_Alt_L] xK_n xK_n)
    , ((modMask,               xK_Left  ), prevWS )
    , ((modMask,               xK_Right ), nextWS )
    , ((modMask .|. shiftMask, xK_Left  ), shiftToPrev )
    , ((modMask .|. shiftMask, xK_Right ), shiftToNext )

    -- change background
    , ((modMask,               xK_m     ), spawn "chbg")
    -- launch gmrun
    , ((modMask .|. shiftMask, xK_p     ), spawn "gmrun")

    , ((modMask , xK_c     ), kill)
    , ((modMask,               xK_Tab ), scratchpadSpawnActionTerminal myTerminal)
    
	-- multimedia keys
    , ((0, 0x1008ff16), 						   spawn "mpc prev | head -n 1")
--    , ((modMask, 0x1008ff27), 						   spawn "mpcl next; sleep 1;   mpcl play ")
    , ((0, 0x1008ff26), 						   spawn "mpc prev | head -n 1")
    , ((0, 0x1008ff17), 						   spawn "mpc next | head -n 1")
--    , ((0, 0x1008ff27), 						   spawn "quodlibet --next")
--    , ((modMask, 0x1008ff27), 						   spawn "mpcl next; sleep 1;   mpcl play ")
--    , ((0, 0x1008ff26), 						   spawn "mpcl prev | head -n 1")
--    , ((0, 0x1008ff26), 						   spawn "quodlibet --previous")
--    , ((0, 0x1008ff15), 						   spawn "mpcl toggle; mpcl toggle")
--    -- XF86AudioPlay 
    , ((0, 0x1008ff14),                            spawn "mpc toggle")        
    , ((0, 0x1008ff16),                            spawn "mpc toggle")        
    , ((0, 0x1008ff18),                            spawn "pkill firefox;firefox")        
    , ((0, 0x1008ff19),                            spawn "firefox http://gmail.com")
    , ((modMask, xK_Down),                            spawn "mpcl toggle")        
--    , ((modMask, xK_Down),                            spawn "quodlibet --play-pause")        
    -- suspend computer
--    , ((0, 0x1008ff2f ), 				       spawn "dbus-send --session --dest=org.freedesktop.PowerManagement --type=method_call --print-reply --reply-timeout=2000 /org/freedesktop/PowerManagement org.freedesktop.PowerManagement.Suspend")
    -- volume up/down
    , ((0, 0x1008ff11 ), 				       spawn "aumix -v -3 > /dev/null")
    , ((modMask .|. shiftMask, xK_Down ), 				       spawn "aumix -v -3 > /dev/null")
    , ((modMask .|. shiftMask, xK_Up ), 				       spawn "aumix -v +3 > /dev/null")
    , ((modMask .|. shiftMask, xK_Left ), 				       spawn "mpc prev")
    , ((modMask .|. shiftMask, xK_Right ), 				       spawn "mpc next")
    , ((modMask, xK_F4), 					   spawn "sudo pm-suspend")
 
    -- close focused window 
    , ((modMask .|. shiftMask, xK_c     ), kill)
    , ((modMask , xK_c     ), kill)
 
     -- Rotate through the available layout algorithms
    , ((modMask,               xK_space ), sendMessage NextLayout)
 
    --  Reset the layouts on the current workspace to default
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
 
    -- Resize viewed windows to the correct size
--    , ((modMask,               xK_n     ), refresh)
 
    -- Move focus to the next window
--    , ((modMask,               xK_Tab   ), windows W.focusDown)
 
    -- Move focus to the next window
    , ((modMask,               xK_j     ), windows W.focusDown)
 
    -- Move focus to the previous window
    , ((modMask,               xK_k     ), windows W.focusUp  )
 
 
    -- Swap the focused window and the master window
    , ((modMask,               xK_Return), windows W.swapMaster)

	-- focus most recently urgent window
	, ((modMask              , xK_BackSpace), focusUrgent) 
      -- Swap the focused window with the next window
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  )
 
    -- Swap the focused window with the previous window
    , ((modMask .|. shiftMask, xK_m     ),  setWMName "LG3D"    )
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modMask,               xK_h     ), sendMessage Shrink)
 
    -- Expand the master area
    , ((modMask,               xK_l     ), sendMessage Expand)
 
    -- Push window back into tiling
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink)
 
    -- Increment the number of windows in the master area
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1))
 
    -- Deincrement the number of windows in the master area
    , ((modMask              , xK_period), sendMessage (IncMasterN (-1)))
 
    -- toggle the status bar gap
    --    , ((modMask              , xK_b     ),
    --
    --modifyGap (\i n -> let x = (XMonad.defaultGaps conf ++ repeat (0,0,0,0)) !! i
    --                             in if n == x then (0,0,0,0) else x))
     
    -- Quit xmonad
    , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
 
    -- Restart xmonad
    , ((modMask              , xK_q     ),
          broadcastMessage ReleaseResources >> restart "xmonad" True)
    ]
    ++
 
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
 
 
 
------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
 
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w))
 
    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2), (\w -> focus w >> windows W.swapMaster))
 
    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3), (\w -> focus w >> mouseResizeWindow w))
 
--    , ((modMask, button4), const prevWS)
--    , ((modMask, button5), const nextWS)
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]
 
------------------------------------------------------------------------
-- Layouts:
 
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = tiled ||| Mirror tiled ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio
 
     -- The default number of windows in the master pane
     nmaster = 1
 
     -- Default proportion of screen occupied by master pane
     ratio   = 1/2
 
     -- Percent of screen to increment by when resizing panes
     delta   = 3/100
 
------------------------------------------------------------------------
-- Window rules:
 
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"           --> doFloat
    , className =? "Gimp"              --> doFloat
    , className =? "sun-awt-X11-XFramePeer"           --> doFloat
    , className =? "Deskbar-applet"     --> doFloat 
    , resource  =? "desktop_window"    --> doIgnore
    , resource  =? "sonata"          --> doF (W.shift "2") 
    , className  =? "pidgin"          --> doF (W.shift "8") 
    , resource =? "firefox-bin"  --> doF (W.shift "web")
    , resource  =? "kdesktop"          --> doIgnore 
    , stringProperty "WM_WINDOW_ROLE" =? "opera-widget"     --> doFloat 
    , stringProperty "WM_NAME" =? "Hello World Window"     --> doFloat 
    ] <+> scratchpadManageHook (W.RationalRect 0.125 0.25 0.75 0.50 )
 
-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
 
------------------------------------------------------------------------
-- Status bars and logging
 
-- Perform an arbitrary action on each internal state change or X event.
-- See the 'DynamicLog' extension for examples.
--
-- To emulate dwm's status bar
--
-- > logHook = dynamicLogDzen
-- shorten :: String -> String
-- shorten str = ""
myPP :: PP
myPP = defaultPP 	
			{ ppTitle = (\x -> "")
			, ppUrgent   = dzenColor "red" "yellow"
			}
myLogHook = dynamicLogWithPP myPP
 
------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.
 
-- Run xmonad with the settings you specify. No need to modify this.
--

 
-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will 
-- use the defaults defined in xmonad/XMonad/Config.hs
-- 
-- No need to modify this.
--
main = do 
--    xmproc <- spawnPipe "/usr/bin/xmobar /home/bork/.xmonad/xmobar"
    xmonad $ desktopConfig {
           -- simple stuff
             terminal           = myTerminal,
             focusFollowsMouse  = myFocusFollowsMouse,
             borderWidth        = myBorderWidth,
             numlockMask        = myNumlockMask,
             modMask            = myModMask,
             workspaces         = myWorkspaces,
             normalBorderColor  = myNormalBorderColor,
             focusedBorderColor = myFocusedBorderColor,
           -- key bindings
             keys               = myKeys,
             mouseBindings      = myMouseBindings,
           -- hooks, layouts
     --        manageHook         = myManageHook,
     		 manageHook = manageDocks <+> myManageHook,
--             logHook = dynamicLogWithPP $ xmobarPP {
--                         ppOutput = hPutStrLn xmproc
--                       , ppTitle = xmobarColor "green" "" . shorten 50
--                       },

             -- layoutHook = ewmhDesktopsLayout $ avoidStruts $ layoutHook defaultConfig,
                 logHook    = ewmhDesktopsLogHook >> setWMName "LG3D",
             startupHook = setWMName "LG3D"
        }
