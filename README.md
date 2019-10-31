# Generate ADT decoders


## Scripts for ADT in KMH

These are the scripts used to generate the faust source code using ADT. To use this you need to install ADT and MatLab/Octave.

See the info in the beginning of the Makefile, but basically the order, array and function can be specified in the call to make: `make -k ls function=6 order=3 array=normal`.

The KMHXXX\_AE.m contain the speaker positions.


### Compiling the decoders

This is only if you wish to tweak the settings in any way. Compiled decoders may be found here:

-   <https://github.com/friskgit/kmh_ls>
-   <https://github.com/friskgit/kmh_108>
-   <https://github.com/friskgit/kmh_114>

In order to compile the decoders there are a number of dependencies that need to be resolved:

-   ADT (Ambisoncs Decoder Toolkit)
-   Faust
-   VST SDK
-   Pure Data
-   Max MSP SDK
-   Links to Supercollider classes

-   Running Makefile scripts for ADT

    Run the following for each function that needs to be compiled for lilla salen (108\_all and 114\_all for the studios):
    
    `$ make ls_all function=6`
    
    Note that for fuction 2 & 4 only orders up to 3 are usable.
    
    The decoding matrices end up in a directory above your current directory named 'decoders'. Move into that directory with the following command:
    
    `$ cd ../decoders`
    
    With the decoding matrices calculated the binary decoders for all orders can be compiled by
    
    `$ make -k target=all all`
    
    The target can be either of [all,sc,max,pd,vst]. Following this step the binaries can be installed (to install only one target, use that as the argument for 'target'.:
    
    `$ make -k target=install all`
