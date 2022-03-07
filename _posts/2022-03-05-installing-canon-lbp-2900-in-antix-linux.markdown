---
layout: post
title: "نصب پرینتر lbp2900 در antiX linux 21"
date: 2022-03-05 20:00:43 +0330
excerpt_separator: <!--more-->
categories:
 - linux
tags:
- linux
- printer
- antiX
- 32
- bit
- driver
- lbp2900
- canon
- cups
- capt
- debian
- daemon
- service
- captstatusui
- print
- لینوکس
- پرینتر
- کنون
- دبیان
- دیمن
- پرینت
- بیت
---
در دبیان‌۱۱ نسخه ۳۲ بیتی، بسته libcupsys2 دیگر وجود ندارد و از آنجا که درایور پرینتر lbp2900، در هنگام نصب بسته ذکر شده را جستجو میکند و در صورت نصب نبودن خطا میدهد و نصب درایور را لغو میکند باید جراحی کوچکی انجام داده تا بدون نیاز به این بسته کار نصب ادامه یابد. بعد از این جراحی و نصب درایور، `libcups2` جای `libcupsys2` را پر میکند و پرینتر بدرستی کار خواهد کرد.  
<!--more-->

برای شروع، `CUPS` را به همراه سایر نیازمندی‌های پرینتر، نصب میکنیم:
````console
$ sudo apt install cups libcups2 libcups2-dev ghostscript libxml2 libpopt0 Libpangox-1.0-dev
```  
سپس فایل درایور را [اینجا](https://mega.nz/file/Qy4g1Tha#_1mynZstA4JgLz8ucpW3jYLPQz5AS03UFowxq3o9asU){:target="_blank"} دانلود کرده و آن را از حالت فشرده خارج سازید.
#### تغییر در محتویات درایور
پس از استخراج فایل فشرده وارد پوشه زیر شوید:
```console
$ cd CAPT_Printer_Driver_for_Linux_V200_uk_EN/Driver/Debian/
```  
دو فایل در این مسیر وجود دارد:
```console
cndrvcups-capt_2.00-2_i386.deb
cndrvcups-common_2.00-2_i386.deb
```  
با دو دستور پایین محتویات فایل دوم را استخراج میکنیم:
```console
$ dpkg-deb -x cndrvcups-common_2.00-2_i386.deb common
$ dpkg-deb --control cndrvcups-common_2.00-2_i386.deb
```  
حالا باید دو پوشه جدید `common` و `DEBIAN` را ببینیم.  
وارد پوشه `DEBIAN` شده و فایل `control` را ویرایش میکنیم:
```console
$ cd DEBIAN
$ nano control
```  
خط ششم را ویرایش کرده، `cupsys` و `gs-esp` را حذف کرده، بجای آنها `libcups2` و `ghostscript` را قرار میدهیم و فایل را ذخیره میکنیم.  
فایل `preinst` را هم با دستور زیر خالی میکنیم:
```console
$ echo > preinst
```  
اکنون باید پوشه `DEBIAN` را به داخل پوشه `common` منتقل کنیم.  
تقریبا کار جراحی درایور تمام است و فقط باید دوباره آن را به پکیج قابل نصب تبدیل کنیم:
```console
$ dpkg -b common cndrvcups-common_2.00-2_i386.deb
```  
#### ادامه نصب
فایلی که در مرحله قبل ساختیم را به همراه فایل دیگر همراهش، نصب میکنیم:
```console
$ sudo dpkg -i cndrvcups-common_2.00-2_i386.deb
$ sudo dpkg -i cndrvcups-capt_2.00-2_i386.deb
```  
پرینتر را از نو راه می‌اندازیم:
```console
$ sudo service cups restart
```  
افزودن پرینتر و اجرای دیمن آن:
```console
$ sudo /usr/sbin/lpadmin -p LBP2900 -m CNCUPSLBP2900CAPTK.ppd -v ccp://localhost:59787 -E  
$ sudo /usr/sbin/ccpdadmin -p LBP2900 -o /dev/usb/lp0
$ sudo service ccpd start
```  
کار نصب درایور به پایان رسیده و حالا وضعیت پرینتر را بررسی میکنیم:
```console
$ captstatusui -P LBP2900
```  
اگر پیام `Ready to print` را دیدید، پرینتر بدرستی نصب شده! و اگر خطا داد دستور زیر را اجرا کنید و یا سیستم را دوباره راه‌اندازی کنید:
```console
$ sudo service ccpd restart
```  
اگر بعد از راه‌اندازی مجدد سیستم باز هم پرینتر کار نکرد یک بار دیگر دستور بالا را اجرا کنید.  
این روش برای من روی `antiX linux 32 bit` جواب داد |: