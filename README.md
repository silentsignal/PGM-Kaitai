PGM Kaitai
==========

Kaitair structure definition for serialized IBM i (AS/400) `*PGM` objects.

Usage
-----

Download and install Kaitai Struct Compiler:

- http://kaitai.io/#download

Compile the structure to Python (or whatever language you prefer from Kaitai):

```
ksc -t python pgm.ksy
```

Now `pgm.py` is generated, you can use it like this:

```py
from pgm import Pgm
pgm = Pgm.from_file("MIMAKPTR.pgm")
print(hex(pgm.pgm_header.program_header.trcbck_loc_ptr))
```

JavaScript Sucks
----------------

Kaitai Struct's JS compiler can't handle calues over 53 bits, that basically screws up all pointer resolution for us. 

**In the latest KSY addresses have a custom `addr` type, that exposes a 3-byte offset to be used when resolved as 
pointers to work around this problem.**

Since the most mature IDE's rely on JS, we have to fall back to less sophisticated solutions:

- The Hobbits hexeditor kind of works, but breaks after certain depth. Also, coloring is often inaccurate.
- ksv works, but doesn't synchronize from the hex editor to the structure tree:

    `docker run -v "$(pwd):/share" -it kaitai/ksv MIMAKPTR.pgm pgm.ksy` (files should be in CWD!)
- A dump script is included that helps identifying what structure a particular address corresponds to (grep, less, ...)

