# AWS Streaming Instance Setup

We have provided a public AMI with everything all setup, but if you are interested in making your own AMI, we have included the steps we took.

1. Spin up a g2.2xlarge instance running Microsoft Windows Server 2012 Base (make sure to use spot instances as this will save a ton of money).

2. Follow steps 2-6 from this [wonderful tutorial](http://lg.io/2015/07/05/revised-and-much-faster-run-your-own-highend-cloud-gaming-service-on-ec2.html). Note that we will are using a different method of streaming than described in the turioal above, but the basic windows setup is applicable.

3. Block access to the following nvidia websites by adding these two lines to your hosts file:
    
    > 127.0.0.1 gfwsl.geforce.com
    
    > 127.0.0.1 services.gfe.nvidia.com
4. Download version of the NVIDIA GeoForce Experience v2.5.14.5 (we have tested this version, but it's possible that newer versions will work too)

5. By default, GFE only works with GTX graphics cards and not the k520 included with the g2.2xlarge instance. Therefore we must replace the device id of a whitelisted graphics card with the device id of the k520 (118A). Follow steps 2-6 from this [XDA developers post](http://forum.xda-developers.com/showpost.php?p=63335126&postcount=163).

6. Reboot the instance.

7. Since Microsoft Remote Desktop messes with the graphics driver, we will setup a VNC server to interact with the instance. We used [TightVNC](http://www.tightvnc.com/).

8. Perform all Windows updates and install the following features to Windows Server 2012.

    > .NET Framework 3.5 
    
    > .NET Framework 4.5
    
    > Quality Windows Audio Video Experience
    
9. Install applications you want to stream to the Pi. We installed [Steam](https://store.steampowered.com/) and [Blender](https://www.blender.org/).

10. On your raspberry pi, run `moonlight pair <ip address of instance>`. Your pi should display a pin code that you should put into your instance.

11. TODO streaming stuff
