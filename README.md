# Focus sessions

A tool that records your screen during a Pomodoro session. Watch yourself work, increase awareness, stay focused.
Read more here: https://alexey.codes/work/pomodoro

## How to use

1. Create folder for the outputs
```
mkdir $HOME/focus_sessions
```

2. Install dependencies
```
brew install ffmpeg
```

3. Make `focusSession.sh` available everywhere (symlink it to any folder in your PATH)
```
ln -s /repo/focusSession.sh /folder/in/your/PATH/focus
```

4. Start your first session
```
focus 25
```
