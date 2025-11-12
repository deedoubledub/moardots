from libqtile.config import Key, Screen, Group, ScratchPad, DropDown, Drag, Click, Match
from libqtile.lazy import lazy
from libqtile.log_utils import logger
from libqtile import layout, bar, widget, hook, qtile
from typing import List
import os
import subprocess
import psutil
import asyncio

mod = 'mod1'
super = 'mod4'
terminal = 'alacritty'
browser = 'firefox'
fm = 'nautilus'
music = 'ytmdesktop --no-sandbox'
home = os.path.expanduser('~')

# theme palette
palette = [
    '#2E3440', '#3B4252', '#434C5E', '#4C566A',
    '#D8DEE9', '#E5E9F0', '#ECEFF4',
    '#8FBCBB', '#88C0D0', '#81A1C1', '#5E81AC',
    '#BF616A', '#D08770', '#EBCB8B', '#A3BE8C', '#B48EAD',
]

# keybinds
keys = [
    # change window focus
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "l", lazy.layout.right()),

    # move focused window
    Key([mod, "shift"], "h", lazy.layout.swap_left()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "l", lazy.layout.swap_right()),

    # resize layout ratio
    Key([mod, "control"], "j", lazy.layout.grow()),
    Key([mod, "control"], "k", lazy.layout.shrink()),

    # flip layout
    Key([mod], "backslash", lazy.layout.flip()),

    # toggle window fullscreen
    Key([mod], "f", lazy.window.toggle_fullscreen()),

    # toggle window floating
    Key([mod, "shift"], "space", lazy.window.toggle_floating()),

    # close window
    Key([mod, "shift"], "q", lazy.window.kill()),

    # cycle through layouts
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod, "shift"], "Tab", lazy.prev_layout()),

    # lockscreen
    Key([super], "l", lazy.spawn([os.path.expanduser('~/.local/bin/lock.sh')])),

    # reload qtile config
    Key([mod, "shift"], "r", lazy.reload_config()),

    # quit qtile
    Key([mod, "shift"], "Escape", lazy.shutdown()),

    # powermenu
    Key([mod], "Escape", lazy.spawn([os.path.expanduser('~/.local/bin/powermenu.sh')])),

    # open terminal
    Key([mod], "Return", lazy.spawn(terminal)),

    # rofi launcher
    Key([mod], "d", lazy.spawn('rofi -show drun')),

    # web browser
    Key([mod], "i", lazy.spawn(browser)),

    # file manager
    Key([mod], "o", lazy.spawn(fm)),

    # music player
    Key([mod], "p", lazy.spawn(music)),

    # flameshot
    Key([mod], "Print", lazy.spawn('flameshot gui')),

    # dunst
    Key(["control"], "space", lazy.spawn('dunstctl close')),
    Key(["control", "shift"], "space", lazy.spawn('dunstctl close-all')),
    Key(["control"], "grave", lazy.spawn('dunstctl history-pop')),
    Key(["control", "shift"], "grave", lazy.spawn('dunstctl set-paused toggle')),

    # media keys
    Key([], "XF86AudioLowerVolume", lazy.spawn('wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-')),
    Key([], "XF86AudioRaiseVolume", lazy.spawn('wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+')),
    Key([], "XF86AudioMute", lazy.spawn('wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle')),
    Key([], "XF86AudioPlay", lazy.spawn('playerctl play-pause')),
    Key([], "XF86AudioStop", lazy.spawn('playerctl stop')),
    Key([], "XF86AudioNext", lazy.spawn('playerctl next')),
    Key([], "XF86AudioPrev", lazy.spawn('playerctl previous')),
    # alternate media keys
    Key([mod], "F9", lazy.spawn('wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-')),
    Key([mod], "F10", lazy.spawn('wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+')),
    Key([mod], "F11", lazy.spawn('wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle')),
    Key([mod], "F12", lazy.spawn('playerctl play-pause')),

    # laptop screen brightness
    Key([], "XF86MonBrightnessUp", lazy.spawn('light -A 10')),
    Key([], "XF86MonBrightnessDown", lazy.spawn('light -U 10')),
]

# layouts
layout_theme = {
    "margin": 5,
    "border_width": 2,
    "border_focus": "EBCB8B",
    "border_normal": "4C566A",
}

layouts = [
    layout.MonadTall(ratio=0.65, **layout_theme),
    layout.MonadWide(**layout_theme),
    layout.Matrix(**layout_theme),
    layout.Max(),
]

# widget default config
widget_defaults = dict(
    font='RobotoMono Nerd Font',
    fontsize=22,
    padding=3,
)
extension_defaults = widget_defaults.copy()

# widget data functions
def memory_usage():
    mem=psutil.virtual_memory()
    return '\uF2DB {:02.0f}%'.format(mem.used / mem.total * 100)

def open_calendar():
    qtile.spawn('gsimplecal')

def mpris():
    status=subprocess.run(['playerctl',  '-p', 'youtubemusic', 'status'], capture_output=True,
                          text=True).stdout.strip('\n')
    metadata=subprocess.run(['playerctl', '-p', 'youtubemusic', 'metadata', '--format', '{{artist}} - {{title}}'],
                            capture_output=True, text=True).stdout.strip('\n')
    if status == 'Playing':
        status = ' \uF04B'
    elif status == 'Paused':
        status = ' \uF04C'
    else:
        status = ''
    return metadata + status

def play_toggle():
    qtile.spawn('playerctl play-pause')

