import Data.Monoid
import System.Exit
import System.IO
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Layout.MultiColumns
import XMonad.Layout.PerScreen
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

import qualified XMonad.StackSet
import qualified Data.Map

main = do
    let modMask = mod4Mask
    let hLayout = Tall 1 (3/100) (1/2)
    let vLayout = Mirror $ multiCol [1] 1 0.01 (-0.5)
    xmonad $ ewmh $ docks $ def {
        borderWidth = 2,
        clickJustFocuses = False,
        focusFollowsMouse = True,
        focusedBorderColor = "#98c379",
        handleEventHook = fullscreenEventHook,
        keys = \conf -> Data.Map.fromList $ [
            ((modMask, xK_Return), spawn $ XMonad.terminal conf),
            ((modMask, xK_p), spawn "rofi -disable-history -show run"),
            ((modMask .|. shiftMask, xK_c), kill),
            ((modMask, xK_space), sendMessage NextLayout),
            ((modMask .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf),
            ((modMask, xK_n), refresh),
            ((modMask, xK_Tab), windows XMonad.StackSet.focusDown),
            ((modMask, xK_j), windows XMonad.StackSet.focusDown),
            ((modMask, xK_k), windows XMonad.StackSet.focusUp),
            ((modMask, xK_m), windows XMonad.StackSet.focusMaster),
            ((modMask .|. shiftMask, xK_j), windows XMonad.StackSet.swapDown),
            ((modMask .|. shiftMask, xK_k), windows XMonad.StackSet.swapUp),
            ((modMask, xK_h), sendMessage Shrink),
            ((modMask, xK_l), sendMessage Expand),
            ((modMask, xK_t), withFocused $ windows . XMonad.StackSet.sink),
            ((modMask, xK_comma), sendMessage (IncMasterN 1)),
            ((modMask, xK_period), sendMessage (IncMasterN (-1))),
            ((modMask .|. shiftMask, xK_q), io (exitWith ExitSuccess)),
            ((modMask, xK_q), spawn "xmonad --recompile; xmonad --restart")
        ] ++ [
            ((m .|. mod4Mask, k), windows $ f i) | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9],
            (f, m) <- [(XMonad.StackSet.greedyView, 0), (XMonad.StackSet.shift, shiftMask)]
        ] ++ [
            ((m .|. mod4Mask, key), screenWorkspace sc >>= flip whenJust (windows . f)) | (key, sc) <- zip [xK_w, xK_e, xK_r] [1, 0],
            (f, m) <- [(XMonad.StackSet.view, 0), (XMonad.StackSet.shift, shiftMask)]
        ],
        layoutHook = avoidStruts $ ifWider 1280 hLayout vLayout,
        logHook = return (),
        manageHook = composeAll [
            className =? "MPlayer" --> doFloat,
            className =? "Gimp" --> doFloat,
            className =? "desktop_window" --> doIgnore,
            className =? "kdesktop" --> doIgnore
        ],
        modMask = mod4Mask,
        normalBorderColor = "#111111",
        mouseBindings = \conf -> Data.Map.fromList $ [
            ((modMask, button1), (\w -> focus w >> mouseMoveWindow w >> windows XMonad.StackSet.shiftMaster)),
            ((modMask, button2), (\w -> focus w >> windows XMonad.StackSet.shiftMaster)),
            ((modMask, button3), (\w -> focus w >> mouseResizeWindow w >> windows XMonad.StackSet.shiftMaster))
        ],
        startupHook = return (),
        terminal = "kitty",
        workspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"] 
    }

