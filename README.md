# Arduino - Raspberry (Bash)

This repo transfer data sent by the serial monitor to the raspberry and do something with it.

# Installation

When you execute detect.sh and does not have everything installed, they will ask you to install it. This repo needs ttylog and curl (if you want to make a petition to an API).

# Usage

Start the script

```./detect.sh start

Stop the script

```./detect.sh stop

NOTE: even if you stop it with CTRL+C its still running in the background, the only thing that stops is the action, but raspberry will still recolect info sent by the arduino.


