import qualified Data.Map as M
import Data.Monoid
import System.Exit
import System.IO
import XMonad
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Layout.MultiColumns
import XMonad.Layout.NoBorders
import XMonad.Layout.PerScreen
import XMonad.Layout.Spacing
import qualified XMonad.StackSet as S
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

myBorderWidth = 2
myClickJustFocuses = False
myFocusFollowsMouse = True
myFocusedBorderColor = "#c78f23"
myModMask = mod4Mask
myNormalBorderColor = "#5f676a"
myTerminal = "kitty"
myWorkspaces = ["1", "2", "3", "4"]

mySpacing = spacingRaw False (Border 6 6 6 6) True (Border 6 6 6 6) True
myLayoutHook = smartBorders $ avoidStruts $ ifWider 1440 horizontal vertical where
    horizontal = mySpacing $ Tall 1 (3 / 100) (1 / 2)
    vertical = mySpacing $ Mirror $ multiCol [1] 1 0.01 (-0.5)

myStartupHook = do
    spawn "pkill polybar && polybar &"
    -- spawn "~/.config/polybar/launch.sh"

myManageHook = composeAll [
        className =? "desktop_window" --> doIgnore,
        className =? "Gimp" --> doFloat,
        className =? "kdesktop" --> doIgnore,
        className =? "MPlayer" --> doFloat,
        title =? "Friends List" --> doFloat
    ]

myKeyBindings conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $ [
        ((modMask, xK_Return), spawn $ XMonad.terminal conf),
        ((modMask, xK_p), spawn "rofi -disable-history -show drun"),
        ((modMask .|. shiftMask, xK_c), kill),
        ((modMask, xK_space), sendMessage NextLayout),
        ((modMask .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf),
        ((modMask, xK_n), refresh),
        ((modMask, xK_Tab), windows S.focusDown),
        ((modMask, xK_j), windows S.focusDown),
        ((modMask, xK_k), windows S.focusUp),
        ((modMask, xK_m), windows S.focusMaster),
        ((modMask .|. shiftMask, xK_j), windows S.swapDown),
        ((modMask .|. shiftMask, xK_k), windows S.swapUp),
        ((modMask, xK_h), sendMessage Shrink),
        ((modMask, xK_l), sendMessage Expand),
        ((modMask, xK_t), withFocused $ windows . S.sink),
        ((modMask, xK_comma), sendMessage (IncMasterN 1)),
        ((modMask, xK_period), sendMessage (IncMasterN (-1))),
        ((modMask .|. shiftMask, xK_q), io (exitWith ExitSuccess)),
        ((modMask, xK_q), spawn "xmonad --recompile; xmonad --restart")
    ] ++ [
        ((m .|. modMask, k), windows $ f i) | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9], (f, m) <- [(S.greedyView, 0), (S.shift, shiftMask)]
    ] ++ [
        ((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f)) | (key, sc) <- zip [xK_w, xK_e, xK_r] [1, 0], (f, m) <- [(S.view, 0), (S.shift, shiftMask)]
    ]

myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $ [
        ((modMask, button1), (\w -> focus w >> mouseMoveWindow w >> windows S.shiftMaster)),
        ((modMask, button2), (\w -> focus w >> windows S.shiftMaster)),
        ((modMask, button3), (\w -> focus w >> mouseResizeWindow w >> windows S.shiftMaster))
    ]

main = xmonad $ ewmhFullscreen $ ewmh $ docks $ def {
    borderWidth = myBorderWidth,
    clickJustFocuses = myClickJustFocuses,
    focusFollowsMouse = myFocusFollowsMouse,
    focusedBorderColor = myFocusedBorderColor,
    keys = myKeyBindings,
    layoutHook = myLayoutHook,
    manageHook = myManageHook,
    modMask = myModMask,
    normalBorderColor = myNormalBorderColor,
    mouseBindings = myMouseBindings,
    startupHook = myStartupHook,
    terminal = myTerminal,
    workspaces = myWorkspaces
}

