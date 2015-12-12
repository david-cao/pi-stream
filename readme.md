pi-stream
=========

Streaming Applications to the Raspberry Pi using [Amazon Web Services](https://aws.amazon.com/), [NVIDIA GameStream]( http://shield.nvidia.com/game-stream) and [Moonlight Embedded](https://github.com/irtimmer/moonlight-embedded).

A final project for [CIS 191](https://www.seas.upenn.edu/~cis191/index.html)

Getting started
---------------

Start by downloading the repo or cloning it on your pi.
`git clone https://github.com/dcao96/pi-stream`

Open up your terminal and cd to the directory you just cloned/downloaded. Run the setup script with `sudo ./setup-pi.script`, and wait for it to finish. This is downloading [moonlight-embedded](https://github.com/irtimmer/moonlight-embedded), which is for streaming to your pi, and setting up [xboxdrv](https://github.com/xboxdrv/xboxdrv), which enables controller support. It also downloads aws-cli, which is the command line interface for AWS, which is needed if you're going to use our `start_instance.sh` or `stop_instance.sh` scripts.

If you want to have controllers supported on startup, after the setup script finishes you'll have to edit your `/etc/rc.local` file and add the line `xboxdrv --silent` somewhere before the `exit 0`.

Once you've done all that, restart your pi.

Streaming to your pi
-----------

Once you've setup your pi, we can start streaming to it. We first need to fire up an instance to stream from. This can be done by simply running our start script: 
> Make sure your AWS credentials are filled in the scripts. If you already have your AWS credentials exported, don't worry about this.

`. start_instance.sh`

Then you're going to have to pair your pi to the instance you've just created. We've saved the IP for you, so simply run `moonlight pair $IP`. Next, remote desktop into your instance with VNC with the password `cis191test` (this will change in the future). Login to the instance using the password `AWSpi-streamCIS191project!`, and you should be prompted by Nvidia Gamestream for a pin. Enter the pin your pi displays and you should be good to go. Test the pairing by running `moonlight list $IP`, which should list Steam and Blender.

You can now stream to your pi by simply running `moonlight stream -app AppName $IP`. Or, you can use our aliases, which should have been set by the setup script. `moonlight-stream-720` runs the stream in 720p, and `moonlight-stream-1080` does the same in 1080p. Both are in 30fps. You can read more about moonlight-embedded [here](https://github.com/irtimmer/moonlight-embedded).

To shut down your instance, you can just run the shut down script we've provided.
`./stop_instance.sh`

__PLEASE SHUT DOWN YOUR INSTANCES ONCE YOU ARE DONE, SINCE THEY COST AROUND 10 CENTS AN HOUR__

Mapping a controller
----------

If you want to use a controller, you'll have to map one. Connect your controller to the pi, and run `sudo moonlight map /usr/local/bin/xbox.map`. Once you've mapped your controller, you can stream with this mapping, for example using `moonlight stream -720 -30fps -mapping /usr/local/bin/xbox.map -app Steam $IP`. The two aliases we created for you include this mapping already, so you could also simply run `moonlight-stream-720 Steam $IP`.

If you want to use multiple controllers, you'll need to run multiple jobs for xboxdrv. Take a look at  [moonlight-embedded's controller guide](https://github.com/irtimmer/moonlight-embedded/wiki/Controllers-set-up) to get started with this.

Additional Info
----------

You will need an AWS instance to stream from. This project uses g2.2xlarge spot instances that include a K520 GRID GPU.
We have created an Amazon Machine Image (AMI) with everything already setup as well as `start_instance.sh` to launch a spot instance. Below is information about the instance:
  > AMI id: ami-22b7ff48
  
  > AMI Password: AWSpi-streamCIS191project!
  
  > NVIDIA Driver Version: WHQL 359.00 - Windows 8.1 64-bit
  
  > GeForce Experience Version: v2.5.14.5

  > VNC Password: cis191test

Using your own AMI
-----------

If you're feeling adventurous, take a look at the [AWS instance setup instructions](https://github.com/dcao96/pi-stream/blob/master/AWSsetup.md).
