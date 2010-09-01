import Control.Monad (liftM2)
import Data.Monoid
import Graphics.X11
import qualified Data.Map as M
import qualified XMonad.Actions.FlexibleResize as Flex
import qualified XMonad.StackSet as W
import System.Exit
import System.IO
import XMonad.Actions.CycleWS
import XMonad.Actions.FloatKeys
import XMonad.Actions.GridSelect
import XMonad hiding (Tall)
import XMonad.Hooks.DynamicHooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.Grid
import XMonad.Layout.LayoutCombinators hiding ((|||))
import XMonad.Layout.LayoutHints
import XMonad.Layout.NoBorders   ( noBorders, smartBorders )
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.ManageHook
import XMonad.Prompt
import XMonad.Prompt
import XMonad.Prompt.Man
import XMonad.Prompt.Shell
import XMonad.Prompt.Shell
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.WorkspaceCompare


myManageHook :: ManageHook
myManageHook = composeAll 
    [ className =? "Gimp" --> doFloat
    , className =? "gajim.py"  --> doFloat
    , className =? "psi"  --> doFloat
    , className =? "zim"  --> doFloat
    , className =? "gpicview"  --> doFloat
    ]
myLogHook :: X ()
myLogHook = fadeInactiveLogHook fadeAmount
    where fadeAmount = 0.8

myPromptConfig = defaultXPConfig
	{ position           = Top
        , height             = 16 
	, promptBorderWidth  = 0
	}

myLayoutHook = smartBorders $ avoidStruts  $ layoutHook defaultConfig ||| tabbed shrinkText defaultTheme ||| Grid

myTerminal = "xterm -C -fg white -bg black +sb"
myWorkspaces = ["irc", "web", "term", "root", "mail", "pdf"] ++ map show [7 .. 9 :: Int]


myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((mod4Mask, button1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster))
    , ((mod4Mask, button2), (\w -> focus w >> windows W.shiftMaster))
    , ((mod4Mask, button3), (\w -> focus w >> Flex.mouseResizeWindow w))
    , ((mod4Mask, button4), (\_ -> prevWS))
    , ((mod4Mask, button5), (\_ -> nextWS))
    ]


-----------------------------------------


main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig
     { manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig }
     { terminal    = myTerminal
     , modMask     = mod4Mask
     , borderWidth = 1 
     , normalBorderColor = "#1C1C1C"
     , focusedBorderColor = "#FEA63C" 
     , mouseBindings = myMouseBindings
     , workspaces  = myWorkspaces
     , manageHook = myManageHook <+> manageDocks <+> manageHook defaultConfig
     , layoutHook = myLayoutHook
     , logHook = (dynamicLogWithPP $ xmobarPP { ppOutput = hPutStrLn xmproc, ppTitle = xmobarColor "green" "" . shorten 70}) >> (myLogHook)
     }`additionalKeys`
     [ ((mod4Mask .|. shiftMask, xK_z), spawn "slock")
     , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
     , ((0, xK_Print), spawn "scrot '%Y-%m-%d-%H%M%S.png' -e 'mv $f ~/bilder/Screenshots/'")
--     , ((mod4Mask .|. controlMask, xK_End), spawn "mpc stop")
     , ((mod4Mask, xK_m), spawn "mpc toggle")
     , ((mod4Mask, xK_b), spawn "mpc prev")
     , ((mod4Mask, xK_n), spawn "mpc next")
     , ((mod4Mask, xK_i), nextWS)
     , ((mod4Mask, xK_u), prevWS)
     , ((mod4Mask .|. shiftMask, xK_i), shiftToNext >> nextWS)
     , ((mod4Mask .|. shiftMask, xK_u), shiftToPrev >> prevWS)
     , ((mod4Mask, xK_g), goToSelected defaultGSConfig)
--     , ((mod4Mask, xK_y), scratchpadSpawnActionTerminal "xterm")
     , ((mod4Mask, xK_x), shellPrompt myPromptConfig)
--     , ((mod4Mask, xK_p), shellPrompt myPromptConfig)
     , ((mod4Mask, xK_s), spawnSelected defaultGSConfig [myTerminal,"firefox&","skype&","twinkle&","psi&","sylpheed&","ossxmix&","xcompmgr&","trayer2&","wesnoth&"])
     , ((mod4Mask, xK_p), spawn "/bin/sh ~/upstart.sh")
     ]
