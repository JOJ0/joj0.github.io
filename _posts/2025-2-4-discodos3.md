---
layout: post
title: DiscoDOS sells 3 times pretty
comments: true
published: 2025-03-07
image: /images/2025-2-4-discodos3/shot01.jpg
draft: false
---

It sells your records on the Discogs Marketplace - and looks darn good doing it!

Of course you should [read the project description](https://github.com/JOJ0/discodos/blob/master/README.md) to understand what this software even is. Of course you should read release notes for [3.0](https://github.com/JOJ0/discodos/releases/tag/v3.0) and [3.1](https://github.com/JOJ0/discodos/releases/tag/v3.1.0) to learn its latest features. Of course you should head straight to the [quickstart guide](https://discodos.readthedocs.io/en/latest/QUICKSTART.html), to see how to use it.....but why not only stare at all these tiny pink television screens and enjoy the show - DiscoDOS your _Disco Operator Softie_ loves you! <3

<a name="chapter_1"></a>

## Gif Love

<div class="photo-gallery-frame clearfix">
  <ul class="photo-gallery-list">
    {% for photo in site.discodos3 %}
    <li>
      <a href="{{ photo.url | prepend: site.baseurl }}" name="{{ photo.title }}">
        <img src="{{ photo.image-path }}" alt="{{ photo.caption }}" style="width: 31%" />
      </a>
    </li>
    {% endfor %}
  </ul>
</div>

## Screenshot Love

{% include thumb.html filename='/images/2025-2-4-discodos3/shot01.jpg' width="100%" float="none" margin="0" %}

<div style="display: block; text-align: center;">
{% include thumb.html filename='/images/2025-2-4-discodos3/shot02.jpg' width="60%" float="none" margin="0" misc_style="display: inline-block;" %}
</div>

{% include thumb.html filename='/images/2025-2-4-discodos3/shot03.jpg' width="100%" float="none" margin="0" %}


## This is for you?

- [Quickstart](https://discodos.readthedocs.io/en/latest/QUICKSTART.html)
- [Website / Roadmap](https://discodos.jojotodos.net)
