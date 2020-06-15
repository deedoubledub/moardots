from libqtile.config import Key, Screen, Group, ScratchPad, DropDown, Drag, Click
from libqtile.lazy import lazy
from libqtile import layout, bar, widget, hook
from typing import List  # noqa: F401
import os
import subprocess
import psutil

mod = "mod1"
terminal = "alacritty"
browser = "google-chrome"
fm = "nautilus"

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

    # TODO: screen management keys

    # restart qtile
    Key([mod, "shift"], "r", lazy.restart()),

    # quit qtile
    Key([mod, "shift"], "Escape", lazy.shutdown()),

    # open terminal
    Key([mod], "Return", lazy.spawn(terminal)),

    # rofi launcher (placeholder)
    Key([mod], "d", lazy.spawn(terminal)),

    # web browser
    Key([mod], "i", lazy.spawn(browser)),

    # file manager
    Key([mod], "o", lazy.spawn(fm)),

    # flameshot
    Key([mod], "Print", lazy.spawn('flameshot gui')),

    # TODO: open music player
    # TODO?: open slack
    # TODO?: open discord
]

# workspaces
# workspace names
group_names = [("\uF484", {'layout': 'monadtall'}),
               ("\uF489", {'layout': 'monadtall'}),
               ("\uF07C", {'layout': 'monadtall'}),
               ("\uF11B", {'layout': 'monadtall'}),
               ("\uF086", {'layout': 'monadtall'})]

groups = [Group(name, **kwargs) for name, kwargs in group_names]

# helper function to pin workspaces to screens
# https://github.com/qtile/qtile/issues/1271#issuecomment-458107043
def go_to_group(group):
    def f(qtile):
        # workspaces 1-4 on primary screen
        if group in [name[0] for name in group_names][0 : 4]:
            qtile.cmd_to_screen(0)
            qtile.groups_map[group].cmd_toscreen(toggle=False)
        # workspaces 5+ on secondary screen
        else:
            qtile.cmd_to_screen(1)
            qtile.groups_map[group].cmd_toscreen(toggle=False)
    return f

# workspace keybinds
for i, (name, kwargs) in enumerate(group_names, 1):
    # switch workspaces
    # workspaces 1-4 on primary screen, 5+ on secondary screen
    keys.append(Key([mod], str(i), lazy.function(go_to_group(name))))
    # send window to workspace
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name)))

# dropdown scratchpad terminal
groups.append(ScratchPad("scratchpad", [
    DropDown("term", terminal),
]))
keys.append(Key([mod], "grave", lazy.group['scratchpad'].dropdown_toggle('term')))

# layouts
layout_theme = {
    "margin": 5,
    "border_width": 2,
    "border_focus": "EBCB8B",
    "border_normal": "4C566A",
}

layouts = [
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.Max(),
]

# widget default config
widget_defaults = dict(
    font='RobotoMono Nerd Font',
    fontsize=14,
    padding=3,
)
extension_defaults = widget_defaults.copy()

# widget data functions
def memory_usage():
    mem=psutil.virtual_memory()
    return '\uF2DB {:02.0f}%'.format(mem.used / mem.total * 100)

# widget separators
def separator(side='', foreground='', background=''):
    if side == 'left':
        text=u'\uE0BA'
    elif side == 'right':
        text=u'\uE0BC'
    return widget.TextBox(
        text=text,
        width=28,
        fontsize=55,
        padding=-21,
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
                padding_x=5,
                margin_x=5,
                spacing=10,
                fontsize=18,
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
            widget.WindowName(),
            widget.Systray(),
            separator('left', palette[10], palette[1]),
            widget.GenPollText(func=memory_usage,
                               update_interval=1,
                               background=palette[10]),
            separator('right', palette[10], palette[9]),
            widget.CPU(format='\uF9C4 {load_percent}%', background=palette[9]),
            separator('right', palette[9], palette[10]),
            widget.CheckUpdates(distro='Ubuntu',
                                restart_indicator=' \uFC07',
                                update_interval=3600,
                                custom_command="apt-get -s dist-upgrade | awk '/^Inst/ { print $2 }'",
                                display_format='\uF0AB {updates}',
                                background=palette[10],
                                ),
            separator('right', palette[10], palette[9]),
            widget.Clock(format='\uF5ED %a %b %d', background=palette[9]),
            separator('left', palette[10], palette[9]),
            widget.Clock(format='\uF017 %I:%M %p', background=palette[10]),
            separator('right', palette[10], palette[1]),
        ],
        size=28,
        background=palette[1],
    )

# TODO: battery widget on laptop
# TODO: mpris music widget
# TODO: volume widgets
# TODO: vpn status indicator

# screens
screens = [
    Screen(top=primary_bar()),
    Screen(),
]

# mod + left click-drag, set floating
# mod + right click-drag, resize
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client
        {'wmclass': 'confirm'},
        {'wmclass': 'dialog'},
        {'wmclass': 'download'},
        {'wmclass': 'error'},
        {'wmclass': 'file_progress'},
        {'wmclass': 'notification'},
        {'wmclass': 'splash'},
        {'wmclass': 'toolbar'},
    ],
    **layout_theme
)
auto_fullscreen = True
focus_on_window_activation = "smart"

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
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])
