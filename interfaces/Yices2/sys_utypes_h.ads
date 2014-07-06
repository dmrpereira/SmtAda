pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with System;
with i386_utypes_h;

package sys_utypes_h is

  -- * Copyright (c) 2003-2007 Apple Inc. All rights reserved.
  -- *
  -- * @APPLE_OSREFERENCE_LICENSE_HEADER_START@
  -- * 
  -- * This file contains Original Code and/or Modifications of Original Code
  -- * as defined in and that are subject to the Apple Public Source License
  -- * Version 2.0 (the 'License'). You may not use this file except in
  -- * compliance with the License. The rights granted to you under the License
  -- * may not be used to create, or enable the creation or redistribution of,
  -- * unlawful or unlicensed copies of an Apple operating system, or to
  -- * circumvent, violate, or enable the circumvention or violation of, any
  -- * terms of an Apple operating system software license agreement.
  -- * 
  -- * Please obtain a copy of the License at
  -- * http://www.opensource.apple.com/apsl/ and read it before using this file.
  -- * 
  -- * The Original Code and all software distributed under the License are
  -- * distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
  -- * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
  -- * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
  -- * FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT.
  -- * Please see the License for the specific language governing rights and
  -- * limitations under the License.
  -- * 
  -- * @APPLE_OSREFERENCE_LICENSE_HEADER_END@
  --  

  -- pthread opaque structures  
  -- Routine to call  
   type uu_darwin_pthread_handler_rec is record
      uu_routine : access procedure (arg1 : System.Address);  -- /usr/include/sys/_types.h:60
      uu_arg : System.Address;  -- /usr/include/sys/_types.h:61
      uu_next : access uu_darwin_pthread_handler_rec;  -- /usr/include/sys/_types.h:62
   end record;
   pragma Convention (C_Pass_By_Copy, uu_darwin_pthread_handler_rec);  -- /usr/include/sys/_types.h:58

  -- Argument to pass  
   subtype anon934_anon936_array is Interfaces.C.char_array (0 .. 55);
   type u_opaque_pthread_attr_t is record
      uu_sig : aliased long;  -- /usr/include/sys/_types.h:64
      uu_opaque : aliased anon934_anon936_array;  -- /usr/include/sys/_types.h:64
   end record;
   pragma Convention (C_Pass_By_Copy, u_opaque_pthread_attr_t);  -- /usr/include/sys/_types.h:64

   subtype anon937_anon939_array is Interfaces.C.char_array (0 .. 39);
   type u_opaque_pthread_cond_t is record
      uu_sig : aliased long;  -- /usr/include/sys/_types.h:65
      uu_opaque : aliased anon937_anon939_array;  -- /usr/include/sys/_types.h:65
   end record;
   pragma Convention (C_Pass_By_Copy, u_opaque_pthread_cond_t);  -- /usr/include/sys/_types.h:65

   subtype anon940_anon942_array is Interfaces.C.char_array (0 .. 7);
   type u_opaque_pthread_condattr_t is record
      uu_sig : aliased long;  -- /usr/include/sys/_types.h:66
      uu_opaque : aliased anon940_anon942_array;  -- /usr/include/sys/_types.h:66
   end record;
   pragma Convention (C_Pass_By_Copy, u_opaque_pthread_condattr_t);  -- /usr/include/sys/_types.h:66

   subtype anon943_anon936_array is Interfaces.C.char_array (0 .. 55);
   type u_opaque_pthread_mutex_t is record
      uu_sig : aliased long;  -- /usr/include/sys/_types.h:67
      uu_opaque : aliased anon943_anon936_array;  -- /usr/include/sys/_types.h:67
   end record;
   pragma Convention (C_Pass_By_Copy, u_opaque_pthread_mutex_t);  -- /usr/include/sys/_types.h:67

   subtype anon946_anon942_array is Interfaces.C.char_array (0 .. 7);
   type u_opaque_pthread_mutexattr_t is record
      uu_sig : aliased long;  -- /usr/include/sys/_types.h:68
      uu_opaque : aliased anon946_anon942_array;  -- /usr/include/sys/_types.h:68
   end record;
   pragma Convention (C_Pass_By_Copy, u_opaque_pthread_mutexattr_t);  -- /usr/include/sys/_types.h:68

   subtype anon949_anon942_array is Interfaces.C.char_array (0 .. 7);
   type u_opaque_pthread_once_t is record
      uu_sig : aliased long;  -- /usr/include/sys/_types.h:69
      uu_opaque : aliased anon949_anon942_array;  -- /usr/include/sys/_types.h:69
   end record;
   pragma Convention (C_Pass_By_Copy, u_opaque_pthread_once_t);  -- /usr/include/sys/_types.h:69

   subtype anon952_anon954_array is Interfaces.C.char_array (0 .. 191);
   type u_opaque_pthread_rwlock_t is record
      uu_sig : aliased long;  -- /usr/include/sys/_types.h:70
      uu_opaque : aliased anon952_anon954_array;  -- /usr/include/sys/_types.h:70
   end record;
   pragma Convention (C_Pass_By_Copy, u_opaque_pthread_rwlock_t);  -- /usr/include/sys/_types.h:70

   subtype anon955_anon957_array is Interfaces.C.char_array (0 .. 15);
   type u_opaque_pthread_rwlockattr_t is record
      uu_sig : aliased long;  -- /usr/include/sys/_types.h:71
      uu_opaque : aliased anon955_anon957_array;  -- /usr/include/sys/_types.h:71
   end record;
   pragma Convention (C_Pass_By_Copy, u_opaque_pthread_rwlockattr_t);  -- /usr/include/sys/_types.h:71

   subtype anon958_anon960_array is Interfaces.C.char_array (0 .. 1167);
   type u_opaque_pthread_t is record
      uu_sig : aliased long;  -- /usr/include/sys/_types.h:72
      uu_cleanup_stack : access uu_darwin_pthread_handler_rec;  -- /usr/include/sys/_types.h:72
      uu_opaque : aliased anon958_anon960_array;  -- /usr/include/sys/_types.h:72
   end record;
   pragma Convention (C_Pass_By_Copy, u_opaque_pthread_t);  -- /usr/include/sys/_types.h:72

  -- * Type definitions; takes common type definitions that must be used
  -- * in multiple header files due to [XSI], removes them from the system
  -- * space, and puts them in the implementation space.
  --  

  -- total blocks  
   subtype uu_darwin_blkcnt_t is i386_utypes_h.uu_int64_t;  -- /usr/include/sys/_types.h:94

  -- preferred block size  
   subtype uu_darwin_blksize_t is i386_utypes_h.uu_int32_t;  -- /usr/include/sys/_types.h:95

  -- dev_t  
   subtype uu_darwin_dev_t is i386_utypes_h.uu_int32_t;  -- /usr/include/sys/_types.h:96

  -- Used by statvfs and fstatvfs  
   subtype uu_darwin_fsblkcnt_t is unsigned;  -- /usr/include/sys/_types.h:97

  -- Used by statvfs and fstatvfs  
   subtype uu_darwin_fsfilcnt_t is unsigned;  -- /usr/include/sys/_types.h:98

  -- [???] process and group IDs  
   subtype uu_darwin_gid_t is i386_utypes_h.uu_uint32_t;  -- /usr/include/sys/_types.h:99

  -- [XSI] pid_t, uid_t, or gid_t 
   subtype uu_darwin_id_t is i386_utypes_h.uu_uint32_t;  -- /usr/include/sys/_types.h:100

  -- [???] Used for 64 bit inodes  
   subtype uu_darwin_ino64_t is i386_utypes_h.uu_uint64_t;  -- /usr/include/sys/_types.h:101

  -- [???] Used for inodes  
   subtype uu_darwin_ino_t is uu_darwin_ino64_t;  -- /usr/include/sys/_types.h:103

  -- [???] Used for inodes  
  -- Used by mach  
   subtype uu_darwin_mach_port_name_t is i386_utypes_h.uu_darwin_natural_t;  -- /usr/include/sys/_types.h:107

  -- Used by mach  
   subtype uu_darwin_mach_port_t is uu_darwin_mach_port_name_t;  -- /usr/include/sys/_types.h:108

  -- [???] Some file attributes  
   subtype uu_darwin_mode_t is i386_utypes_h.uu_uint16_t;  -- /usr/include/sys/_types.h:109

  -- [???] Used for file sizes  
   subtype uu_darwin_off_t is i386_utypes_h.uu_int64_t;  -- /usr/include/sys/_types.h:110

  -- [???] process and group IDs  
   subtype uu_darwin_pid_t is i386_utypes_h.uu_int32_t;  -- /usr/include/sys/_types.h:111

  -- [???] Used for pthreads  
   subtype uu_darwin_pthread_attr_t is u_opaque_pthread_attr_t;

  -- [???] Used for pthreads  
   subtype uu_darwin_pthread_cond_t is u_opaque_pthread_cond_t;

  -- [???] Used for pthreads  
   subtype uu_darwin_pthread_condattr_t is u_opaque_pthread_condattr_t;

  -- [???] Used for pthreads  
   subtype uu_darwin_pthread_key_t is unsigned_long;  -- /usr/include/sys/_types.h:118

  -- [???] Used for pthreads  
   subtype uu_darwin_pthread_mutex_t is u_opaque_pthread_mutex_t;

  -- [???] Used for pthreads  
   subtype uu_darwin_pthread_mutexattr_t is u_opaque_pthread_mutexattr_t;

  -- [???] Used for pthreads  
   subtype uu_darwin_pthread_once_t is u_opaque_pthread_once_t;

  -- [???] Used for pthreads  
   subtype uu_darwin_pthread_rwlock_t is u_opaque_pthread_rwlock_t;

  -- [???] Used for pthreads  
   subtype uu_darwin_pthread_rwlockattr_t is u_opaque_pthread_rwlockattr_t;

  -- [???] Used for pthreads  
   type uu_darwin_pthread_t is access all u_opaque_pthread_t;  -- /usr/include/sys/_types.h:130

  -- [???] signal set  
   subtype uu_darwin_sigset_t is i386_utypes_h.uu_uint32_t;  -- /usr/include/sys/_types.h:131

  -- [???] microseconds  
   subtype uu_darwin_suseconds_t is i386_utypes_h.uu_int32_t;  -- /usr/include/sys/_types.h:132

  -- [???] user IDs  
   subtype uu_darwin_uid_t is i386_utypes_h.uu_uint32_t;  -- /usr/include/sys/_types.h:133

  -- [???] microseconds  
   subtype uu_darwin_useconds_t is i386_utypes_h.uu_uint32_t;  -- /usr/include/sys/_types.h:134

   type uu_darwin_uuid_t is array (0 .. 15) of aliased unsigned_char;  -- /usr/include/sys/_types.h:135

   subtype uu_darwin_uuid_string_t is Interfaces.C.char_array (0 .. 36);  -- /usr/include/sys/_types.h:136

end sys_utypes_h;
