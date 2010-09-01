#dmenu_i3
#Gazj 2010 garyjames82atgmaildotcom
#execute i3 commands using dmenu, history stored under ~/.i3/dmenu

if [ -f $HOME/.dmenurc ]; then
  . $HOME/.dmenurc
else
  DMENU='dmenu -i'
fi

GS=`cat ~/.i3/dmenu | $DMENU -p "i3 command:" $*`

if grep -q "$GS" "$HOME/.i3/dmenu" ; then
    echo already exists in history
else
    echo $GS >> ~/.i3/dmenu
fi

i3-msg $GSS
