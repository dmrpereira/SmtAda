pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with sys_utypes_h;
with System;
with Interfaces.C.Strings;
with sys_utypes_usize_t_h;
with sys_utypes_uoff_t_h;
with sys_utypes_ussize_t_h;

package stdio_h is


   BUFSIZ : constant := 1024;  --  /usr/include/stdio.h:190
   EOF : constant := (-1);  --  /usr/include/stdio.h:191

   FOPEN_MAX : constant := 20;  --  /usr/include/stdio.h:194
   FILENAME_MAX : constant := 1024;  --  /usr/include/stdio.h:195

   P_tmpdir : aliased constant String := "/var/tmp/" & ASCII.NUL;  --  /usr/include/stdio.h:199

   L_tmpnam : constant := 1024;  --  /usr/include/stdio.h:201
   TMP_MAX : constant := 308915776;  --  /usr/include/stdio.h:202

   SEEK_SET : constant := 0;  --  /usr/include/stdio.h:205

   SEEK_CUR : constant := 1;  --  /usr/include/stdio.h:208

   SEEK_END : constant := 2;  --  /usr/include/stdio.h:211
   --  unsupported macro: stdin __stdinp
   --  unsupported macro: stdout __stdoutp
   --  unsupported macro: stderr __stderrp

   L_ctermid : constant := 1024;  --  /usr/include/stdio.h:288
   --  arg-macro: procedure getc_unlocked (fp)
   --    __sgetc(fp)
   --  arg-macro: procedure putc_unlocked (x, fp)
   --    __sputc(x, fp)
   --  arg-macro: procedure getchar_unlocked ()
   --    getc_unlocked(stdin)
   --  arg-macro: procedure putchar_unlocked (x)
   --    putc_unlocked(x, stdout)
   --  arg-macro: procedure fropen (cookie, fn)
   --    funopen(cookie, fn, 0, 0, 0)
   --  arg-macro: procedure fwopen (cookie, fn)
   --    funopen(cookie, 0, fn, 0, 0)
   --  arg-macro: procedure feof_unlocked (p)
   --    __sfeof(p)
   --  arg-macro: procedure ferror_unlocked (p)
   --    __sferror(p)
   --  arg-macro: procedure clearerr_unlocked (p)
   --    __sclearerr(p)
   --  arg-macro: procedure fileno_unlocked (p)
   --    __sfileno(p)

  -- * Copyright (c) 2000, 2005, 2007, 2009, 2010 Apple Inc. All rights reserved.
  -- *
  -- * @APPLE_LICENSE_HEADER_START@
  -- *
  -- * This file contains Original Code and/or Modifications of Original Code
  -- * as defined in and that are subject to the Apple Public Source License
  -- * Version 2.0 (the 'License'). You may not use this file except in
  -- * compliance with the License. Please obtain a copy of the License at
  -- * http://www.opensource.apple.com/apsl/ and read it before using this
  -- * file.
  -- *
  -- * The Original Code and all software distributed under the License are
  -- * distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
  -- * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
  -- * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
  -- * FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT.
  -- * Please see the License for the specific language governing rights and
  -- * limitations under the License.
  -- *
  -- * @APPLE_LICENSE_HEADER_END@
  --  

  ---
  -- * Copyright (c) 1990, 1993
  -- *	The Regents of the University of California.  All rights reserved.
  -- *
  -- * This code is derived from software contributed to Berkeley by
  -- * Chris Torek.
  -- *
  -- * Redistribution and use in source and binary forms, with or without
  -- * modification, are permitted provided that the following conditions
  -- * are met:
  -- * 1. Redistributions of source code must retain the above copyright
  -- *    notice, this list of conditions and the following disclaimer.
  -- * 2. Redistributions in binary form must reproduce the above copyright
  -- *    notice, this list of conditions and the following disclaimer in the
  -- *    documentation and/or other materials provided with the distribution.
  -- * 3. All advertising materials mentioning features or use of this software
  -- *    must display the following acknowledgement:
  -- *	This product includes software developed by the University of
  -- *	California, Berkeley and its contributors.
  -- * 4. Neither the name of the University nor the names of its contributors
  -- *    may be used to endorse or promote products derived from this software
  -- *    without specific prior written permission.
  -- *
  -- * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
  -- * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  -- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
  -- * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
  -- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
  -- * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
  -- * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
  -- * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
  -- * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
  -- * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
  -- * SUCH DAMAGE.
  -- *
  -- *	@(#)stdio.h	8.5 (Berkeley) 4/29/95
  --  

  -- DO NOT REMOVE THIS COMMENT: fixincludes needs to see:
  -- * __gnuc_va_list and include <stdarg.h>  

   subtype fpos_t is sys_utypes_h.uu_darwin_off_t;  -- /usr/include/stdio.h:75

  -- * NB: to fit things in six character monocase externals, the stdio
  -- * code uses the prefix `__s' for stdio objects, typically followed
  -- * by a three-character attempt at a mnemonic.
  --  

  -- stdio buffers  
   type uu_sbuf is record
      u_base : access unsigned_char;  -- /usr/include/stdio.h:87
      u_size : aliased int;  -- /usr/include/stdio.h:88
   end record;
   pragma Convention (C_Pass_By_Copy, uu_sbuf);  -- /usr/include/stdio.h:86

  -- hold a buncha junk that would grow the ABI  
   --  skipped empty struct uu_sFILEX

  -- * stdio state variables.
  -- *
  -- * The following always hold:
  -- *
  -- *	if (_flags&(__SLBF|__SWR)) == (__SLBF|__SWR),
  -- *		_lbfsize is -_bf._size, else _lbfsize is 0
  -- *	if _flags&__SRD, _w is 0
  -- *	if _flags&__SWR, _r is 0
  -- *
  -- * This ensures that the getc and putc macros (or inline functions) never
  -- * try to write or read from a file that is in `read' or `write' mode.
  -- * (Moreover, they can, and do, automatically switch from read mode to
  -- * write mode, and back, on "r+" and "w+" files.)
  -- *
  -- * _lbfsize is used only to make the inline line-buffered output stream
  -- * code as compact as possible.
  -- *
  -- * _ub, _up, and _ur are used when ungetc() pushes back more characters
  -- * than fit in the current _bf, or when ungetc() pushes back a character
  -- * that does not match the previous one in _bf.  When this happens,
  -- * _ub._base becomes non-nil (i.e., a stream has ungetc() data iff
  -- * _ub._base!=NULL) and _up and _ur save the current values of _p and _r.
  -- *
  -- * NB: see WARNING above before changing the layout of this structure!
  --  

  -- current position in (some) buffer  
   type anon1009_anon1022_array is array (0 .. 2) of aliased unsigned_char;
   type anon1009_anon1024_array is array (0 .. 0) of aliased unsigned_char;
   type uu_sFILE is record
      u_p : access unsigned_char;  -- /usr/include/stdio.h:121
      u_r : aliased int;  -- /usr/include/stdio.h:122
      u_w : aliased int;  -- /usr/include/stdio.h:123
      u_flags : aliased short;  -- /usr/include/stdio.h:124
      u_file : aliased short;  -- /usr/include/stdio.h:125
      u_bf : aliased uu_sbuf;  -- /usr/include/stdio.h:126
      u_lbfsize : aliased int;  -- /usr/include/stdio.h:127
      u_cookie : System.Address;  -- /usr/include/stdio.h:130
      u_close : access function (arg1 : System.Address) return int;  -- /usr/include/stdio.h:131
      u_read : access function
           (arg1 : System.Address;
            arg2 : Interfaces.C.Strings.chars_ptr;
            arg3 : int) return int;  -- /usr/include/stdio.h:132
      u_seek : access function
           (arg1 : System.Address;
            arg2 : fpos_t;
            arg3 : int) return fpos_t;  -- /usr/include/stdio.h:133
      u_write : access function
           (arg1 : System.Address;
            arg2 : Interfaces.C.Strings.chars_ptr;
            arg3 : int) return int;  -- /usr/include/stdio.h:134
      u_ub : aliased uu_sbuf;  -- /usr/include/stdio.h:137
      u_extra : System.Address;  -- /usr/include/stdio.h:138
      u_ur : aliased int;  -- /usr/include/stdio.h:139
      u_ubuf : aliased anon1009_anon1022_array;  -- /usr/include/stdio.h:142
      u_nbuf : aliased anon1009_anon1024_array;  -- /usr/include/stdio.h:143
      u_lb : aliased uu_sbuf;  -- /usr/include/stdio.h:146
      u_blksize : aliased int;  -- /usr/include/stdio.h:149
      u_offset : aliased fpos_t;  -- /usr/include/stdio.h:150
   end record;
   pragma Convention (C_Pass_By_Copy, uu_sFILE);  -- /usr/include/stdio.h:120

  -- read space left for getc()  
  -- write space left for putc()  
  -- flags, below; this FILE is free if 0  
  -- fileno, if Unix descriptor, else -1  
  -- the buffer (at least 1 byte, if !NULL)  
  -- 0 or -_bf._size, for inline putc  
  -- operations  
  -- cookie passed to io functions  
  -- separate buffer for long sequences of ungetc()  
  -- ungetc buffer  
  -- additions to FILE to not break ABI  
  -- saved _r when _r is counting ungetc data  
  -- tricks to meet minimum requirements even when malloc() fails  
  -- guarantee an ungetc() buffer  
  -- guarantee a getc() buffer  
  -- separate buffer for fgetln() when line crosses buffer boundary  
  -- buffer for fgetln()  
  -- Unix stdio files get aligned to block boundaries on fseek()  
  -- stat.st_blksize (may be != _bf._size)  
  -- current lseek offset (see WARNING)  
   subtype FILE is uu_sFILE;

  -- RD and WR are never simultaneously asserted  
  -- * The following three definitions are for ANSI C, which took them
  -- * from System V, which brilliantly took internal interface macros and
  -- * made them official arguments to setvbuf(), without renaming them.
  -- * Hence, these ugly _IOxxx names are *supposed* to appear in user code.
  -- *
  -- * Although numbered as their counterparts above, the implementation
  -- * does not rely on this.
  --  

  -- must be == _POSIX_STREAM_MAX <limits.h>  
  -- System V/ANSI C; this is the wrong way to do this, do *not* use these.  
  -- ANSI-C  
   procedure clearerr (arg1 : access FILE);  -- /usr/include/stdio.h:229
   pragma Import (C, clearerr, "clearerr");

   function fclose (arg1 : access FILE) return int;  -- /usr/include/stdio.h:230
   pragma Import (C, fclose, "fclose");

   function feof (arg1 : access FILE) return int;  -- /usr/include/stdio.h:231
   pragma Import (C, feof, "feof");

   function ferror (arg1 : access FILE) return int;  -- /usr/include/stdio.h:232
   pragma Import (C, ferror, "ferror");

   function fflush (arg1 : access FILE) return int;  -- /usr/include/stdio.h:233
   pragma Import (C, fflush, "fflush");

   function fgetc (arg1 : access FILE) return int;  -- /usr/include/stdio.h:234
   pragma Import (C, fgetc, "fgetc");

   function fgetpos (arg1 : access FILE; arg2 : access fpos_t) return int;  -- /usr/include/stdio.h:235
   pragma Import (C, fgetpos, "fgetpos");

   function fgets
     (arg1 : Interfaces.C.Strings.chars_ptr;
      arg2 : int;
      arg3 : access FILE) return Interfaces.C.Strings.chars_ptr;  -- /usr/include/stdio.h:236
   pragma Import (C, fgets, "fgets");

   function fopen (arg1 : Interfaces.C.Strings.chars_ptr; arg2 : Interfaces.C.Strings.chars_ptr) return access FILE;  -- /usr/include/stdio.h:240
   pragma Import (C, fopen, "_fopen");

   function fprintf (arg1 : access FILE; arg2 : Interfaces.C.Strings.chars_ptr  -- , ...
      ) return int;  -- /usr/include/stdio.h:242
   pragma Import (C, fprintf, "fprintf");

   function fputc (arg1 : int; arg2 : access FILE) return int;  -- /usr/include/stdio.h:243
   pragma Import (C, fputc, "fputc");

   function fputs (arg1 : Interfaces.C.Strings.chars_ptr; arg2 : access FILE) return int;  -- /usr/include/stdio.h:244
   pragma Import (C, fputs, "_fputs");

   function fread
     (arg1 : System.Address;
      arg2 : sys_utypes_usize_t_h.size_t;
      arg3 : sys_utypes_usize_t_h.size_t;
      arg4 : access FILE) return sys_utypes_usize_t_h.size_t;  -- /usr/include/stdio.h:245
   pragma Import (C, fread, "fread");

   function freopen
     (arg1 : Interfaces.C.Strings.chars_ptr;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : access FILE) return access FILE;  -- /usr/include/stdio.h:246
   pragma Import (C, freopen, "_freopen");

   function fscanf (arg1 : access FILE; arg2 : Interfaces.C.Strings.chars_ptr  -- , ...
      ) return int;  -- /usr/include/stdio.h:248
   pragma Import (C, fscanf, "fscanf");

   function fseek
     (arg1 : access FILE;
      arg2 : long;
      arg3 : int) return int;  -- /usr/include/stdio.h:249
   pragma Import (C, fseek, "fseek");

   function fsetpos (arg1 : access FILE; arg2 : access fpos_t) return int;  -- /usr/include/stdio.h:250
   pragma Import (C, fsetpos, "fsetpos");

   function ftell (arg1 : access FILE) return long;  -- /usr/include/stdio.h:251
   pragma Import (C, ftell, "ftell");

   function fwrite
     (arg1 : System.Address;
      arg2 : sys_utypes_usize_t_h.size_t;
      arg3 : sys_utypes_usize_t_h.size_t;
      arg4 : access FILE) return sys_utypes_usize_t_h.size_t;  -- /usr/include/stdio.h:252
   pragma Import (C, fwrite, "_fwrite");

   function getc (arg1 : access FILE) return int;  -- /usr/include/stdio.h:253
   pragma Import (C, getc, "getc");

   function getchar return int;  -- /usr/include/stdio.h:254
   pragma Import (C, getchar, "getchar");

   function gets (arg1 : Interfaces.C.Strings.chars_ptr) return Interfaces.C.Strings.chars_ptr;  -- /usr/include/stdio.h:255
   pragma Import (C, gets, "gets");

   procedure perror (arg1 : Interfaces.C.Strings.chars_ptr);  -- /usr/include/stdio.h:256
   pragma Import (C, perror, "perror");

   function printf (arg1 : Interfaces.C.Strings.chars_ptr  -- , ...
      ) return int;  -- /usr/include/stdio.h:257
   pragma Import (C, printf, "printf");

   function putc (arg1 : int; arg2 : access FILE) return int;  -- /usr/include/stdio.h:258
   pragma Import (C, putc, "putc");

   function putchar (arg1 : int) return int;  -- /usr/include/stdio.h:259
   pragma Import (C, putchar, "putchar");

   function puts (arg1 : Interfaces.C.Strings.chars_ptr) return int;  -- /usr/include/stdio.h:260
   pragma Import (C, puts, "puts");

   function remove (arg1 : Interfaces.C.Strings.chars_ptr) return int;  -- /usr/include/stdio.h:261
   pragma Import (C, remove, "remove");

   function rename (arg1 : Interfaces.C.Strings.chars_ptr; arg2 : Interfaces.C.Strings.chars_ptr) return int;  -- /usr/include/stdio.h:262
   pragma Import (C, rename, "rename");

   procedure rewind (arg1 : access FILE);  -- /usr/include/stdio.h:263
   pragma Import (C, rewind, "rewind");

   function scanf (arg1 : Interfaces.C.Strings.chars_ptr  -- , ...
      ) return int;  -- /usr/include/stdio.h:264
   pragma Import (C, scanf, "scanf");

   procedure setbuf (arg1 : access FILE; arg2 : Interfaces.C.Strings.chars_ptr);  -- /usr/include/stdio.h:265
   pragma Import (C, setbuf, "setbuf");

   function setvbuf
     (arg1 : access FILE;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : int;
      arg4 : sys_utypes_usize_t_h.size_t) return int;  -- /usr/include/stdio.h:266
   pragma Import (C, setvbuf, "setvbuf");

   function sprintf (arg1 : Interfaces.C.Strings.chars_ptr; arg2 : Interfaces.C.Strings.chars_ptr  -- , ...
      ) return int;  -- /usr/include/stdio.h:267
   pragma Import (C, sprintf, "sprintf");

   function sscanf (arg1 : Interfaces.C.Strings.chars_ptr; arg2 : Interfaces.C.Strings.chars_ptr  -- , ...
      ) return int;  -- /usr/include/stdio.h:268
   pragma Import (C, sscanf, "sscanf");

   function tmpfile return access FILE;  -- /usr/include/stdio.h:269
   pragma Import (C, tmpfile, "tmpfile");

   function tmpnam (arg1 : Interfaces.C.Strings.chars_ptr) return Interfaces.C.Strings.chars_ptr;  -- /usr/include/stdio.h:274
   pragma Import (C, tmpnam, "tmpnam");

   function ungetc (arg1 : int; arg2 : access FILE) return int;  -- /usr/include/stdio.h:275
   pragma Import (C, ungetc, "ungetc");

   function vfprintf
     (arg1 : access FILE;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : access System.Address) return int;  -- /usr/include/stdio.h:276
   pragma Import (C, vfprintf, "vfprintf");

   function vprintf (arg1 : Interfaces.C.Strings.chars_ptr; arg2 : access System.Address) return int;  -- /usr/include/stdio.h:277
   pragma Import (C, vprintf, "vprintf");

   function vsprintf
     (arg1 : Interfaces.C.Strings.chars_ptr;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : access System.Address) return int;  -- /usr/include/stdio.h:278
   pragma Import (C, vsprintf, "vsprintf");

  -- Additional functionality provided by:
  -- * POSIX.1-1988
  --  

  -- Multiply defined in stdio.h and unistd.h by SUS  
   function ctermid (arg1 : Interfaces.C.Strings.chars_ptr) return Interfaces.C.Strings.chars_ptr;  -- /usr/include/stdio.h:294
   pragma Import (C, ctermid, "ctermid");

   function fdopen (arg1 : int; arg2 : Interfaces.C.Strings.chars_ptr) return access FILE;  -- /usr/include/stdio.h:300
   pragma Import (C, fdopen, "_fdopen");

   function fileno (arg1 : access FILE) return int;  -- /usr/include/stdio.h:302
   pragma Import (C, fileno, "fileno");

  -- Additional functionality provided by:
  -- * POSIX.2-1992 C Language Binding Option
  --  

   function pclose (arg1 : access FILE) return int;  -- /usr/include/stdio.h:313
   pragma Import (C, pclose, "pclose");

   function popen (arg1 : Interfaces.C.Strings.chars_ptr; arg2 : Interfaces.C.Strings.chars_ptr) return access FILE;  -- /usr/include/stdio.h:317
   pragma Import (C, popen, "_popen");

  -- Additional functionality provided by:
  -- * POSIX.1c-1995,
  -- * POSIX.1i-1995,
  -- * and the omnibus ISO/IEC 9945-1: 1996
  --  

  -- Functions internal to the implementation.  
  -- * The __sfoo macros are here so that we can
  -- * define function versions in the C library.
  --  

  -- * This has been tuned to generate reasonable code on the vax using pcc.
  --  

   procedure flockfile (arg1 : access FILE);  -- /usr/include/stdio.h:372
   pragma Import (C, flockfile, "flockfile");

   function ftrylockfile (arg1 : access FILE) return int;  -- /usr/include/stdio.h:373
   pragma Import (C, ftrylockfile, "ftrylockfile");

   procedure funlockfile (arg1 : access FILE);  -- /usr/include/stdio.h:374
   pragma Import (C, funlockfile, "funlockfile");

   function getc_unlocked (arg1 : access FILE) return int;  -- /usr/include/stdio.h:375
   pragma Import (C, getc_unlocked, "getc_unlocked");

   function getchar_unlocked return int;  -- /usr/include/stdio.h:376
   pragma Import (C, getchar_unlocked, "getchar_unlocked");

   function putc_unlocked (arg1 : int; arg2 : access FILE) return int;  -- /usr/include/stdio.h:377
   pragma Import (C, putc_unlocked, "putc_unlocked");

   function putchar_unlocked (arg1 : int) return int;  -- /usr/include/stdio.h:378
   pragma Import (C, putchar_unlocked, "putchar_unlocked");

  -- Removed in Issue 6  
   function getw (arg1 : access FILE) return int;  -- /usr/include/stdio.h:382
   pragma Import (C, getw, "getw");

   function putw (arg1 : int; arg2 : access FILE) return int;  -- /usr/include/stdio.h:383
   pragma Import (C, putw, "putw");

   function tempnam (arg1 : Interfaces.C.Strings.chars_ptr; arg2 : Interfaces.C.Strings.chars_ptr) return Interfaces.C.Strings.chars_ptr;  -- /usr/include/stdio.h:389
   pragma Import (C, tempnam, "_tempnam");

  -- Additional functionality provided by:
  -- * POSIX.1-2001
  -- * ISO C99
  --  

   function fseeko
     (arg1 : access FILE;
      arg2 : sys_utypes_uoff_t_h.off_t;
      arg3 : int) return int;  -- /usr/include/stdio.h:412
   pragma Import (C, fseeko, "fseeko");

   function ftello (arg1 : access FILE) return sys_utypes_uoff_t_h.off_t;  -- /usr/include/stdio.h:413
   pragma Import (C, ftello, "ftello");

   function snprintf
     (arg1 : Interfaces.C.Strings.chars_ptr;
      arg2 : sys_utypes_usize_t_h.size_t;
      arg3 : Interfaces.C.Strings.chars_ptr  -- , ...
      ) return int;  -- /usr/include/stdio.h:419
   pragma Import (C, snprintf, "snprintf");

   function vfscanf
     (arg1 : access FILE;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : access System.Address) return int;  -- /usr/include/stdio.h:420
   pragma Import (C, vfscanf, "vfscanf");

   function vscanf (arg1 : Interfaces.C.Strings.chars_ptr; arg2 : access System.Address) return int;  -- /usr/include/stdio.h:421
   pragma Import (C, vscanf, "vscanf");

   function vsnprintf
     (arg1 : Interfaces.C.Strings.chars_ptr;
      arg2 : sys_utypes_usize_t_h.size_t;
      arg3 : Interfaces.C.Strings.chars_ptr;
      arg4 : access System.Address) return int;  -- /usr/include/stdio.h:422
   pragma Import (C, vsnprintf, "vsnprintf");

   function vsscanf
     (arg1 : Interfaces.C.Strings.chars_ptr;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : access System.Address) return int;  -- /usr/include/stdio.h:423
   pragma Import (C, vsscanf, "vsscanf");

  -- Additional functionality provided by:
  -- * POSIX.1-2008
  --  

   function dprintf (arg1 : int; arg2 : Interfaces.C.Strings.chars_ptr  -- , ...
      ) return int;  -- /usr/include/stdio.h:437
   pragma Import (C, dprintf, "dprintf");

   function vdprintf
     (arg1 : int;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : access System.Address) return int;  -- /usr/include/stdio.h:438
   pragma Import (C, vdprintf, "vdprintf");

   function getdelim
     (arg1 : System.Address;
      arg2 : access sys_utypes_usize_t_h.size_t;
      arg3 : int;
      arg4 : access FILE) return sys_utypes_ussize_t_h.ssize_t;  -- /usr/include/stdio.h:439
   pragma Import (C, getdelim, "getdelim");

   function getline
     (arg1 : System.Address;
      arg2 : access sys_utypes_usize_t_h.size_t;
      arg3 : access FILE) return sys_utypes_ussize_t_h.ssize_t;  -- /usr/include/stdio.h:440
   pragma Import (C, getline, "getline");

  -- Darwin extensions  
  -- perror(3) external variables  
   sys_nerr : aliased int;  -- /usr/include/stdio.h:450
   pragma Import (C, sys_nerr, "sys_nerr");

   sys_errlist : aliased array (size_t) of Interfaces.C.Strings.chars_ptr;  -- /usr/include/stdio.h:451
   pragma Import (C, sys_errlist, "sys_errlist");

   function asprintf (arg1 : System.Address; arg2 : Interfaces.C.Strings.chars_ptr  -- , ...
      ) return int;  -- /usr/include/stdio.h:453
   pragma Import (C, asprintf, "asprintf");

   function ctermid_r (arg1 : Interfaces.C.Strings.chars_ptr) return Interfaces.C.Strings.chars_ptr;  -- /usr/include/stdio.h:454
   pragma Import (C, ctermid_r, "ctermid_r");

   function fgetln (arg1 : access FILE; arg2 : access sys_utypes_usize_t_h.size_t) return Interfaces.C.Strings.chars_ptr;  -- /usr/include/stdio.h:455
   pragma Import (C, fgetln, "fgetln");

   function fmtcheck (arg1 : Interfaces.C.Strings.chars_ptr; arg2 : Interfaces.C.Strings.chars_ptr) return Interfaces.C.Strings.chars_ptr;  -- /usr/include/stdio.h:456
   pragma Import (C, fmtcheck, "fmtcheck");

   function fpurge (arg1 : access FILE) return int;  -- /usr/include/stdio.h:457
   pragma Import (C, fpurge, "fpurge");

   procedure setbuffer
     (arg1 : access FILE;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : int);  -- /usr/include/stdio.h:458
   pragma Import (C, setbuffer, "setbuffer");

   function setlinebuf (arg1 : access FILE) return int;  -- /usr/include/stdio.h:459
   pragma Import (C, setlinebuf, "setlinebuf");

   function vasprintf
     (arg1 : System.Address;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : access System.Address) return int;  -- /usr/include/stdio.h:460
   pragma Import (C, vasprintf, "vasprintf");

   function zopen
     (arg1 : Interfaces.C.Strings.chars_ptr;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : int) return access FILE;  -- /usr/include/stdio.h:461
   pragma Import (C, zopen, "zopen");

  -- * Stdio function-access interface.
  --  

   function funopen
     (arg1 : System.Address;
      arg2 : access function
        (arg1 : System.Address;
         arg2 : Interfaces.C.Strings.chars_ptr;
         arg3 : int) return int;
      arg3 : access function
        (arg1 : System.Address;
         arg2 : Interfaces.C.Strings.chars_ptr;
         arg3 : int) return int;
      arg4 : access function
        (arg1 : System.Address;
         arg2 : fpos_t;
         arg3 : int) return fpos_t;
      arg5 : access function (arg1 : System.Address) return int) return access FILE;  -- /usr/include/stdio.h:467
   pragma Import (C, funopen, "funopen");

  -- Security checking functions.   
end stdio_h;
