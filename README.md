# Verification of CCS-processes
####    a M.Sc. thesis by Michael Hillerström
<div style="margin: 1cm 0 0 0">

This repository contains the full source for my thesis work including working
code, examples, and extractor utilities.

The material herein is an author re-type with very few changes from the
original. Only some mis-spellings and missing punctuation marks, corrected
indices etc. Also, all pictures have been redrawn using LaTeX picture
environment.

_I did not even correct my (obvious) mistake in the conclusion - can you spot
it?_

Enjoy!
<div style="margin: 3cm 0 0 0">

# It's been dockerized!

Well, as time goes by, the tools evolve, but the `LaTeX` source does not.
Therefore, I updated this repository to use `Docker` for composing the resulting
PDF.

Should you want too try it out, you need to have `Docker` installed on your
machine. Then you simply execute the command:

```sh
make
````

the the magic will start.

> __PLEASE NOTE:__ the example `ex21.pl` takes several minutes to run so be
> patient! The full process can take up to 6 minutes (or more) on the first run

## Other information

### VS Code remote container

If you have installed the VS Code Remote Container extension you can run a
(semi-)interactive session. Please refer to VS REmote Container extension for
further information.

### Other commands

The command

```sh
make help
```

gives a hint of what is possible and the command

```sh
make clean
```

removes all auxilliary files from the directory.
