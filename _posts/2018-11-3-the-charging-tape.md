---
layout: post
title: The Charging Tape
comments: true
published: 2018-12-14
image: /images/2018-11-3-the-charging-tape/IMG_5209-th.jpg
draft: true
---

Alright, let's do something boring: Building a battery charger. So why would you do that? I dont't have any idea, just go buy one! ;-) But apparently I had a reason to build one myself:

Some time ago I built a couple of rechargeable micro-battery-packs which are featured in [this post]({% post_url 2017-7-6-das-adhs %})<br>After trying to load one of them with an old NiCd fast-charger I learned the hard way how my batteries actually look from the inside:

pics explosion

Don't try this at home kids! 

So far so good, fortunately I didn't burn my flat so I decided that I have to either buy or build a charger that is designed to charge 
Nickel-Metal-Hybrid (NiMh) batteries with very little cappacity (measured in mAh - milliamphours FIXME)

### What you always wanted to know about batteries

First off, my tiny knobcell (FIXME) accus have the following specs:

  * 1,2 V (exactely the same as normal AA, AAA, etc. rechargable batteries;
    this value is nominal, in reality most accus have a little more, something like 1,3 to 1,45 when fully charged) 
  * 80mAh capacity

In short: They are ordinary rechargeable batteries and it actually should be save to load them with an ordinary charger.

So why did my test-candidate explode then?

It was simply overcharged. NiMh cells are designed to be only fast-charged until they reach their full capacity. After that, keeping them connected to high current results in a lot of heat and...you saw the pics.

So either the charger has thermal sensors to shut off before overheating or it just uses low current the cell can stand for a longer time duration.

Sensoring seemed difficult so I decided to build a low current charger.

A safe current is 1/10 of its capacity (1/10 C). In my batteries case this would be 1/10*80=8mA. There you have it, no affordable charger on the market seems to handle such a low current. Typically chargers go as low as 150mA, which is fine for typical batteries which have a capacity of 1500mAh to 2500mAh (or even more), but not for my tiny 80mAh cells.

### Finding and customizing a design
<a name="finding"></a>

Some googling and studying charger designs brought up this forum thread. The schematic suggested by member Sgt.fixme seemed to be a perfect fit: link fixme

It features two regulators ICs: One limiting the current and the other one the voltage.

* Vc should be set slightly higher than the voltage of the fully charged battery pack. My two-cell packs got 2*1,35=2,7V so around 3 Volts should be fine.
* Ic (charging current) as already discussed above, not more than 8mA

I decided to use LM317 ICs. They are common and easy to get.

Fortunately the design already handles V for two-cell packs and it can be fine tuned using the trim-pot. 

I is set by resistor Ri fixme (He uses 2 identical resistors in parallel to split the current and not have to use an R that can stand higher power (more Watts), I will use just one R as my current is very little).




two thumbs included here:

<div class="clearfix">
{% include thumb.html filename='/images/2017-9-24-das-adhs/IMG_5308.jpg' alt_text='' caption='' width="49%" float="left" %}
{% include thumb.html filename='/images/2017-9-24-das-adhs/IMG_5310.jpg' alt_text='' caption='apostroph example wasn&#34;t' width="49%" float="right" %}
</div>
<br>

youtube video here:

{% include youtube.html id="xg1r3PN7qE8" width="100%" %}
text under youtube video
<br><br>

photogallery here (collection has to be createdi first):

<div class="photo-gallery-frame clearfix">
  <ul class="photo-gallery-list">
    {% for photo in site.das-adhs %}
    <li>
      <a href="{{ photo.url | prepend: site.baseurl }}" name="{{ photo.title }}">
        <img src="{{ photo.image-path|remove: ".jpg"| append: '-th'|append: ".jpg" }}" alt="{{ photo.caption }}" />
      </a>
    </li>
    {% endfor %}
  </ul>
</div>

### Materials

blabla getting stuff

[link 1](https://www.musikding.de/20-Pin-inline-socket)<br>
[link 2](https://www.musikding.de/10-Pin-strip)<br>
