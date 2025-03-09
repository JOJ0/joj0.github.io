---
layout: post
title: ADHS-Tron - MIDI controlled Korg Monotron
comments: true
published: 2018-01-31
updated: 2022-04-30
image: images/2017-09-10_adhs-tron/18-th.jpg
---

The mission: My friend L&#39;s Korg Monotron should become controllable via MIDI from a DAW. <br>


## Getting Started

<div class="clearfix">
{% include thumb.html filename='/images/2017-09-10_adhs-tron/1.jpg' alt_text='pic 1' caption='Starting Point: Monotron, a Perfboard and an Arduino Uno' width="49%" float="left" %}
{% include thumb.html filename='/images/2017-09-10_adhs-tron/2.jpg' alt_text='pic 2' caption='Naked-Tron' width="49%" float="right" clear='yes' %}
{% include thumb.html filename='/images/2017-09-10_adhs-tron/3.jpg' alt_text='pic 3' caption='First goal reached: Arduino receives MIDI notes through a MIDI input circuit' width='75%' float='left' %}
</div>


{% include youtube.html id="5jWiUlhN29o" clear_before='yes' %}
Arduino receives MIDI through input circuit and triggers Gate and Pitch CV inputs on Monotron. As you can hear it&#39;s not quite a major or chromatic or _any_ scale. Arduino Uno&#39;s 8bit DAC can&#39;t output precise enough voltages for Pitch CV.

The code necessary for above described functionality:

```c++
#include <SoftwareSerial.h>
#include <MIDI.h>
#define USBserial Serial
SoftwareSerial MIDIserial(2, 4); // RX, TX

int LedInt = 13;
int PinGate = 6; // digital
int PinPitch = 9; // PWM
int PinCutoff = 10; // PWM??
bool gMidiGateOn = false;
uint8_t gMidiNoteValue = 0;
uint16_t gPitchAnalog = 0;

const uint8_t LOWEST_KEY = 24; // C2

//MIDI_CREATE_DEFAULT_INSTANCE(); // binds to default hardware port
MIDI_CREATE_INSTANCE(SoftwareSerial, MIDIserial, MIDI); // port is selectable here
//MIDI_CREATE_CUSTOM_INSTANCE(SoftwareSerial, MIDIserial, MIDI, MySettings); // altering settings

void debugNote (byte channel, byte pitch, byte velocity, uint16_t PitchAnalog) {
  USBserial.print(channel);
  USBserial.print(" ");
  USBserial.print(pitch);
  USBserial.print(" ");
  USBserial.print(velocity);
  USBserial.print(" ");
  USBserial.print(PitchAnalog);
  USBserial.println(" ");
}

void handleNoteOn(byte channel, byte pitch, byte velocity) {
  gMidiGateOn = true;
  gMidiNoteValue = pitch;
  if (pitch >= LOWEST_KEY) {
    gPitchAnalog = uint16_t((gMidiNoteValue-LOWEST_KEY)*835.666666666); // + gMidiPitchBend ;  // 8191/12
  }
  digitalWrite(LedInt, HIGH);
  digitalWrite(PinGate, HIGH);
  debugNote(channel, pitch, velocity, gPitchAnalog);
}

void handleNoteOff(byte channel, byte pitch, byte velocity) { // NoteOn messages with 0 velocity are interpreted as NoteOffs.
  digitalWrite(LedInt, LOW);
  digitalWrite(PinGate, LOW);
  //debugNote(channel, pitch, velocity);
}

void setup() {
  pinMode(LedInt, OUTPUT); // BuiltIn LED
  digitalWrite(LedInt, LOW); // LedInt off
  USBserial.begin(115200); // debugging here
  //MIDI.begin(MIDI_CHANNEL_OMNI);
  MIDI.begin(1);  // Listen to incoming messages on ch 1
  MIDI.setHandleNoteOn(handleNoteOn);
  MIDI.setHandleNoteOff(handleNoteOff);
}

void loop() {
  MIDI.read(); // Read incoming messages
}
```

At this point it's about time to tell you that the snippets you see on this page are reconstructed with the help of my git history and I can't guarantee that the program was completely working/bugfree at that particular commit. If you find something odd please leave a comment and I'm happy to help, correct it, whatever. On the bottom of this page you find a link to the final code that worked for me.
<br><br>

## Solving the Control Voltage Problem

{% include thumb.html filename='/images/2017-09-10_adhs-tron/4.jpg' alt_text='pic 4' caption='' width='49%' float='left' %}
{% include thumb.html filename='/images/2017-09-10_adhs-tron/4.5.jpg' alt_text='pic 4.5' caption='The solution to the Pitch Control Voltage problem with Arduino Uno: Microcontroller &#34;Teensy 3.2&#34;, equipped with a 12 bit DAC, precise enough to generate the needed voltages.' width='49%' float='right' clear='yes' %}

Arduino compatible code needs to be changed slightly to run on a Teensy (different serial ports and obviously pin numbers):

