sketchy-see
===========

A sketchy interactive evolutionary architecture project. 

The aim is to try to use interactive evolution in a way that is more
similar to the "sketchy" process used by real designers and
architects: instead of attempting to evolve all the components and
details from the get-go, we allow the user to specify how much detail
to fill in at each stage. So there are two main actions: evolving, ie
searching, in the current level of detail; and developing the designs
found so far by adding detail.

So far, we have a simple genetic algorithm and a tiny WebGL demo
running on the same page. To build:

$ cake build

To see the demo:

$ python -m SimpleHTTPServer

Then visit localhost:8000/public.

Copyright 2011-2012 James McDermott and Caitlin Mueller
