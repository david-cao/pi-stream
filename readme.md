pi-stream
========

Streaming Applications to the Raspberry Pi using [Amazon Web Services](https://aws.amazon.com/) and [NVIDIA GameStream]( http://shield.nvidia.com/game-stream)


Getting started
---------------

Start by downloading the repo or cloning it on your pi.
`git clone https://github.com/dcao96/pi-stream`

Open up your terminal and cd to the directory you just cloned/downloaded. Run the setup script with `./setup-pi.script`, and wait for it to finish. This is downloading [moonlight-embedded](https://github.com/irtimmer/moonlight-embedded), which is for streaming to your pi, and setting up [xboxdrv](https://github.com/xboxdrv/xboxdrv), which enables controller support. 

If you want to have controllers supported on startup, after the setup script finishes you'll have to edit your `/etc/rc.local` file and add the line `xboxdrv --silent` somewhere before the `exit 0`.

