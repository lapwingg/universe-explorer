# Universe Explorer
[![Build Status](https://travis-ci.com/lapwingg/universe-explorer.svg?branch=master)](https://travis-ci.com/lapwingg/universe-explorer)
[![codecov](https://codecov.io/gh/lapwingg/universe-explorer/branch/master/graph/badge.svg)](https://codecov.io/gh/lapwingg/universe-explorer)
[![codebeat badge](https://codebeat.co/badges/9831c129-6f38-4956-bf09-0c6c00179524)](https://codebeat.co/projects/github-com-lapwingg-universe-explorer-master)
[![Swift 4.2](https://img.shields.io/badge/Swift-4.2-orange.svg?style=flat)](https://swift.org/)

When you are looking into sky, do you feel that you want to discover places outside the your eyesight range? Now it is possible using your device!

Start new day watching one interesting photo from the Earth or galaxy with exhaustive description. 

If it isn't enough for you, you can watch previous Picture Of The Day. To do it, tap "Search by date", select any previous day and wait a moment.
 
Have you ever dreamt about visiting the Mars? Now you can do it using your device. Open second tab, and explore the Red Planet.

Do you want to save these stunning photos? No problem. Tap at concrete photo if you are using Mars Photos mode or click at "Add to favourite" if you are using Picture of The Day mode. 

But you should be careful. Probably your photo can be in favourite. If you are seeing "Delete from favourite", you shouldn't click there because you can delete photo from favourite. Remember about it.

Do you interest in which asteroids are the closest our planet right now? Run third tab and check. If flying object is hazardous to us, it is selected as red.

Last one, but probably the best tab - Favourite Photos. In this place you can look again at the best in your opinion pictures from Picture Of The Day and Mars Photos. 

Rename them as you wish, pressing long in place where is old name. Or swipe left to remove, if you don't want its to see anymore.

## Screens
<a href="https://ibb.co/b1P1kpb"><img src="https://i.ibb.co/Y232xv0/Screen-Shot-2019-06-26-at-1-01-29-PM.png" alt="Screen-Shot-2019-06-26-at-1-01-29-PM" border="0"></a>

<a href="https://ibb.co/82GTRTd"><img src="https://i.ibb.co/hHrhnhZ/Screen-Shot-2019-06-26-at-1-05-25-PM.png" alt="Screen-Shot-2019-06-26-at-1-05-25-PM" border="0"></a>

<a href="https://ibb.co/N6SWfp3"><img src="https://i.ibb.co/7J4rBVz/Screen-Shot-2019-06-26-at-1-06-33-PM.png" alt="Screen-Shot-2019-06-26-at-1-06-33-PM" border="0"></a>

<a href="https://ibb.co/vV54cs8"><img src="https://i.ibb.co/34XmTfH/Screen-Shot-2019-06-26-at-1-07-45-PM.png" alt="Screen-Shot-2019-06-26-at-1-07-45-PM" border="0"></a>

<a href="https://ibb.co/98gjWw2"><img src="https://i.ibb.co/Fx3tzsJ/Screen-Shot-2019-06-26-at-1-08-34-PM.png" alt="Screen-Shot-2019-06-26-at-1-08-34-PM" border="0"></a>

<a href="https://ibb.co/JkgRFWm"><img src="https://i.ibb.co/f0LYGVq/Screen-Shot-2019-06-26-at-1-09-29-PM.png" alt="Screen-Shot-2019-06-26-at-1-09-29-PM" border="0"></a>

<a href="https://ibb.co/CKft7Z5"><img src="https://i.ibb.co/k2ty8fg/Screen-Shot-2019-06-26-at-1-10-07-PM.png" alt="Screen-Shot-2019-06-26-at-1-10-07-PM" border="0"></a>

<a href="https://ibb.co/1665dC9"><img src="https://i.ibb.co/k11f9Lh/Screen-Shot-2019-06-26-at-1-11-08-PM.png" alt="Screen-Shot-2019-06-26-at-1-11-08-PM" border="0"></a>

<a href="https://ibb.co/VpXHvc6"><img src="https://i.ibb.co/84FzjLk/Screen-Shot-2019-06-26-at-1-11-59-PM.png" alt="Screen-Shot-2019-06-26-at-1-11-59-PM" border="0"></a>

## Limitation
Application uses [NASA API](https://api.nasa.gov/index.html). It is a non-commercial use so after 1000 response per hour - server won't be response by the next hour.

## External libraries
Project uses [JTAppleCalendar](https://github.com/patchthecode/JTAppleCalendar) and [SQLite.swift](https://github.com/stephencelis/SQLite.swift).
Thank for the authors of these libraries for their work!

## How to run
1. Install ruby if you don't have already

2. Install cocoapods if you don't have already ```gem install cocoapods```

3. Install pods ```pod install``` 

4. Open ```asteroids.workspace```project using XCode 

5. Run ```asteroids``` scheme or ```asteroidsTests``` if you want to testing application
