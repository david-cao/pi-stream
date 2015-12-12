pi-stream
=========

Streaming Applications to the Raspberry Pi using [Amazon Web Services](https://aws.amazon.com/) and [NVIDIA GameStream]( http://shield.nvidia.com/game-stream).

A final project for [CIS 191](https://www.seas.upenn.edu/~cis191/index.html)

Getting started
---------------

Start by downloading the repo or cloning it on your pi.
`git clone https://github.com/dcao96/pi-stream`

Open up your terminal and cd to the directory you just cloned/downloaded. Run the setup script with `./setup-pi.script`, and wait for it to finish. This is downloading [moonlight-embedded](https://github.com/irtimmer/moonlight-embedded), which is for streaming to your pi, and setting up [xboxdrv](https://github.com/xboxdrv/xboxdrv), which enables controller support. 

If you want to have controllers supported on startup, after the setup script finishes you'll have to edit your `/etc/rc.local` file and add the line `xboxdrv --silent` somewhere before the `exit 0`.

You will need an AWS instance to stream from. This project uses g2.2xlarge spot instances that include a K520 GRID GPU.
We have created an Amazon Machine Image (AMI) with everything already setup as well as `start_instance.sh` to launch a spot instance. Below is information about the instance:
  > AMI id: ami-22b7ff48
  
  > AMI Password: AWSpi-streamCIS191project!
  
  > NVIDIA Driver Version: WHQL 359.00 - Windows 8.1 64-bit
  
  > GeForce Experience Version: v2.5.14.5

  > VNC Password: cis191test

If you're feeling adventurous, take a look at the [AWS instance setup instructions](https://github.com/dcao96/pi-stream/blob/master/AWSsetup.md)

