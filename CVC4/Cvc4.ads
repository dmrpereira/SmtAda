pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Cvc4_Defs; use Cvc4_Defs;
with System;
with Interfaces.C.Strings;

package Cvc4 is

   function vc_createValidityChecker (arg1 : Flags) return VC;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:30
   pragma Import (C, vc_createValidityChecker, "vc_createValidityChecker");

   function vc_createFlags return Flags;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:32
   pragma Import (C, vc_createFlags, "vc_createFlags");

   procedure vc_destroyValidityChecker (arg1 : VC);  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:35
   pragma Import (C, vc_destroyValidityChecker, "vc_destroyValidityChecker");

   procedure vc_deleteFlags (arg1 : Flags);  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:37
   pragma Import (C, vc_deleteFlags, "vc_deleteFlags");

   procedure vc_deleteType (arg1 : c_Type);  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:39
   pragma Import (C, vc_deleteType, "vc_deleteType");

   procedure vc_deleteExpr (arg1 : Expr);  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:41
   pragma Import (C, vc_deleteExpr, "vc_deleteExpr");

   procedure vc_deleteOp (arg1 : Op);  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:43
   pragma Import (C, vc_deleteOp, "vc_deleteOp");

   procedure vc_deleteVector (arg1 : System.Address);  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:45
   pragma Import (C, vc_deleteVector, "vc_deleteVector");

   procedure vc_deleteTypeVector (arg1 : System.Address);  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:47
   pragma Import (C, vc_deleteTypeVector, "vc_deleteTypeVector");

   procedure vc_setBoolFlag
     (arg1 : Flags;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : int);  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:51
   pragma Import (C, vc_setBoolFlag, "vc_setBoolFlag");

   procedure vc_setIntFlag
     (arg1 : Flags;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : int);  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:53
   pragma Import (C, vc_setIntFlag, "vc_setIntFlag");

   procedure vc_setStringFlag
     (arg1 : Flags;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : Interfaces.C.Strings.chars_ptr);  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:55
   pragma Import (C, vc_setStringFlag, "vc_setStringFlag");

   procedure vc_setStrSeqFlag
     (arg1 : Flags;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : Interfaces.C.Strings.chars_ptr;
      arg4 : int);  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:57
   pragma Import (C, vc_setStrSeqFlag, "vc_setStrSeqFlag");

   function vc_boolType (arg1 : VC) return c_Type;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:60
   pragma Import (C, vc_boolType, "vc_boolType");

   function vc_realType (arg1 : VC) return c_Type;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:61
   pragma Import (C, vc_realType, "vc_realType");

   function vc_intType (arg1 : VC) return c_Type;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:62
   pragma Import (C, vc_intType, "vc_intType");

   function vc_subRangeType
     (arg1 : VC;
      arg2 : int;
      arg3 : int) return c_Type;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:65
   pragma Import (C, vc_subRangeType, "vc_subRangeType");

   function vc_subtypeType
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return c_Type;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:79
   pragma Import (C, vc_subtypeType, "vc_subtypeType");

   function vc_tupleType2
     (arg1 : VC;
      arg2 : c_Type;
      arg3 : c_Type) return c_Type;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:82
   pragma Import (C, vc_tupleType2, "vc_tupleType2");

   function vc_tupleType3
     (arg1 : VC;
      arg2 : c_Type;
      arg3 : c_Type;
      arg4 : c_Type) return c_Type;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:83
   pragma Import (C, vc_tupleType3, "vc_tupleType3");

   function vc_tupleTypeN
     (arg1 : VC;
      arg2 : System.Address;
      arg3 : int) return c_Type;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:85
   pragma Import (C, vc_tupleTypeN, "vc_tupleTypeN");

   function vc_recordType1
     (arg1 : VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : c_Type) return c_Type;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:88
   pragma Import (C, vc_recordType1, "vc_recordType1");

   function vc_recordType2
     (arg1 : VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : c_Type;
      arg4 : Interfaces.C.Strings.chars_ptr;
      arg5 : c_Type) return c_Type;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:89
   pragma Import (C, vc_recordType2, "vc_recordType2");

   function vc_recordType3
     (arg1 : VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : c_Type;
      arg4 : Interfaces.C.Strings.chars_ptr;
      arg5 : c_Type;
      arg6 : Interfaces.C.Strings.chars_ptr;
      arg7 : c_Type) return c_Type;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:91
   pragma Import (C, vc_recordType3, "vc_recordType3");

   function vc_recordTypeN
     (arg1 : VC;
      arg2 : System.Address;
      arg3 : System.Address;
      arg4 : int) return c_Type;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:96
   pragma Import (C, vc_recordTypeN, "vc_recordTypeN");

   function vc_dataType1
     (arg1 : VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : Interfaces.C.Strings.chars_ptr;
      arg4 : int;
      arg5 : System.Address;
      arg6 : System.Address) return c_Type;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:104
   pragma Import (C, vc_dataType1, "vc_dataType1");

   function vc_dataTypeN
     (arg1 : VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : int;
      arg4 : System.Address;
      arg5 : access int;
      arg6 : System.Address;
      arg7 : System.Address) return c_Type;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:111
   pragma Import (C, vc_dataTypeN, "vc_dataTypeN");

   function vc_dataTypeMN
     (arg1 : VC;
      arg2 : int;
      arg3 : System.Address;
      arg4 : access int;
      arg5 : System.Address;
      arg6 : System.Address;
      arg7 : System.Address;
      arg8 : System.Address) return System.Address;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:121
   pragma Import (C, vc_dataTypeMN, "vc_dataTypeMN");

   function vc_arrayType
     (arg1 : VC;
      arg2 : c_Type;
      arg3 : c_Type) return c_Type;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:127
   pragma Import (C, vc_arrayType, "vc_arrayType");

   function vc_bvType (arg1 : VC; arg2 : int) return c_Type;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:130
   pragma Import (C, vc_bvType, "vc_bvType");

   function vc_funType1
     (arg1 : VC;
      arg2 : c_Type;
      arg3 : c_Type) return c_Type;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:133
   pragma Import (C, vc_funType1, "vc_funType1");

   function vc_funType2
     (arg1 : VC;
      arg2 : c_Type;
      arg3 : c_Type;
      arg4 : c_Type) return c_Type;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:135
   pragma Import (C, vc_funType2, "vc_funType2");

   function vc_funType3
     (arg1 : VC;
      arg2 : c_Type;
      arg3 : c_Type;
      arg4 : c_Type;
      arg5 : c_Type) return c_Type;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:137
   pragma Import (C, vc_funType3, "vc_funType3");

   function vc_funTypeN
     (arg1 : VC;
      arg2 : System.Address;
      arg3 : c_Type;
      arg4 : int) return c_Type;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:139
   pragma Import (C, vc_funTypeN, "vc_funTypeN");

   function vc_createType (arg1 : VC; arg2 : Interfaces.C.Strings.chars_ptr) return c_Type;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:144
   pragma Import (C, vc_createType, "vc_createType");

   function vc_lookupType (arg1 : VC; arg2 : Interfaces.C.Strings.chars_ptr) return c_Type;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:146
   pragma Import (C, vc_lookupType, "vc_lookupType");

   function vc_getEM (arg1 : VC) return System.Address;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:153
   pragma Import (C, vc_getEM, "vc_getEM");

   function vc_varExpr
     (arg1 : VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : c_Type) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:157
   pragma Import (C, vc_varExpr, "vc_varExpr");

   function vc_varExprDef
     (arg1 : VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : c_Type;
      arg4 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:160
   pragma Import (C, vc_varExprDef, "vc_varExprDef");

   function vc_lookupVar
     (arg1 : VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : System.Address) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:165
   pragma Import (C, vc_lookupVar, "vc_lookupVar");

   function vc_getType (arg1 : VC; arg2 : Expr) return c_Type;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:168
   pragma Import (C, vc_getType, "vc_getType");

   function vc_getBaseType (arg1 : VC; arg2 : Expr) return c_Type;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:171
   pragma Import (C, vc_getBaseType, "vc_getBaseType");

   function vc_getBaseTypeOfType (arg1 : VC; arg2 : c_Type) return c_Type;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:174
   pragma Import (C, vc_getBaseTypeOfType, "vc_getBaseTypeOfType");

   function vc_getTypePred
     (arg1 : VC;
      arg2 : c_Type;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:177
   pragma Import (C, vc_getTypePred, "vc_getTypePred");

   function vc_stringExpr (arg1 : VC; arg2 : Interfaces.C.Strings.chars_ptr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:180
   pragma Import (C, vc_stringExpr, "vc_stringExpr");

   function vc_idExpr (arg1 : VC; arg2 : Interfaces.C.Strings.chars_ptr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:183
   pragma Import (C, vc_idExpr, "vc_idExpr");

   function vc_listExpr
     (arg1 : VC;
      arg2 : int;
      arg3 : System.Address) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:206
   pragma Import (C, vc_listExpr, "vc_listExpr");

   procedure vc_printExpr (arg1 : VC; arg2 : Expr);  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:210
   pragma Import (C, vc_printExpr, "vc_printExpr");

   function vc_printExprString (arg1 : VC; arg2 : Expr) return Interfaces.C.Strings.chars_ptr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:215
   pragma Import (C, vc_printExprString, "vc_printExprString");

   procedure vc_deleteString (arg1 : Interfaces.C.Strings.chars_ptr);  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:217
   pragma Import (C, vc_deleteString, "vc_deleteString");

   procedure vc_printExprFile
     (arg1 : VC;
      arg2 : Expr;
      arg3 : int);  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:219
   pragma Import (C, vc_printExprFile, "vc_printExprFile");

   function vc_importExpr (arg1 : VC; arg2 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:231
   pragma Import (C, vc_importExpr, "vc_importExpr");

   function vc_importType (arg1 : c_Type) return c_Type;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:235
   pragma Import (C, vc_importType, "vc_importType");

   function vc_eqExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:238
   pragma Import (C, vc_eqExpr, "vc_eqExpr");

   function vc_distinctExpr
     (arg1 : VC;
      arg2 : System.Address;
      arg3 : int) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:241
   pragma Import (C, vc_distinctExpr, "vc_distinctExpr");

   function vc_trueExpr (arg1 : VC) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:247
   pragma Import (C, vc_trueExpr, "vc_trueExpr");

   function vc_falseExpr (arg1 : VC) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:248
   pragma Import (C, vc_falseExpr, "vc_falseExpr");

   function vc_notExpr (arg1 : VC; arg2 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:249
   pragma Import (C, vc_notExpr, "vc_notExpr");

   function vc_andExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:250
   pragma Import (C, vc_andExpr, "vc_andExpr");

   function vc_andExprN
     (arg1 : VC;
      arg2 : System.Address;
      arg3 : int) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:251
   pragma Import (C, vc_andExprN, "vc_andExprN");

   function vc_orExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:252
   pragma Import (C, vc_orExpr, "vc_orExpr");

   function vc_orExprN
     (arg1 : VC;
      arg2 : System.Address;
      arg3 : int) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:253
   pragma Import (C, vc_orExprN, "vc_orExprN");

   function vc_impliesExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:254
   pragma Import (C, vc_impliesExpr, "vc_impliesExpr");

   function vc_iffExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:255
   pragma Import (C, vc_iffExpr, "vc_iffExpr");

   function vc_iteExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr;
      arg4 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:256
   pragma Import (C, vc_iteExpr, "vc_iteExpr");

   function vc_substExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : System.Address;
      arg4 : int;
      arg5 : System.Address;
      arg6 : int) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:264
   pragma Import (C, vc_substExpr, "vc_substExpr");

   function vc_createOp
     (arg1 : VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : c_Type) return Op;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:272
   pragma Import (C, vc_createOp, "vc_createOp");

   function vc_createOpDef
     (arg1 : VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : c_Type;
      arg4 : Expr) return Op;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:275
   pragma Import (C, vc_createOpDef, "vc_createOpDef");

   function vc_lookupOp
     (arg1 : VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : System.Address) return Op;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:281
   pragma Import (C, vc_lookupOp, "vc_lookupOp");

   function vc_funExpr1
     (arg1 : VC;
      arg2 : Op;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:285
   pragma Import (C, vc_funExpr1, "vc_funExpr1");

   function vc_funExpr2
     (arg1 : VC;
      arg2 : Op;
      arg3 : Expr;
      arg4 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:286
   pragma Import (C, vc_funExpr2, "vc_funExpr2");

   function vc_funExpr3
     (arg1 : VC;
      arg2 : Op;
      arg3 : Expr;
      arg4 : Expr;
      arg5 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:287
   pragma Import (C, vc_funExpr3, "vc_funExpr3");

   function vc_funExprN
     (arg1 : VC;
      arg2 : Op;
      arg3 : System.Address;
      arg4 : int) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:288
   pragma Import (C, vc_funExprN, "vc_funExprN");

   function vc_ratExpr
     (arg1 : VC;
      arg2 : int;
      arg3 : int) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:294
   pragma Import (C, vc_ratExpr, "vc_ratExpr");

   function vc_ratExprFromStr
     (arg1 : VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : Interfaces.C.Strings.chars_ptr;
      arg4 : int) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:299
   pragma Import (C, vc_ratExprFromStr, "vc_ratExprFromStr");

   function vc_ratExprFromStr1
     (arg1 : VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : int) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:308
   pragma Import (C, vc_ratExprFromStr1, "vc_ratExprFromStr1");

   function vc_uminusExpr (arg1 : VC; arg2 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:311
   pragma Import (C, vc_uminusExpr, "vc_uminusExpr");

   function vc_plusExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:314
   pragma Import (C, vc_plusExpr, "vc_plusExpr");

   function vc_plusExprN
     (arg1 : VC;
      arg2 : System.Address;
      arg3 : int) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:315
   pragma Import (C, vc_plusExprN, "vc_plusExprN");

   function vc_minusExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:316
   pragma Import (C, vc_minusExpr, "vc_minusExpr");

   function vc_multExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:317
   pragma Import (C, vc_multExpr, "vc_multExpr");

   function vc_powExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:318
   pragma Import (C, vc_powExpr, "vc_powExpr");

   function vc_divideExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:319
   pragma Import (C, vc_divideExpr, "vc_divideExpr");

   function vc_ltExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:324
   pragma Import (C, vc_ltExpr, "vc_ltExpr");

   function vc_leExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:325
   pragma Import (C, vc_leExpr, "vc_leExpr");

   function vc_gtExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:326
   pragma Import (C, vc_gtExpr, "vc_gtExpr");

   function vc_geExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:327
   pragma Import (C, vc_geExpr, "vc_geExpr");

   function vc_recordExpr1
     (arg1 : VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:332
   pragma Import (C, vc_recordExpr1, "vc_recordExpr1");

   function vc_recordExpr2
     (arg1 : VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : Expr;
      arg4 : Interfaces.C.Strings.chars_ptr;
      arg5 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:333
   pragma Import (C, vc_recordExpr2, "vc_recordExpr2");

   function vc_recordExpr3
     (arg1 : VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : Expr;
      arg4 : Interfaces.C.Strings.chars_ptr;
      arg5 : Expr;
      arg6 : Interfaces.C.Strings.chars_ptr;
      arg7 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:335
   pragma Import (C, vc_recordExpr3, "vc_recordExpr3");

   function vc_recordExprN
     (arg1 : VC;
      arg2 : System.Address;
      arg3 : System.Address;
      arg4 : int) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:338
   pragma Import (C, vc_recordExprN, "vc_recordExprN");

   function vc_recSelectExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Interfaces.C.Strings.chars_ptr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:341
   pragma Import (C, vc_recSelectExpr, "vc_recSelectExpr");

   function vc_recUpdateExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Interfaces.C.Strings.chars_ptr;
      arg4 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:344
   pragma Import (C, vc_recUpdateExpr, "vc_recUpdateExpr");

   function vc_readExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:349
   pragma Import (C, vc_readExpr, "vc_readExpr");

   function vc_writeExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr;
      arg4 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:352
   pragma Import (C, vc_writeExpr, "vc_writeExpr");

   function vc_bv32Type (arg1 : VC) return c_Type;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:356
   pragma Import (C, vc_bv32Type, "vc_bv32Type");

   function vc_bvConstExprFromStr (arg1 : VC; arg2 : Interfaces.C.Strings.chars_ptr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:359
   pragma Import (C, vc_bvConstExprFromStr, "vc_bvConstExprFromStr");

   function vc_bvConstExprFromInt
     (arg1 : VC;
      arg2 : int;
      arg3 : unsigned) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:360
   pragma Import (C, vc_bvConstExprFromInt, "vc_bvConstExprFromInt");

   function vc_bv32ConstExprFromInt (arg1 : VC; arg2 : unsigned) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:361
   pragma Import (C, vc_bv32ConstExprFromInt, "vc_bv32ConstExprFromInt");

   function vc_bvConstExprFromLL
     (arg1 : VC;
      arg2 : int;
      arg3 : unsigned_long) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:362
   pragma Import (C, vc_bvConstExprFromLL, "vc_bvConstExprFromLL");

   function vc_bvConcatExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:365
   pragma Import (C, vc_bvConcatExpr, "vc_bvConcatExpr");

   function vc_bvConcatExprN
     (arg1 : VC;
      arg2 : System.Address;
      arg3 : int) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:366
   pragma Import (C, vc_bvConcatExprN, "vc_bvConcatExprN");

   function vc_bvExtract
     (arg1 : VC;
      arg2 : Expr;
      arg3 : int;
      arg4 : int) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:367
   pragma Import (C, vc_bvExtract, "vc_bvExtract");

   function vc_bvBoolExtract
     (arg1 : VC;
      arg2 : Expr;
      arg3 : int) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:368
   pragma Import (C, vc_bvBoolExtract, "vc_bvBoolExtract");

   function vc_bvNotExpr (arg1 : VC; arg2 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:371
   pragma Import (C, vc_bvNotExpr, "vc_bvNotExpr");

   function vc_bvAndExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:372
   pragma Import (C, vc_bvAndExpr, "vc_bvAndExpr");

   function vc_bvOrExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:373
   pragma Import (C, vc_bvOrExpr, "vc_bvOrExpr");

   function vc_bvXorExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:374
   pragma Import (C, vc_bvXorExpr, "vc_bvXorExpr");

   function vc_bvLtExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:377
   pragma Import (C, vc_bvLtExpr, "vc_bvLtExpr");

   function vc_bvLeExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:378
   pragma Import (C, vc_bvLeExpr, "vc_bvLeExpr");

   function vc_bvGtExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:379
   pragma Import (C, vc_bvGtExpr, "vc_bvGtExpr");

   function vc_bvGeExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:380
   pragma Import (C, vc_bvGeExpr, "vc_bvGeExpr");

   function vc_bvSLtExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:383
   pragma Import (C, vc_bvSLtExpr, "vc_bvSLtExpr");

   function vc_bvSLeExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:384
   pragma Import (C, vc_bvSLeExpr, "vc_bvSLeExpr");

   function vc_bvSGtExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:385
   pragma Import (C, vc_bvSGtExpr, "vc_bvSGtExpr");

   function vc_bvSGeExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:386
   pragma Import (C, vc_bvSGeExpr, "vc_bvSGeExpr");

   function vc_bvSignExtend
     (arg1 : VC;
      arg2 : Expr;
      arg3 : int) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:389
   pragma Import (C, vc_bvSignExtend, "vc_bvSignExtend");

   function vc_bvUMinusExpr (arg1 : VC; arg2 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:392
   pragma Import (C, vc_bvUMinusExpr, "vc_bvUMinusExpr");

   function vc_bvPlusExpr
     (arg1 : VC;
      arg2 : int;
      arg3 : Expr;
      arg4 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:393
   pragma Import (C, vc_bvPlusExpr, "vc_bvPlusExpr");

   function vc_bv32PlusExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:394
   pragma Import (C, vc_bv32PlusExpr, "vc_bv32PlusExpr");

   function vc_bvMinusExpr
     (arg1 : VC;
      arg2 : int;
      arg3 : Expr;
      arg4 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:395
   pragma Import (C, vc_bvMinusExpr, "vc_bvMinusExpr");

   function vc_bv32MinusExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:396
   pragma Import (C, vc_bv32MinusExpr, "vc_bv32MinusExpr");

   function vc_bvMultExpr
     (arg1 : VC;
      arg2 : int;
      arg3 : Expr;
      arg4 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:397
   pragma Import (C, vc_bvMultExpr, "vc_bvMultExpr");

   function vc_bv32MultExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:398
   pragma Import (C, vc_bv32MultExpr, "vc_bv32MultExpr");

   function vc_bvUDivExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:399
   pragma Import (C, vc_bvUDivExpr, "vc_bvUDivExpr");

   function vc_bvURemExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:400
   pragma Import (C, vc_bvURemExpr, "vc_bvURemExpr");

   function vc_bvSDivExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:401
   pragma Import (C, vc_bvSDivExpr, "vc_bvSDivExpr");

   function vc_bvSRemExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:402
   pragma Import (C, vc_bvSRemExpr, "vc_bvSRemExpr");

   function vc_bvSModExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:403
   pragma Import (C, vc_bvSModExpr, "vc_bvSModExpr");

   function vc_bvLeftShiftExpr
     (arg1 : VC;
      arg2 : int;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:406
   pragma Import (C, vc_bvLeftShiftExpr, "vc_bvLeftShiftExpr");

   function vc_bvRightShiftExpr
     (arg1 : VC;
      arg2 : int;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:407
   pragma Import (C, vc_bvRightShiftExpr, "vc_bvRightShiftExpr");

   function vc_bv32LeftShiftExpr
     (arg1 : VC;
      arg2 : int;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:408
   pragma Import (C, vc_bv32LeftShiftExpr, "vc_bv32LeftShiftExpr");

   function vc_bv32RightShiftExpr
     (arg1 : VC;
      arg2 : int;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:409
   pragma Import (C, vc_bv32RightShiftExpr, "vc_bv32RightShiftExpr");

   function vc_bvVar32LeftShiftExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:410
   pragma Import (C, vc_bvVar32LeftShiftExpr, "vc_bvVar32LeftShiftExpr");

   function vc_bvVar32RightShiftExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:411
   pragma Import (C, vc_bvVar32RightShiftExpr, "vc_bvVar32RightShiftExpr");

   function vc_bvVar32DivByPowOfTwoExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:412
   pragma Import (C, vc_bvVar32DivByPowOfTwoExpr, "vc_bvVar32DivByPowOfTwoExpr");

   function vc_bvCreateMemoryArray (arg1 : VC; arg2 : Interfaces.C.Strings.chars_ptr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:415
   pragma Import (C, vc_bvCreateMemoryArray, "vc_bvCreateMemoryArray");

   function vc_bvReadMemoryArray
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr;
      arg4 : int) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:416
   pragma Import (C, vc_bvReadMemoryArray, "vc_bvReadMemoryArray");

   function vc_bvWriteToMemoryArray
     (arg1 : VC;
      arg2 : Expr;
      arg3 : Expr;
      arg4 : Expr;
      arg5 : int) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:418
   pragma Import (C, vc_bvWriteToMemoryArray, "vc_bvWriteToMemoryArray");

   function vc_tupleExprN
     (arg1 : VC;
      arg2 : System.Address;
      arg3 : int) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:426
   pragma Import (C, vc_tupleExprN, "vc_tupleExprN");

   function vc_tupleSelectExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : int) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:429
   pragma Import (C, vc_tupleSelectExpr, "vc_tupleSelectExpr");

   function vc_tupleUpdateExpr
     (arg1 : VC;
      arg2 : Expr;
      arg3 : int;
      arg4 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:432
   pragma Import (C, vc_tupleUpdateExpr, "vc_tupleUpdateExpr");

   function vc_datatypeConsExpr
     (arg1 : VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : int;
      arg4 : System.Address) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:437
   pragma Import (C, vc_datatypeConsExpr, "vc_datatypeConsExpr");

   function vc_datatypeSelExpr
     (arg1 : VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:440
   pragma Import (C, vc_datatypeSelExpr, "vc_datatypeSelExpr");

   function vc_datatypeTestExpr
     (arg1 : VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:443
   pragma Import (C, vc_datatypeTestExpr, "vc_datatypeTestExpr");

   function vc_boundVarExpr
     (arg1 : VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : Interfaces.C.Strings.chars_ptr;
      arg4 : c_Type) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:454
   pragma Import (C, vc_boundVarExpr, "vc_boundVarExpr");

   function vc_forallExpr
     (arg1 : VC;
      arg2 : System.Address;
      arg3 : int;
      arg4 : Expr) return c_Type;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:458
   pragma Import (C, vc_forallExpr, "vc_forallExpr");

   procedure vc_setTriggers
     (arg1 : VC;
      arg2 : Expr;
      arg3 : int;
      arg4 : System.Address);  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:461
   pragma Import (C, vc_setTriggers, "vc_setTriggers");

   function vc_existsExpr
     (arg1 : VC;
      arg2 : System.Address;
      arg3 : int;
      arg4 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:465
   pragma Import (C, vc_existsExpr, "vc_existsExpr");

   function vc_lambdaExpr
     (arg1 : VC;
      arg2 : int;
      arg3 : System.Address;
      arg4 : Expr) return Op;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:468
   pragma Import (C, vc_lambdaExpr, "vc_lambdaExpr");

   procedure vc_setResourceLimit (arg1 : VC; arg2 : unsigned);  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:476
   pragma Import (C, vc_setResourceLimit, "vc_setResourceLimit");

   procedure vc_assertFormula (arg1 : VC; arg2 : Expr);  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:480
   pragma Import (C, vc_assertFormula, "vc_assertFormula");

   procedure vc_registerAtom (arg1 : VC; arg2 : Expr);  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:486
   pragma Import (C, vc_registerAtom, "vc_registerAtom");

   function vc_getImpliedLiteral (arg1 : VC) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:491
   pragma Import (C, vc_getImpliedLiteral, "vc_getImpliedLiteral");

   function vc_simplify (arg1 : VC; arg2 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:494
   pragma Import (C, vc_simplify, "vc_simplify");

   function vc_query (arg1 : VC; arg2 : Expr) return int;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:505
   pragma Import (C, vc_query, "vc_query");

   function vc_checkContinue (arg1 : VC) return int;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:510
   pragma Import (C, vc_checkContinue, "vc_checkContinue");

   function vc_restart (arg1 : VC; arg2 : Expr) return int;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:515
   pragma Import (C, vc_restart, "vc_restart");

   procedure vc_returnFromCheck (arg1 : VC);  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:520
   pragma Import (C, vc_returnFromCheck, "vc_returnFromCheck");

   function vc_getUserAssumptions (arg1 : VC; arg2 : access int) return System.Address;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:528
   pragma Import (C, vc_getUserAssumptions, "vc_getUserAssumptions");

   function vc_getInternalAssumptions (arg1 : VC; arg2 : access int) return System.Address;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:535
   pragma Import (C, vc_getInternalAssumptions, "vc_getInternalAssumptions");

   function vc_getAssumptions (arg1 : VC; arg2 : access int) return System.Address;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:542
   pragma Import (C, vc_getAssumptions, "vc_getAssumptions");

   function vc_getProofAssumptions (arg1 : VC) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:547
   pragma Import (C, vc_getProofAssumptions, "vc_getProofAssumptions");

   function vc_getProofQuery (arg1 : VC) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:550
   pragma Import (C, vc_getProofQuery, "vc_getProofQuery");

   function vc_getAssumptionsUsed (arg1 : VC; arg2 : access int) return System.Address;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:558
   pragma Import (C, vc_getAssumptionsUsed, "vc_getAssumptionsUsed");

   function vc_getCounterExample (arg1 : VC; arg2 : access int) return System.Address;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:567
   pragma Import (C, vc_getCounterExample, "vc_getCounterExample");

   function vc_getConcreteModel (arg1 : VC; arg2 : access int) return System.Address;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:575
   pragma Import (C, vc_getConcreteModel, "vc_getConcreteModel");

   function vc_inconsistent
     (arg1 : VC;
      arg2 : System.Address;
      arg3 : access int) return int;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:582
   pragma Import (C, vc_inconsistent, "vc_inconsistent");

   function vc_incomplete (arg1 : VC) return Interfaces.C.Strings.chars_ptr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:590
   pragma Import (C, vc_incomplete, "vc_incomplete");

   function vc_getProof (arg1 : VC) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:593
   pragma Import (C, vc_getProof, "vc_getProof");

   function vc_getProofOfFile (arg1 : VC; arg2 : Interfaces.C.Strings.chars_ptr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:596
   pragma Import (C, vc_getProofOfFile, "vc_getProofOfFile");

   function vc_getTCC (arg1 : VC) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:600
   pragma Import (C, vc_getTCC, "vc_getTCC");

   function vc_getAssumptionsTCC (arg1 : VC; arg2 : access int) return System.Address;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:606
   pragma Import (C, vc_getAssumptionsTCC, "vc_getAssumptionsTCC");

   function vc_getProofTCC (arg1 : VC) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:610
   pragma Import (C, vc_getProofTCC, "vc_getProofTCC");

   function vc_getClosure (arg1 : VC) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:618
   pragma Import (C, vc_getClosure, "vc_getClosure");

   function vc_getProofClosure (arg1 : VC) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:622
   pragma Import (C, vc_getProofClosure, "vc_getProofClosure");

   function vc_stackLevel (arg1 : VC) return int;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:625
   pragma Import (C, vc_stackLevel, "vc_stackLevel");

   procedure vc_push (arg1 : VC);  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:628
   pragma Import (C, vc_push, "vc_push");

   procedure vc_pop (arg1 : VC);  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:631
   pragma Import (C, vc_pop, "vc_pop");

   procedure vc_popto (arg1 : VC; arg2 : int);  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:636
   pragma Import (C, vc_popto, "vc_popto");

   function vc_getCurrentContext (arg1 : VC) return System.Address;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:639
   pragma Import (C, vc_getCurrentContext, "vc_getCurrentContext");

   function vc_compare_exprs (arg1 : Expr; arg2 : Expr) return int;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:653
   pragma Import (C, vc_compare_exprs, "vc_compare_exprs");

   function vc_exprString (arg1 : Expr) return Interfaces.C.Strings.chars_ptr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:658
   pragma Import (C, vc_exprString, "vc_exprString");

   function vc_typeString (arg1 : c_Type) return Interfaces.C.Strings.chars_ptr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:660
   pragma Import (C, vc_typeString, "vc_typeString");

   function vc_isClosure (arg1 : Expr) return int;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:663
   pragma Import (C, vc_isClosure, "vc_isClosure");

   function vc_isQuantifier (arg1 : Expr) return int;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:664
   pragma Import (C, vc_isQuantifier, "vc_isQuantifier");

   function vc_isLambda (arg1 : Expr) return int;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:665
   pragma Import (C, vc_isLambda, "vc_isLambda");

   function vc_isVar (arg1 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:666
   pragma Import (C, vc_isVar, "vc_isVar");

   function vc_arity (arg1 : Expr) return int;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:668
   pragma Import (C, vc_arity, "vc_arity");

   function vc_getKind (arg1 : Expr) return int;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:669
   pragma Import (C, vc_getKind, "vc_getKind");

   function vc_getChild (arg1 : Expr; arg2 : int) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:670
   pragma Import (C, vc_getChild, "vc_getChild");

   function vc_getNumVars (arg1 : Expr) return int;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:671
   pragma Import (C, vc_getNumVars, "vc_getNumVars");

   function vc_getVar (arg1 : Expr; arg2 : int) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:672
   pragma Import (C, vc_getVar, "vc_getVar");

   function vc_getBody (arg1 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:673
   pragma Import (C, vc_getBody, "vc_getBody");

   function vc_getExistential (arg1 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:674
   pragma Import (C, vc_getExistential, "vc_getExistential");

   function vc_getFun (arg1 : VC; arg2 : Expr) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:675
   pragma Import (C, vc_getFun, "vc_getFun");

   function vc_toExpr (arg1 : c_Type) return Expr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:676
   pragma Import (C, vc_toExpr, "vc_toExpr");

   function vc_getKindString (arg1 : VC; arg2 : int) return Interfaces.C.Strings.chars_ptr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:679
   pragma Import (C, vc_getKindString, "vc_getKindString");

   function vc_getKindInt (arg1 : VC; arg2 : Interfaces.C.Strings.chars_ptr) return int;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:682
   pragma Import (C, vc_getKindInt, "vc_getKindInt");

   function vc_getInt (arg1 : Expr) return int;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:685
   pragma Import (C, vc_getInt, "vc_getInt");

   function vc_getBVInt (arg1 : VC; arg2 : Expr) return int;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:688
   pragma Import (C, vc_getBVInt, "vc_getBVInt");

   function vc_getBVUnsigned (arg1 : VC; arg2 : Expr) return unsigned;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:690
   pragma Import (C, vc_getBVUnsigned, "vc_getBVUnsigned");

   function vc_get_error_status return int;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:693
   pragma Import (C, vc_get_error_status, "vc_get_error_status");

   procedure vc_reset_error_status;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:694
   pragma Import (C, vc_reset_error_status, "vc_reset_error_status");

   function vc_get_error_string return Interfaces.C.Strings.chars_ptr;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:695
   pragma Import (C, vc_get_error_string, "vc_get_error_string");

   procedure vc_print_statistics (arg1 : VC);  -- /opt/local/include/cvc4/bindings/compat/c/c_interface.h:698
   pragma Import (C, vc_print_statistics, "vc_print_statistics");

end Cvc4 ;
