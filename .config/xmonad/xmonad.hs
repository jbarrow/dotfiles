import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.EwmhDesktops

import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.Ungrab

import XMonad.Layout.Magnifier
import XMonad.Layout.LayoutModifier
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Spacing


-- User-defined variables
myWindowGap = 10                                :: Integer
myFocusFollowsMouse = True                      :: Bool
myBorderWidth = 2                               :: Dimension
myFocusedBorderColor = "#ffffff"                :: String
myUnfocusedBorderColor = "#555555"              :: String
myTerminal = "gnome-terminal"                   :: String
myBrowser = "firefox"                           :: String
myFont = "xft:Hack Nerd Font:regular:size=12:antialias=True:hinting=true"   :: String

-- Set the space between tiling windows
mySpacing :: Integer -> l a -> ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border 0 i 0 i) True (Border i 0 i 0) True



main :: IO ()
main = xmonad
     . ewmhFullscreen
     . ewmh
     . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
     $ myConfig

myConfig = def
    { modMask       = mod4Mask      -- Rebind Mod to the Super key
    , layoutHook    = myLayout      -- Use custom layouts
    , manageHook    = myManageHook  -- Match on certain windows
    , terminal      = myTerminal
    , borderWidth   = myBorderWidth
    , focusedBorderColor    = myFocusedBorderColor
    , normalBorderColor  = myUnfocusedBorderColor
    }
  `additionalKeysP`
    [ ("M-S-z", spawn "xscreensaver-command -lock")
    , ("M-S-=", unGrab *> spawn "scrot -s"        )
    , ("M-]"  , spawn "firefox"                   )
    , ("M-p"  , spawn "rofi -combi-modi window,drun,ssh -theme solarized -font \"hack 10\" -show combi" )
    , ("<XF86AudioLowerVolume>", spawn "amixer -q sset Master 2%-")
    , ("<XF86AudioRaiseVolume>", spawn "amixer -q sset Master 2%+")
    , ("<XF86AudioMute>", spawn "amixer -q sset Master toggle")
    ]

myManageHook :: ManageHook
myManageHook = composeAll
    [ className =? "Gimp" --> doFloat
    , isDialog            --> doFloat
    ]

myLayout = tiled ||| Mirror tiled ||| Full ||| threeCol
  where
    threeCol = magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
    tiled    = mySpacing myWindowGap $ Tall nmaster delta ratio
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes

myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = magenta " • "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2
    , ppHidden          = white . wrap " " ""
    , ppHiddenNoWindows = lowWhite . wrap " " ""
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = wrap (white    "[") (white    "]") . magenta . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue    . ppWindow

    -- | Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta  = xmobarColor "#ff79c6" ""
    blue     = xmobarColor "#bd93f9" ""
    white    = xmobarColor "#f8f8f2" ""
    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""

