---
layout: post
title: The Story of ADHS-Tron
---

The mission: My friend Lena&#39;s Korg Monotron should become controllable via MIDI from a DAW. <br>

<br>

<div class="clearfix">
{% include figure.html filename='/images/2017-09-10_adhs-tron/1.jpg' alt_text='pic 1' caption='Starting Point: Monotron, a Perfboard and an Arduino Uno' width="49%" float="left" %}
{% include figure.html filename='/images/2017-09-10_adhs-tron/2.jpg' alt_text='pic 2' caption='Naked-Tron' width="49%" float="right" %}
</div>
<br>

![pic 3]({{ "/images/2017-09-10_adhs-tron/3.jpg" | absolute_url }})
First goal reached: Arduino receives MIDI notes through a MIDI input circuit
<br><br>

{% include youtube.html id="5jWiUlhN29o" width="100%" %}
Arduino receives MIDI through input circuit and triggers Gate and Pitch CV inputs on Monotron. As you can hear it&#39;s not quite a major or chromatic scale. Arduino Uno&#39;s 8bit DAC can&#39;t output precise enough voltages for Pitch CV.
<br><br>

![pic 4]({{ "/images/2017-09-10_adhs-tron/4.jpg" | absolute_url }})
The solution to the Pitch Control Voltage problem with Arduino Uno: Microcontroller &#34;Teensy 3.2&#34;, equipped with a 12 bit DAC, precise enough to generate the needed voltages.
<br><br>

![pic 5]({{ "/images/2017-09-10_adhs-tron/5.jpg" | absolute_url }})
Added two new features: Filter cutoff controllable via MIDI CC or MIDI velocity, MIDI control can be switched off to keep original onboard filter control intact.
<br><br>

![pic 6]({{ "/images/2017-09-10_adhs-tron/6.jpg" | absolute_url }})
The first cardboard prototype of Tron&#34;s new housing.
<br><br>

Video 2 hier

Filter controlled via MIDI CC (pink line), playing around with the resonance is always fun
<br><br>

![pic 7]({{ "/images/2017-09-10_adhs-tron/7.jpg" | absolute_url }})
To fit everything in the case, all components on the breadboard (white) are to be soldered on a perfboard (brown). The original Monotron printed circuit board should sit right next to it.
<br><br>

![pic 8]({{ "/images/2017-09-10_adhs-tron/8.jpg" | absolute_url }})
Designing and soldering the perfboard
<br><br>

![pic 9]({{ "/images/2017-09-10_adhs-tron/9.jpg" | absolute_url }})
The almost finished perfboard
<br><br>

![pic 10]({{ "/images/2017-09-10_adhs-tron/10.jpg" | absolute_url }})
Perfboard flipside
<br><br>

Video 3 hier

Features presented in order of appearance (If unpatient skip to 2:30 for some acidish sounds)
* Filter cutoff and resonance controlled locally
* Filter cutoff controlled via MIDI CC (pink line), resonance locally
* LFO modulating filter cutoff, amount and rate controlled locally

additional features not shown here
* Filter cutoff controlled via MIDI velocity
* LFO controlled via MIDI CC
<br><br>

![pic 11]({{ "/images/2017-09-10_adhs-tron/11.jpg" | absolute_url }})
Happy outdoor hacking
<br><br>

![pic 12]({{ "/images/2017-09-10_adhs-tron/12.jpg" | absolute_url }})
Designing the final layout of the control elements
<br><br>

![pic 13]({{ "/images/2017-09-10_adhs-tron/13.jpg" | absolute_url }})
The final cardboard prototype
<br><br>

![pic 14]({{ "/images/2017-09-10_adhs-tron/14.jpg" | absolute_url }})

<br><br>

![pic 15]({{ "/images/2017-09-10_adhs-tron/15.jpg" | absolute_url }})

<br><br>

![pic 16]({{ "/images/2017-09-10_adhs-tron/16.jpg" | absolute_url }})

<br><br>

![pic 17]({{ "/images/2017-09-10_adhs-tron/17.jpg" | absolute_url }})

<br><br>
