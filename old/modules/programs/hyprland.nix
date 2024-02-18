{ config, lib, pkgs, ... }:

{
    wayland.windowManager.hyprland = {
        enable = true;
        systemdIntegration = true;
        nvidiaPatches = true;
        extraConfig = ''
            # monitors
            monitor=,preferred,auto,auto

            # execute apps at launch
            exec-once = waybar & dunst & hyprpaper

            exec-once=xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 2

            # mouse cursor
            exec-once=hyprctl setcursor Bibata-Modern-Ice 24

            # source a file (multi-file configs)
            # source = ~/.config/hypr/myColors.conf

            input {
                kb_layout = us
                kb_variant = altgr-intl
                kb_model =
                kb_options =
                kb_rules =

                follow_mouse = 2

                touchpad {
                    natural_scroll = true
                    clickfinger_behavior = true
                }

                sensitivity = 0
            }

            general {
                gaps_in = 6
                gaps_out = 16
                border_size = 2
                col.active_border = rgba(cba6f7ee) rgba(f5c2e7ee) 45deg
                col.inactive_border = rgba(1e1e2eff)

                layout = dwindle
            }

            windowrule = opacity 0.8 0.8,^(kitty)$
            windowrulev2 = float,floating:0,class:^(ide*)
            windowrulev2 = forceinput,class:^(ide*)
            windowrulev2 = windowdance,class:^(ide*) # allows IDE to move child windows

            decoration {
                rounding = 8
                blur = yes
                blur_size = 16
                blur_passes = 2
                blur_new_optimizations = on

                drop_shadow = yes
                shadow_range = 4
                shadow_render_power = 3
                col.shadow = rgba(1a1a1aee)
            }

            animations {
                enabled = yes

                bezier = myBezier, 0.05, 0.9, 0.1, 1.05

                animation = windows, 1, 7, myBezier
                animation = windowsOut, 1, 7, default, popin 80%
                animation = border, 1, 10, default
                animation = fade, 1, 7, default
                animation = workspaces, 1, 6, default
            }

            dwindle {
                pseudotile = true
                preserve_split = true
            }

            master {
                new_is_master = true
            }

            gestures {
                workspace_swipe = true
                workspace_swipe_distance = 300
            }

            misc {
                disable_hyprland_logo = true
                # no_vfr = false
            }

            device:epic mouse V1 {
                sensitivity = -0.5
            }

            # window rules
            windowrule = float,title:^(Bluetooth Devices)$
            windowrule = tile,title:^(MATLAB R2022b - academic use)$

            # mod key
            $mainMod = SUPER

            # window
            bind = $mainMod, Q, killactive,
            bind = $mainMod, F, fullscreen,
            bind = $mainMod, V, togglefloating, 
            bind = $mainMod, P, pseudo, # dwindle
            bind = $mainMod, J, togglesplit, # dwindle
            bind = $mainMod SHIFT, M, exit, 

            # launcher
            bind = $mainMod, R, exec, wofi --show drun

            # terminal
            bind = $mainMod, Return, exec, kitty

            # volume control
            bindl = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
            bindle = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
            bindle = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+

            # media control
            bindl = , XF86AudioPlay, exec, playerctl play-pause
            bindl = , XF86AudioPrev, exec, playerctl previous
            bindl = , XF86AudioNext, exec, playerctl next

            # backlight controls
            bindle = , XF86KbdBrightnessDown, exec, light -U 5 
            bindle = , XF86KbdBrightnessUp, exec, light -A 5 
            bindle = , XF86MonBrightnessDown, exec, light -U 5 
            bindle = , XF86MonBrightnessUp, exec, light -A 5 

            # screenshot
            bind = , Print, exec, grim -g "$(slurp)"

            # move focus with mod + arrow keys
            bind = $mainMod, left, movefocus, l
            bind = $mainMod, right, movefocus, r
            bind = $mainMod, up, movefocus, u
            bind = $mainMod, down, movefocus, d

            # switch workspaces with mod + [0-9]
            bind = $mainMod, 1, workspace, 1
            bind = $mainMod, 2, workspace, 2
            bind = $mainMod, 3, workspace, 3
            bind = $mainMod, 4, workspace, 4
            bind = $mainMod, 5, workspace, 5
            bind = $mainMod, 6, workspace, 6
            bind = $mainMod, 7, workspace, 7
            bind = $mainMod, 8, workspace, 8
            bind = $mainMod, 9, workspace, 9
            bind = $mainMod, 0, workspace, 10

            # move active window to a workspace with mod + SHIFT + [0-9]
            bind = $mainMod SHIFT, 1, movetoworkspace, 1
            bind = $mainMod SHIFT, 2, movetoworkspace, 2
            bind = $mainMod SHIFT, 3, movetoworkspace, 3
            bind = $mainMod SHIFT, 4, movetoworkspace, 4
            bind = $mainMod SHIFT, 5, movetoworkspace, 5
            bind = $mainMod SHIFT, 6, movetoworkspace, 6
            bind = $mainMod SHIFT, 7, movetoworkspace, 7
            bind = $mainMod SHIFT, 8, movetoworkspace, 8
            bind = $mainMod SHIFT, 9, movetoworkspace, 9
            bind = $mainMod SHIFT, 0, movetoworkspace, 10

            # scroll through existing workspaces with mod + scroll
            bind = $mainMod, mouse_down, workspace, e+1
            bind = $mainMod, mouse_up, workspace, e-1

            # move/resize windows with mod + LMB/RMB and dragging
            bindm = $mainMod, mouse:272, movewindow
            bindm = $mainMod, mouse:273, resizewindow
        '';
    };
}