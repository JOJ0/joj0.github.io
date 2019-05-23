---
layout: post
title: Volca Beats JTCTRL
comments: true
published: 2019-05-23
image: /images/2018-5-10-volca-beats-m4l-jtctrl/Volca_Beats_JTCTRL_v0.8.3.png
draft: true
---

This is a quick one: I extended my [Volca Beats Velocititzer]({% post_url 2018-3-11-volca-beats-m4l-velocity %}) with a couple of features.<br>
Download the "Max for Live" device [here](http://www.maxforlive.com/library/device/5479/volca-beats-jtctrl)<br>

![JTCTRL screenshot](/images/2018-5-10-volca-beats-m4l-jtctrl/Volca_Beats_JTCTRL_v0.8.3.png)

<a name="features"></a>
### Features

* Everything that's MIDI-CC-controllable on the Beats can be controlled via the dial controls.

* The "4x4" switch moves Agogo and Claves to MIDI notes inide the 4x4 grid of the first page of your MPC-style controller. No more switching to the next 16 pads!

* The "Send State" button sends, as you probably have already guessed, the current state (duh!), of all dials to your Beats - Thus you can save the settings of your machine together with your Ableton Live project!

* The "Blocked" button is a weird one: It changes the "default loading behaviour" of Ableton Live projects containing M4L devices.
    * Normally whenever you are loading a Live project, all contained M4L devices "bang" out their settings of their dials via MIDI - which means: Whenever you are loading a Live project, immediately your Volca Beats sounds different - I don't like this behaviour, so this M4L device prevents the data to be sent to the Volca Beats - it does not let MIDI CC's through as along as you _manually_ _switch off_ the "Blocked" mode!
    * So basicaly the user has to first unblock the device with this button before it can be used! (The text "Blocked" has to be _unlit_)

* And yes, certainly JTCTRL makes your Volca Beats velocity sensitive, as long as it's controlled via MIDI notes, exactely like the Velocitizer does.

The device was developed around Mar to May 2018, since then I am using it on each and every gig with my band ADHS - consider it stable! I am up for feature requests!
