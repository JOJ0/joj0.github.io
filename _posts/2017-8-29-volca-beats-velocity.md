---
layout: post
title: Volca Beats learns MIDI Velocity
comments: true
last_modified_at: 2018-02-23 
---

Out of the box the Volca Beats is not velocity sensitive, neither when triggered via MIDI, nor when using the onboard 16-step sequencer. 

I was not happy when I found this out and immediately tried to work around the problem. What the Beats _does_ understand is altering the volume of the different drum parts via a MIDI Control Change (CC) message. This is Korg&#39;s official [MIDI implementation chart](http://i.korg.com/uploads/Support/USA_volcabeats_MIDI_Chart_E.pdf)

So these are the CC numbers controlling the volume levels

~~~
PART LEVEL KICK     40
PART LEVEL SNARE    41
PART LEVEL LO TOM   42
PART LEVEL HI TOM   43
PART LEVEL CL HAT   44
PART LEVEL OP HAT   45
PART LEVEL CLAP     46
PART LEVEL CLAVES   47
PART LEVEL AGOGO    48
PART LEVEL CRASH    49
~~~

My first idea was to just use automation in my MIDI clips to alter the notes&#39; volume when controlling it out of Ableton Live. Let&#39;s take e.g. a simple closed hihat pattern, where you just want to lower the volume of every other note. You would draw an automation line for CC 44 that looks similar to the following. Note that reducing the CC's value has to always be done _before_ a note is played.

~~~
+---------+         +---------+         +---------+         +---------+
          |         |         |         |         |         |         |
          |         |         |         |         |         |         |
          +---------+         +---------+         +---------+         +-------+
                                                                               
   ++         ++        ++        ++         ++        ++        ++       ++
   +--+       +--+      +--+      +--+       +--+      +--+      +--+     +--+
   |  +       |  +      |  +      |  +       |  +      |  +      |  +     |  +
   |          |         |         |          |         |         |        |
   |          |         |         |          |         |         |        |
+--+       +--+      +--+      +--+       +--+      +--+      +--+     +--+
|  |       |  |      |  |      |  |       |  |      |  |      |  |     |  |
+--+       +--+      +--+      +--+       +--+      +--+      +--+     +--+
~~~

Alright, drawing velocity with an automation line ranges in the top 5 of the most tedious thing I have ever done in Ableton Live so let's gently call this approach rather unsatisfying and let it go...and yes, instead of drawing this beautiful piece of ASCII-art, I just could have presented a screenshot of my automation line in Live but I am not willing to search for it in my projects and certainly won't draw a new one ;-)

