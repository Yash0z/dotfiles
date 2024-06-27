#!/usr/bin/env fish

function get_brightness
  set brightness (brightnessctl | grep 'Current brightness' | cut -d ':' -f 2 | tr -d ' ')
  set brightness (string match -r '\d+' $brightness)
  echo $brightness
end

function send_notification
  set icon "preferences-system-brightness-lock"
  set brightness (get_brightness)
  set bar (seq --separator="─" 0 (math $brightness / 10) | sed 's/[0-9]//g')
  set brightness_percent (get_brightness)
  set notification_text "Light: $brightness_percent%"\n"$bar"
  dunstify -i $icon -r 5555 -u normal "$notification_text"
end

switch $argv[1]
  case up
    # increase the backlight by 5%
    brightnessctl set +5%
    send_notification
  case down
    # decrease the backlight by 5%
    brightnessctl set 5%-
    send_notification
end
