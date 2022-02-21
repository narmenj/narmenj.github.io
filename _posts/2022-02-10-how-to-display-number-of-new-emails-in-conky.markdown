---
layout: post
title: "نمایش تعداد ایمیل‌های جدید در کانکی"
date: 2022-02-10 17:21:05 +0330
excerpt_separator: <!--more-->
categories:
 - linux
---
برای این که در کانکی تعداد ایمیل‌های جدید را ببینیم، ابتدا فایلی با محتوای زیر و با نام دلخواه مثلا `checkmail.py` میسازیم: (یوزرنیم و پسورد خود را در آن جایگزین میکنیم)
<!--more-->
```python
#!/usr/bin/env python3
import imaplib
import re

# Enter your account details:
imapServer = "imap.gmail.com"
port = "993"
username = "username@gmail.com"
password = "password"
#
Mailbox = imaplib.IMAP4_SSL(imapServer, port)
rc, resp = Mailbox.login(username, password)
if rc == "OK":
    print("Connected to", imapServer)
    rc, message = Mailbox.status("INBOX", "(UNSEEN)")
    unreadCount = int(re.search("UNSEEN (\d+)",str(message[0])).group(1))
    f = open("/tmp/mailnotify.txt", "w")
    f.write(str(unreadCount))
    f.close
else:
    print("Connection failed!")

Mailbox.logout()
```  
همانطور که مشخص است این اسکریپت پایتون، تعداد ایمیل‌های جدید را در فایلی در مسیر `/tmp/mailnotify.txt` ذخیره میکند.  
احتمالا نیاز خواهید داشت تا تنظیماتی در اکانت جیمیل‌تان انجام دهید تا این اسکریپت بدرستی کار کند و در  هنگام لاگین شدن به سرور گوگل، خطا ندهد.  
پس به [این آدرس](https://myaccount.google.com/lesssecureapps){:target="_blank"} رفته و اجازه دسترسی را روشن کنید.  
برای اینکه اسکریپت بالا هر پنج دقیقه اجرا شود و ایمیل‌های جدید را نشان دهد باید آن را به `cron` اضافه کنیم. برای این کار هم دستور پایین را زده:
```console
$ crontab -e
```  
و خط زیر را به آن اضافه میکنیم:
```conf
*/5 * * * *  /path/to/checkmail.py
```  
حالا فقط باید  تغییراتی در فایل کانفیگ کانکی بدهیم. برای این کار آن را باز کرده و چیزی شبیه به این را به آن اضافه میکنیم:
```conf
 Mail ${execpi 300 cat /tmp/mailnotify.txt}
 ```  
و تمام /:
