---
layout: page
title: Latest Posts
---

<ul>
{% for post in site.posts  %}

{% if post.draft == true %}
{% else %}
    <li class="pv2">
    <a href="{{ post.url }}">{{ post.title }}</a><br><span class="f6 ttu black-50 pv3">{{ post.date | date: "%-d %B %Y" }}</span>
    </li>
    {% endif %}
    {% endfor %}
    </ul>
