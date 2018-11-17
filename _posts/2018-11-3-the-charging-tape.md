---
layout: post
title: Template Blog Post
comments: true
published: 2019-01-01
image: /images/2018-11-3-the-charging-tape/IMG_5209.jpg
draft: true
---

Alright, let's do something boring: We are building a batter charger. So, why would you do that? I dont't have any idea why you would do that, I can just tell you why _I_ _had_ to do it:

Last year I built a couple of micro-accu-battery-packs which are featured in this post [link 1](https://www.musikding.de/20-Pin-inline-socket)<br> obviously the came without a charger. After trying to load them with a crappy old charger I found in my stash, I learned how NIMH batteries actually look from the inside the hard way:

pics explosion

Somebody usually now says: Don't try this at home kids!

So far so good, fortunately I didn't burn my flat so I decided that I have to either buy or build a charger that is designed to charge batteries with very little cappacity (measured in mAh, as you probably know)

### What you always wanted to know about batteries

So my tiny knobcell (FIXME) accus have the following specs:

  * 1,2 V (exactely the same as normal AA, AAA, etc. rechargable batteries)
    this value is nominal, in reality most accus have a little more, something like 1,3 to 1,45 when fully charged) 
  * 80mAh capacity

In short: it is an ordinary rechargeable battery and should be save to be loaded with an 



### Chapter 1

anchor to chump back to from thumbs and image galleries is here:

<a name="chapter_1"></a>

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
