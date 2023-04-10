# dexter-cl
## Dexter - A toolkit for INDEX in Common Lisp

INDEX is the INcompatible Desktop Environment for X.

Dexter is a widget toolkit, also for X.

Eventually I'll write what's needed to allow declarative GUI programming. Very roughly, a file selector dialog might look something like this:

        (dialog-window
          (vbox
            (hbox
              (listbox "Favorites")
              (listbox "Files"))
            (hbox
              (spacer)
              (button :label "Cancel")
              (button :label "OK"))))

Well before I can do that, I need to implement the controls etc. that are to be declared. As it stands, I've only written enough to sort of do this:

        (application
          (window :title "Bar")
          (window :title "Quux"))

Not in a declarative fashion though.

I have in mind to do something like implementing Apple's UIKit in Common Lisp. I've always heard praise for how well done OpenStep was, so I figure that's a good guide. I've never used either, so it's taking some time.

X11 is the only target environment for now. Dexter will use the "globally active input model" described in the ICCCM. Really, its main purpose is to show how that's supposed to work. A suite of Dexter apps could be used without a window manager and the typical Windows or Mac user would notice nothing amiss. With the right kind of window manager, Dexter apps will be more capable than Windows apps and as capable as Mac apps. Where X apps (and Windows apps) often fall short is in their support for drag and drop. Mac, unlike other click-to-focus environments, lets you drag an item from a background window without raising that window above all the others. Dexter, with the right window manager, will make that possible on X.



## Older Write-up
~~I've barely started writing this. It will probably be similar to OpenStep, but hardly anything is determined. The files in here now are just me getting familiar with CLX, Roswell, asdf, etc.~~

Some progress has been made. I'm using Roswell with SBCL on Debian. I'm using OpenStep as a guide, though I'm mostly working from Apple's documenation for AppKit and UIKit.

CLX is a beast. I can imagine myself writing an entirely new interface to X11 one day. Maybe the choices made sense for things in the 1980s, but I don't think they make sense anymore. Still, I'm don't know Lisp well enough to start on that journey.

While dexter-cl will be written in Common Lisp, using CLX, I may write the same toolkit in a few other langauges using each language's basic X11 library. I'm equally unfamiliar with how to do this in any language, despite being able to read and write a few. I'm mostly out of practice and meanwhile busy with my day job, where I use LabVIEW most.

If I should decide to target any platform other than X, I expect I'll name the abstraction layer "Dee Dee".