# widget separators
def separator(foreground='', background=''):
    return widget.TextBox(
        text='\uE0BA',
        width=32,
        fontsize=96,
        padding=-10,
        foreground=foreground,
        background=background,
    );

# generate primary bar
def primary_bar():
    return bar.Bar(
        widgets=[
            widget.CurrentLayoutIcon(
                custom_icon_paths=[os.path.expanduser('~/.config/qtile/icons')],
                scale=0.66,
            ),
            widget.GroupBox(
                fontsize=26,
                padding_x=15,
                disable_drag=True,
                use_mouse_wheel=False,
                background=palette[1],
                inactive=palette[3],
                highlight_color=palette[10],
                highlight_method='line',
                this_current_screen_border=palette[13],
                other_current_screen_border=palette[13],
                this_screen_border=palette[10],
                other_screen_border=palette[10],
            ),
            widget.Spacer(length=bar.STRETCH),
            widget.GenPollText(func=mpris,
                               update_interval=1,
                               mouse_callbacks={'Button1': play_toggle}),
            separator(palette[10], palette[1]),
            widget.Systray(background=palette[10],
                           icon_size=32,
                           padding=10),
            separator(palette[9], palette[10]),
            widget.Wttr(background=palette[9],
                        format='%c%t',
                        units='u'),
            separator(palette[10], palette[9]),
            widget.TextBox(text='\uF027 ', background=palette[10]),
            widget.Volume(step=5,
                          background=palette[10]),
            separator(palette[9], palette[10]),
            widget.Battery(battery=1,
                           format='{char}  {percent:2.0%}',
                           charge_char='\uF1E6',
                           discharge_char='\uF242',
                           full_char='\uF240',
                           empty_char='\uF244',
                           unknown_char='\uEB32',
                           not_charging_char='\uF05E',
                           update_interval=1,
                           notify_below=10,
                           background=palette[9]),
            separator(palette[10], palette[9]),
            widget.Clock(format='\uF133  %a %b %d',
                         background=palette[10],
                         mouse_callbacks={'Button1': open_calendar}),
            separator(palette[9], palette[10]),
            widget.Clock(format='\uF017 %I:%M %p', background=palette[9]),
            separator(palette[1], palette[9]),
        ],
        size=36,
        background=palette[1],
    )

# screens
screens = [
    Screen(top=primary_bar()),
]

# TODO: set these based on actual screen layout
primary_screen   = 0
secondary_screen = 2
laptop_screen    = 1

# workspaces
# workspace names
group_names = [("1", {'label': "󰲠", 'layout': 'monadtall', 'screen_affinity': primary_screen}),
               ("2", {'label': "󰲢", 'layout': 'monadtall', 'screen_affinity': primary_screen}),
               ("3", {'label': "󰲤", 'layout': 'monadtall', 'screen_affinity': primary_screen}),
               ("4", {'label': "󰲦", 'layout': 'monadtall', 'screen_affinity': primary_screen}),
               ("5", {'label': "󰲨", 'layout': 'max', 'screen_affinity': secondary_screen})]

# TODO: only add this in 3 screen layout
group_names.append(("6", {'label': "󰲪", 'layout': 'max', 'screen_affinity': laptop_screen}))

groups = [Group(name, **kwargs) for name, kwargs in group_names]

# helper function to pin workspaces to screens
def go_to_group(group):
    def f(qtile):
        if len(qtile.screens) == 1:
            qtile.groups_map[group].toscreen()
            return

        if group in '1234':
            qtile.focus_screen(primary_screen)
            qtile.groups_map[group].toscreen()
        elif group in '5':
            qtile.focus_screen(secondary_screen)
            qtile.groups_map[group].toscreen()
        else:
            qtile.focus_screen(laptop_screen)
            qtile.groups_map[group].toscreen()

    return f

# workspace keybinds
for i, (name, kwargs) in enumerate(group_names, 1):
    # switch workspaces
    keys.append(Key([mod], str(i), lazy.function(go_to_group(name))))
    # send window to workspace
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name)))

# dropdown scratchpad terminal
groups.append(ScratchPad("scratchpad", [
    DropDown("term", terminal),
]))
keys.append(Key([mod], "grave", lazy.group['scratchpad'].dropdown_toggle('term')))

# mod + left click-drag, set floating
# mod + right click-drag, resize
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client
    *layout.Floating.default_float_rules,
    Match(wm_class='gsimplecal'),
    Match(wm_class='crx_nngceckbapebfimnlniiiahkandclblb'), # bitwarden extension
], **layout_theme)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

# startup applications
@hook.subscribe.startup_once
def start_once():
    subprocess.call([home + '/.config/qtile/autostart.sh'])

@hook.subscribe.screens_reconfigured
async def screen_reconf():
    logger.warning("Screens reconfigured")
    await asyncio.sleep(2)
    logger.warning("Reloading config...")
    qtile.reload_config()
    # re-scale wallpaper
    subprocess.call([home + '/.fehbg'])

# start app in group
@hook.subscribe.client_new
def start_in_group(client):
    # 'wm_class': 'group_name'
    apps = {'discord': '5',
            'youtube-music-desktop-app': '6',
            'xterm': '2',
            'XTerm': '2',
            'Cssh': '2',
            'cssh': '2',
            }
    wm_class = client.window.get_wm_class()[0]
    group = apps.get(wm_class, None)
    if group:
        client.togroup(group)
