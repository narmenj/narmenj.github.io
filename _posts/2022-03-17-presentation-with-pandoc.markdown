---
layout: post
title: "ارائه تحقیق و مقاله در لینوکس"
date: 2022-03-17 15:26:27 +0330
excerpt_separator: <!--more-->
categories:
 - linux
tags:
- linux
- pandoc
- beamer
- presentation
- pdf
- md
- markdown
- font
- bilingual
- terminal
- office
- libreoffice
- powerpoint
- لینوکس
- پانداک
- ارائه
- پی دی اف
- مارک داون
- فونت
- دو زبانه
- خط فرمان
- آفیس
- پاورپوینت
---
برای ارائه تحقیق و مقالات در لینوکس بدون اینکه نیاز به برنامه‌هایی مثل `LibreOffice` داشته باشیم و فقط با استفاده از کیبورد و خط دستور، از برنامه همه کاره `pandoc` استفاده می‌کنیم. چرا همه کاره! چون با پانداک میتوانید فرمت‌های مختلف اسناد را براحتی به یکدیگر تبدیل کنید.  
<!--more-->
البته برای اینکه فایل ارائه‌مان، تم هم داشته باشد به ابزار دیگری بنام `beamer` هم نیاز داریم
بعد از نصب `pandoc` و `beamer` فقط لازم است فایل مقاله یا تحقیقمان را در قالب `markdown` نوشته و آن را تبدیل به `pdf` کنیم.  
فایل نمونه:
{% highlight markdown linenos %}
---
dir: rtl
mainfont: BNazanin
header-includes:
- \newfontfamily\englishfont{Arial}
title: ارائه در لینوکس
author: رضا رها
theme: Copenhagen
colortheme: spruce
date:
- پنجشنبه 26 اسفند 1400
---
# اسلاید 1
## لیست  
1. آیتم اول
2. آیتم دوم
3. آیتم سوم

# اسلاید 2
## لیست
- آیتم اول
- آیتم دوم
- آیتم سوم

# اسلاید ۳

**متن بولد**  
*متن ایتالیک*  
~~متن خط خورده~~  


# [English]{lang=en}
متن انگلیسی /: [This is a test !]{lang=en}

# اسلاید آخر
تصویر  
![sample picture](desktop.png)
{% endhighlight %}  
:bulb: در صورتی که از فونتی استفاده میکنید که کاراکترهای فارسی و انگلیسی را با هم دارد نیازی به افزودن خطوط ۴ و ۵ نیست. همچنین میتوانید خطوط انگلیسی را عادی و بدون نیاز به فرمت بالا(خطوط 32 . 33) تایپ کنید.  
با دستور پایین آن را به `pdf` تبدیل میکنیم:
```console
$ pandoc --pdf-engine=xelatex -t beamer sample.md -o sample.pdf
```  
[لیست](https://mpetroff.net/files/beamer-theme-matrix/){:target="_blank"} تم‌ها و رنگبندی‌های بیمر  
[این](https://mega.nz/file/12h0CKwI#V-LTJ5ogrcOtLUpkLakmMDegwwrfn0nQDRSEv0qiF4I){:target="_blank"} هم نتیجه کار