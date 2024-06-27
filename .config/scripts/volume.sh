#!/usr/bin/env fish

function get_volume
  pamixer --get-volume
end

function is_mute
  pamixer --get-mute | grep -q "true"
end

function send_notification
  set iconSound "audio-volume-high"
  set iconMuted "audio-volume-muted"

  if is_mute
    dunstify -i $iconMuted -r 2593 -u normal "Muted"
  else
    set volume (get_volume)
    set bar (seq --separator="─" 0 (math $volume / 4) | sed 's/[0-9]//g')
    set volume_percent (get_volume)
    set volume_text "Volume: $volume_percent%"\n"$bar"
    dunstify -i $iconSound -r 5555 -u normal "$volume_text"
  end
end

switch $argv[1]
  case up
    pamixer --unmute > /dev/null
    pamixer --increase 5 > /dev/null
    send_notification
  case down
    pamixer --unmute > /dev/null
    pamixer --decrease 5 > /dev/null
    send_notification
  case mute
    pamixer --toggle-mute > /dev/null
    send_notification
end