Next idea was to use the Freeware MIDI manipulation software [MidiPipe](http://www.subtlesoft.square7.net/MidiPipe.html) and just translate each notes velocity value to a newly generated CC message. The values of these two types of MIDI messages generally range from 0 to 127, so this should work out without any complicated maths magic.

![MidiPipe pic1](http://www.subtlesoft.square7.net/MidiPipe_files/shapeimage_1.png)

MidiPipe works like this: You put togehter an input, a couple of modules and an ouptut. A MIDI messages flows through one module after the other from top to bottom until it reaches an output which in my case would be the MIDI port the Volca is connected to. For more details click above link to MidiPipe's homepage. There are quite a lot of types of modules that are able to translate, manipulate or even remove messages but they all didn't manage to solve my problem. One of the main reasons was the lack of being able to generate a new message according to values I got from another message.

There was only one module left that could help me: MidiPipe's "AppleScript Trigger" module and manipulate the messages myself. So let's recall what needs to be done:

  * midi note message coming in (e.g. kick drum: note #36)
  * read its velocity value (e.g. 100)
  * generate new CC message with correponding number and value (e.g. kick drum level: CC #40, value 100)
  * send CC message to output
  * now that the volume is set, send note to output too

I couldn't find a way to code this all into one AppleScript so my solution looks like this. The right half of MidiPipe's window shows the modules the messages are flowing through:

![MidiPipe0 ](/images/2017-8-29_volca-beats-velocity/MidiPipe0.png)

The settings of the modules in detail:
{% comment %}
{% include figure.html filename='/images/2017-8-29_volca-beats-velocity/MidiPipe1.png' alt_text='MidiPipe1' caption='' width="49%" float="left" %}
{% endcomment %}

![MidiPipe1 ](/images/2017-8-29_volca-beats-velocity/MidiPipe1.png)
![MidiPipe2 ](/images/2017-8-29_volca-beats-velocity/MidiPipe2.png)
![MidiPipe3 ](/images/2017-8-29_volca-beats-velocity/MidiPipe3.png)
![MidiPipe4 ](/images/2017-8-29_volca-beats-velocity/MidiPipe4.png)
![MidiPipe5 ](/images/2017-8-29_volca-beats-velocity/MidiPipe5.png)
![MidiPipe6 ](/images/2017-8-29_volca-beats-velocity/MidiPipe6.png)
![MidiPipe7 ](/images/2017-8-29_volca-beats-velocity/MidiPipe7.png)
![MidiPipe8 ](/images/2017-8-29_volca-beats-velocity/MidiPipe8.png)
![MidiPipe9 ](/images/2017-8-29_volca-beats-velocity/MidiPipe9.png)

The AList modules are for debugging, they show how the MIDI messages look like at the current point in the pipe.

This is the first AppleScript:
~~~
# translate note to CC

# comment out for debugging from AppleScript editor
#runme({144, 43, 100})

on runme(message)
  #set message to {144, 36, 100}
  #Kick,Snare,LoTom,HiTom,ClHat,OpHat,Clap,Claves,Agogo,Crash
  set note_list to {36, 38, 43, 50, 42, 46, 39, 75, 67, 49}
  set CC_list to {40, 41, 42, 43, 44, 45, 46, 47, 48, 49}
  set cnt to 1
  repeat with note_no in note_list
    if (((item 1 of message) ≥ 144) and (item 2 of message) is (note_no as integer)) then
      # returns 0 for channel 1, 1 for channel 2, etc.
      set channel to ((item 1 of message) mod 16)
      # 176 is CC on channel 1  
      set first_byte to (channel + 176)
      set CC_no to (item cnt of CC_list)
      set CC_val to (item 3 of message)
      #display dialog "note to CC -> ch:" & channel + 1 & ¬
        " note_no:" & note_no & " CC_no:" & CC_no & " cnt:" & cnt
      set (item 1 of message) to first_byte
      set (item 2 of message) to CC_no
      set (item 3 of message) to CC_val
      # we found the note_no and translated to CC, nothing else to do
      exit repeat
    end if
    set cnt to (cnt + 1)
  end repeat
  return message
end runme
~~~

And this is the second one:
~~~
# translate CC back to note

# comment out for debugging from AppleScript editor
#runme({176, 40, 100})

on runme(message)
  #set message to {144, 36, 100}
  #Kick,Snare,LoTom,HiTom,ClHat,OpHat,Clap,Claves,Agogo,Crash
  set note_list to {36, 38, 43, 50, 42, 46, 39, 75, 67, 49}
  set CC_list to {40, 41, 42, 43, 44, 45, 46, 47, 48, 49}
  set cnt to 1
  repeat with CC_no in CC_list
    #display dialog (item 2 of message)
    if ((item 1 of message) ≥ 176 and (item 2 of message) is (CC_no as integer)) then
      # returns 0 for channel 1, 1 for channel 2, etc.
      set channel to ((item 1 of message) mod 16)
      # 144 is Note-On on channel 1 
      set first_byte to (channel + 144)
      set note_no to (item cnt of note_list)
      set note_val to (item 3 of message)
      #display dialog "CC to note -> ch:" & channel + 1 & ¬
        " note_no:" & note_no & " CC_no:" & CC_no & " cnt:" & cnt
      set (item 1 of message) to first_byte
      set (item 2 of message) to note_no
      set (item 3 of message) to note_val
      # we found the CC_no and translated to note, nothing else to do
      exit repeat
    end if
    set cnt to (cnt + 1)
  end repeat
  return message
end runme


~~~

In your DAW you now have to send the output of the MIDI track you use for triggering the Volca to "Midi Pipe Input1".

In MidiPipe set the two "Midi Out" modules to the port your Volca is connected to. 

So far it doesn't seem all this introduces latency that delay your drum hits noticeably. I even sometimes use it for live finger drumming.

If you find a way to code this all into one script or even solve the message manipulation without AppleScript, just using a combination of MidiPipe's other modules, please leave a comment!

Another idea would be to solve this with a nice Max4Live device. Anybody?



