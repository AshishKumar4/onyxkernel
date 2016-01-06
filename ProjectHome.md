# Project Information #
&lt;wiki:gadget url="http://onyxkernel.googlecode.com/svn/wiki/adsense.xml" height="60" width="468"/&gt;

Kryos is the name for the latest version of the Onyx Kernel implementation

June 10, 2009 - Version 1.5 Stable Release source code has been put up on the downloads page. You can find the binary in the /bin folder, as usual. I'll try to work on Kryos/Onyx some more, but I need to get my new computer set up for compiling (ugh re-doing cross compilers and cygwin and the works)


---

### Recent News: ###
Version 1.5 Stable Release (Test):

New Kryos Version 1.5 SR! Not many aesthetic updates since v1.3 sr4, but some new TaskAPI functions have been updated or added. Executable files written in assembly and conforming to the Kryos-exe format can be loaded through a GRUB boot module. I'll try and do some work this summer, as I release it's been almost a year since I did a minor, let alone a major update.

Version 1.3 Stable Release 4:

I have just uploaded Kryos Version 1.3 Stable Release 4 to the downloads tab. Both Zip and  Tar/Bz2 archives will be up right after I post this. A lot of things have happened since I transformed Phoenix OS into Kryos. An almost complete source code re-write, a ton of added features and a whole lot more. I've tested it in Bochs, Virtual PC 2008 and on a Pentium 4 real computer, and none of them have crashed, so I named it the Stable Release. Basically, I've included libc.a (has puts(), putc(), and die() for now), and will add more to that later. Paging works now, so does basic relocation (working on ELF). Shell works again, haven't tested hard drive code on a real PC yet, so who knows? Basically, I can say it's a basic, functional text-based Operating System.

### Description: ###

About Kryos:
Kryos is an open source hobby/developer Operating System based on the Onyx Kernel. Kryos has a basic command line interface (cli),and can load standalone executable files.

About Onyx:
Onyx is an open soure kernel written in a combination of C and Intel 8086 (x86) assembly. Currently, Onyx is aimed at running on the x86 architecture.

### Features: ###
  * Multiboot Compliant
  * Virtual Memory Managing
  * Error Fault Handling
  * Software Multitasking (Ring 0)
  * System Calls
  * System Debugger
  * Command line shell
  * Built-in set of drivers, such as:
  * Text Mode Video Driver
  * VGA Mode 13h Driver
  * Keyboard Driver
  * Serial Port Driver
  * LBA28 Hard Disk Read/Write Driver
  * 100% Open Source and Free!

### Short Term Goals: ###
  * ~~Software Multitasking~~
  * ~~Fix a few text console issues~~
  * Mouse Driver
  * VGA Bitmap Fonts
  * ~~Module/Executable File Loading~~
  * Filesystem

### Resources: ###
  * [OS Development Wiki & Forums](http://www.osdev.org)
  * [OS Development Tutorials](http://www.osdever.net)
  * [Intel IA-32 Manuals](http://www.intel.com/products/processor/manuals/index.htm)

&lt;wiki:gadget url="http://onyxkernel.googlecode.com/svn/wiki/adsense.xml" height="60" width="468"/&gt;