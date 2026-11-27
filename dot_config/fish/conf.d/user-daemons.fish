# start the background helpers on login (also headless/ssh), see start-user-daemons
if status is-login; and test -x ~/.local/bin/start-user-daemons
    ~/.local/bin/start-user-daemons
end
