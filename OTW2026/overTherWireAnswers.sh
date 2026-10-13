#level 0 to level 1
export OTWHOST=bandit.labs.overthewire.org
export OTWPORT=2220
export OTWUSERNAME=bandit0
export OTWPASSWORD=bandit0

echo ssh $OTWUSERNAME@$OTWHOST -p $OTWPORT
#echo $OTWLOGIN
#$OTWLOGIN
ssh $OTWUSERNAME@$OTWHOST -p $OTWPORT

echo $OTWPASSWORD
