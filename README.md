# NHSBugs.net

NHS Bugs is a fault tracking system for issues within the NHS, both within primary and secondary care.  Fault reports are received from both patients and NHS staff and then are hopefully resolved after notification by the system.


## Installing

Installing NHSBugs should be reasonably straight forward for development, the steps should currently consist of checking out the project from github and then…

```shell
pip install -r requirements.txt
./manage.py syncdb
./manage.py runserver
```

And then open your browser and point to 0.0.0.0:8000

