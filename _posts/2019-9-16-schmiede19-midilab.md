---
layout: post
title: Schmiede19 MIDILAB
comments: true
published: 2019-01-01
image: /images/2019-9-16-schmiede19-midilab/IMG_5209.jpg
draft: true
---

<a name="hardware"></a>
# Getting to know the hardware

[official Arduino specs comparision table](https://www.arduino.cc/en/products.compare)

### Nano

![arduino_nano_pin_functions_oreilley.png](:/2a79f0d40410461487d048e2c6f11b52)

Pic source: https://www.oreilly.com/library/view/arduino-a-technical/9781491934319/assets/aian_0422.png

#### Chinese Nano clones (CH340)

Programming error:
avrdude: stk500_getsync(): not in sync: resp=0x00

My cheap chinese Arduino Nano clones have to be programmed using this _processor_ setting in the Arduino tool: "ATmega328b (old bootloader)"

Problem with CHU driver on Mac OS High Sierra
https://www.youtube.com/watch?v=pxc1zRtZqIs


### Pro Micro

![Arduino_Pro_Micro_pinout.jpg](:/c728accb9f684f728f7aefa76b788d11)


<div class="clearfix">
  {% include thumb.html filename='/images/2019-9-16-schmiede19-midilab/pro_micro_pins_color.jpg' alt_text='pro_micro_pins_color.jpg' caption='' width="49%" float="left" %}
  {% include thumb.html filename='/images/2019-9-16-schmiede19-midilab/nano_pins_color.jpg' alt_text='nano_pins_color.jpg' caption='' width="49%" float="left" %}
</div>
<br>

[Sparkfun Pro Micro hookup guide](https://learn.sparkfun.com/tutorials/pro-micro--fio-v3-hookup-guide/hardware-overview-pro-micro)

nice Pro Micro connections video-tutorial, also about multiplexing input:

https://www.youtube.com/watch?v=y0v2clCVw9k

#### Chinese Pro Micro clones

ATmega32U4 5V 16MHz



### Template stuff (ignore)

3 pics in a row template here:

<div class="pic_row_3">
  <div class="pic_left">
    {% include thumb.html filename='/images/2018-11-17-midictrl1/matrixmidi-xx.jpg' caption='' %}
  </div>
  <div class="pic_middle">
    {% include thumb.html filename='/images/2018-11-17-midictrl1/matrixmidi-xx.jpg' caption='' %}
  </div>
  <div class="pic_right">
    {% include thumb.html filename='/images/2018-11-17-midictrl1/matrixmidi-xx.jpg' caption='' %}
  </div>
</div>




youtube video here:

{% include youtube.html id="xxxxxx" width="100%" %}
text under youtube video
<br><br>




[link 1](https://www.musikding.de/20-Pin-inline-socket)<br>
[link 2](https://www.musikding.de/10-Pin-strip)<br>