```c++
#include <MIDI.h>
#define USBserial Serial
#define MIDIserial Serial1

// Ableton C-2 = C0 = 00, Ableton C2 = C0 = 24; my keyb default range: 36-72
const uint8_t LOWEST_KEY = 36; // 24=C2, 36=C3
const uint8_t HIGHEST_KEY = 72; // 84=C7, 72=C6, 60=C5, 48=C4,

int LedInt = 13;
int PinGate = 2; // digital
int PinCutoff = 3; // PWM, to 30000 in setup
int PinPitch = A14; // DAC, to 30000 in setup

uint16_t gPitchAnalog = 0;

...
void setup() {
  ...
  analogWriteResolution(8); // default to 8bit PWM resolution
  analogWriteFrequency(PinCutoff, 30000);
  ...
}
...
```

At that time I was not quite sure how I could possibly get the pitches right, I just did not know what the volts/octave definition is for the Monotron. After hours of trial and error I came up with this formula that sounded correctly over almost a 3 octave range (the lowest 3 notes always are a bit too low if you tune your Monotron to about 10:00 o'clock):

```c++
...
uint16_t gPitchAnalog = 0;
...
gPitchAnalog = uint16_t((PitchMidi-LOWEST_KEY)*0.02577777/3.3*4096);
...
analogWrite(PIN_PITCH, gPitchAnalog);
...
```

Weeks later I found a little mark on the freely available Monotron schematic that might have helped :-O

```
whole ribbon Vbe offset
24.49mV@0deg
26.29mV@20deg
28.08mV@40deg
```

## Beyond Pitches

{% include thumb.html filename='/images/2017-09-10_adhs-tron/5.jpg' alt_text='pic 5' caption='Added two new features: Filter cutoff controllable via MIDI CC or MIDI velocity, MIDI control can be switched off to keep original onboard filter control intact (see bottom of post for code)' width='49%' float='left' %}
{% include thumb.html filename='/images/2017-09-10_adhs-tron/6.jpg' alt_text='pic 6' caption='The first cardboard prototype of Tron&#34;s new housing.' width='49%' float='right' %}

{% include youtube.html id="5XTypg-dH6w" clear_before='yes' %}
Filter controlled via MIDI CC (pink line), playing around with the resonance is always fun

{% include thumb.html filename='/images/2017-09-10_adhs-tron/7.jpg' alt_text='pic 7' caption='To fit everything in the case, all components on the breadboard (white) are to be soldered on a perfboard (brown). The original Monotron printed circuit board should sit right next to it' width='49%' float='left' %}
{% include thumb.html filename='/images/2017-09-10_adhs-tron/8.jpg' alt_text='pic 8' caption='Designing and soldering the perfboard' width='49%' float='right'  clear='yes'%}

{% include thumb.html filename='/images/2017-09-10_adhs-tron/9.jpg' alt_text='pic 9' caption='The almost finished perfboard' width='49%' float='left'  %}
{% include thumb.html filename='/images/2017-09-10_adhs-tron/10.jpg' alt_text='pic 10' caption='Perfboard flipside' width='49%' float='right' clear='yes' %}

{% include youtube.html id="JBsHow5AMUg" clear_before='yes' %}

Features presented in order of appearance (If unpatient skip to 2:30 for some acidish sounds)
* Filter cutoff and resonance controlled locally
* Filter cutoff controlled via MIDI CC (pink line), resonance locally
* LFO modulating filter cutoff, amount and rate controlled locally

additional features not shown here
* Filter cutoff controlled via MIDI velocity
* LFO controlled via MIDI CC

{% include thumb.html filename='/images/2017-09-10_adhs-tron/11.jpg' alt_text='pic 11' caption='Happy outdoor hacking' width='49%' float='left' %}
{% include thumb.html filename='/images/2017-09-10_adhs-tron/12.jpg' alt_text='pic 12' caption='Designing the final layout of the control elements' width='49%' float='right' clear='yes' %}

{% include thumb.html filename='/images/2017-09-10_adhs-tron/13.jpg' alt_text='pic 13' caption='The final cardboard prototype' width='49%' float='left' %}
{% include thumb.html filename='/images/2017-09-10_adhs-tron/14.jpg' alt_text='pic 14' caption='Inside the prototype, trying to fit the cables in the case...' width='49%' float='right' %}

{% include thumb.html filename='/images/2017-09-10_adhs-tron/15.jpg' alt_text='pic 15' caption='Drilling the case' width='49%' float='left' %}
{% include thumb.html filename='/images/2017-09-10_adhs-tron/16.jpg' alt_text='pic 16' caption='Mounting the control elements' width='49%' float='right' %}

{% include thumb.html filename='/images/2017-09-10_adhs-tron/17.jpg' alt_text='pic 17' caption='ADHS-Tron ready to roll!' width='49%' float='left' %}
{% include thumb.html filename='/images/2017-09-10_adhs-tron/18.jpg' alt_text='pic 18' caption='After a couple of gigs, Tron still rolling!' width='49%' float='right' clear='yes'%}

Get the final code to this project here: [github.com/joj0/adhs-tron](https://github.com/joj0/adhs-tron). Feel free to fork, send issues and so on!
