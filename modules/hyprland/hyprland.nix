monitor=eDP-1,1920x1080@60,0x0,1
monitor=eDP-1,addreserved,0,0,48,0

exec-once=swaybg -i $NIXOS_CONFIG_DIR/pics/wallpaper.png
exec-once=foot --server
exec-once=wlsunset -l -23 -L -46
exec-once=eww daemon
exec-once=eww open bar
exec-once=dunst

input {
    follow_mouse=0
}

general {
    sensitivity=1
    main_mod=ALT

    gaps_in=6
    gaps_out=12
    border_size=4
    col.active_border=0xffb072d1
    col.inactive_border=0xff292a37

    damage_tracking=full
}

decoration {
    rounding=8
    blur=0
    drop_shadow=0
    shadow_range=60
    col.shadow=0x66000000
}

animations {
    enabled=1
    animation=windows,1,4,default,slide
    animation=borders,1,5,default
    animation=fadein,1,5,default
    animation=workspaces,1,3,default,vertslide
}

dwindle {
    pseudotile=0 # enable pseudotiling on dwindle
}

# example window rules
# for windows named/classed as abc and xyz
windowrule=float,move 0 0,pqiv
windowrule=float,foot-notes
#windowrule=size 420 69,abc
#windowrule=tile,xyz
#windowrule=float,abc
#windowrule=pseudo,abc
#windowrule=monitor 0,xyz

# example binds
bind=ALT,Return,exec,footclient
bind=ALTSHIFT,Q,killactive,
bind=ALT,V,togglefloating,
bind=ALT,R,exec,wofi --show run --xoffset=1670 --yoffset=12 --width=230px --height=984 --style=$HOME/.config/wofi.css --term=footclient --prompt=Run
bind=ALT,N,exec,cd ~/stuff/notes && footclient -a foot-notes sh -c "nvim ~/stuff/notes/$(date '+%Y-%m-%d').md"
bind=ALT,F,fullscreen,0

bind=ALT,h,movefocus,l
bind=ALT,l,movefocus,r
bind=ALT,k,movefocus,u
bind=ALT,j,movefocus,d

bind=ALTSHIFT,h,movewindow,l
bind=ALTSHIFT,l,movewindow,r
bind=ALTSHIFT,k,movewindow,u
bind=ALTSHIFT,j,movewindow,d

bind=ALT,1,workspace,1
bind=ALT,2,workspace,2
bind=ALT,3,workspace,3
bind=ALT,4,workspace,4
bind=ALT,5,workspace,5

bind=ALTSHIFT,exclam,movetoworkspacesilent,1
bind=ALTSHIFT,at,movetoworkspacesilent,2
bind=ALTSHIFT,numbersign,movetoworkspacesilent,3
bind=ALTSHIFT,dollar,movetoworkspacesilent,4
bind=ALTSHIFT,percent,movetoworkspacesilent,5

bind=,XF86MonBrightnessUp,exec,brightnessctl set +5%
bind=,XF86MonBrightnessDown,exec,brightnessctl set 5%-
bind=,XF86AudioRaiseVolume,exec,pamixer -i 5
bind=,XF86AudioLowerVolume,exec,pamixer -d 5