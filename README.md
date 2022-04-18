# dexter-cl
A toolkit for INDEX in Common Lisp

INDEX is the INcompatible Desktop Environment for X.

Dexter is a widget toolkit.

--I've barely started writing this. It will probably be similar to OpenStep, but hardly anything is determined. The files in here now are just me getting familiar with CLX, Roswell, asdf, etc.--

Some progress has been made. I'm using Roswell with SBCL on Debian. I'm using OpenStep as a guide, though I'm mostly working from Apple's documenation for AppKit and UIKit.

CLX is a beast. I can imagine myself writing an entirely new interface to X11 one day. Maybe the choices made sense for things in the 1980s, but I don't think they make sense anymore. Still, I'm don't know Lisp well enough to start on that journey.

While dexter-cl will be written in Common Lisp, using CLX, I may write the same toolkit in a few other langauges using each language's basic X11 library. I'm equally unfamiliar with how to do this in any language, despite being able to read and write a few. I'm mostly out of practice and meanwhile busy with my day job, where I use LabVIEW most.

If I should decide to target any platform other than X, I expect I'll name the abstraction layer "Dee Dee".