# Two fingers click = Middle click. Two fingers tap = Right click
synclient ClickFinger2=2 && synclient TapButton2=3
# We deactivate everything with 3 fingers, touchegg deals with it:
synclient ClickFinger3=0 && synclient TapButton3=0
# Start touchegg from ~/.config/touchegg/config.conf
# Might necessitate to patch unity as per: http://ineed.coffee/1068/os-x-like-multitouch-gestures-for-macbook-pro-running-ubuntu-12-10/
touchegg_relauch() {
    touchegg
    touchegg_relauch
}
touchegg_relauch
