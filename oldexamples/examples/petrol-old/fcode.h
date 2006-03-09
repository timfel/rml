/* interface FCode */
extern void FCode_5finit(void);
#define FCode__PROG_3dBOX2 0
#define FCode__PROG(X1,X2) (mk_box2(0,(X1),(X2)))
#define FCode__PROC_3dBOX4 0
#define FCode__PROC(X1,X2,X3,X4) (mk_box4(0,(X1),(X2),(X3),(X4)))
#define FCode__BLOCK_3dBOX3 0
#define FCode__BLOCK(X1,X2,X3) (mk_box3(0,(X1),(X2),(X3)))
#define FCode__SKIP_3dBOX0 6
#define FCode__SKIP (mk_box0(6))
#define FCode__SEQ_3dBOX2 5
#define FCode__SEQ(X1,X2) (mk_box2(5,(X1),(X2)))
#define FCode__IF_3dBOX3 4
#define FCode__IF(X1,X2,X3) (mk_box3(4,(X1),(X2),(X3)))
#define FCode__WHILE_3dBOX2 3
#define FCode__WHILE(X1,X2) (mk_box2(3,(X1),(X2)))
#define FCode__RETURN_3dBOX1 2
#define FCode__RETURN(X1) (mk_box1(2,(X1)))
#define FCode__PCALL_3dBOX2 1
#define FCode__PCALL(X1,X2) (mk_box2(1,(X1),(X2)))
#define FCode__STORE_3dBOX3 0
#define FCode__STORE(X1,X2,X3) (mk_box3(0,(X1),(X2),(X3)))
#define FCode__FCALL_3dBOX2 5
#define FCode__FCALL(X1,X2) (mk_box2(5,(X1),(X2)))
#define FCode__BINARY_3dBOX3 4
#define FCode__BINARY(X1,X2,X3) (mk_box3(4,(X1),(X2),(X3)))
#define FCode__UNARY_3dBOX2 3
#define FCode__UNARY(X1,X2) (mk_box2(3,(X1),(X2)))
#define FCode__DISPLAY_3dBOX1 2
#define FCode__DISPLAY(X1) (mk_box1(2,(X1)))
#define FCode__RCON_3dBOX1 1
#define FCode__RCON(X1) (mk_box1(1,(X1)))
#define FCode__ICON_3dBOX1 0
#define FCode__ICON(X1) (mk_box1(0,(X1)))
#define FCode__OFFSET_3dBOX2 7
#define FCode__OFFSET(X1,X2) (mk_box2(7,(X1),(X2)))
#define FCode__LOAD_3dBOX1 6
#define FCode__LOAD(X1) (mk_box1(6,(X1)))
#define FCode__PtoI_3dBOX0 5
#define FCode__PtoI (mk_box0(5))
#define FCode__TOPTR_3dBOX1 4
#define FCode__TOPTR(X1) (mk_box1(4,(X1)))
#define FCode__ItoC_3dBOX0 3
#define FCode__ItoC (mk_box0(3))
#define FCode__RtoI_3dBOX0 2
#define FCode__RtoI (mk_box0(2))
#define FCode__ItoR_3dBOX0 1
#define FCode__ItoR (mk_box0(1))
#define FCode__CtoI_3dBOX0 0
#define FCode__CtoI (mk_box0(0))
#define FCode__PEQ_3dBOX1 22
#define FCode__PEQ(X1) (mk_box1(22,(X1)))
#define FCode__PLE_3dBOX1 21
#define FCode__PLE(X1) (mk_box1(21,(X1)))
#define FCode__PLT_3dBOX1 20
#define FCode__PLT(X1) (mk_box1(20,(X1)))
#define FCode__PDIFF_3dBOX1 19
#define FCode__PDIFF(X1) (mk_box1(19,(X1)))
#define FCode__PSUB_3dBOX1 18
#define FCode__PSUB(X1) (mk_box1(18,(X1)))
#define FCode__PADD_3dBOX1 17
#define FCode__PADD(X1) (mk_box1(17,(X1)))
#define FCode__REQ_3dBOX0 16
#define FCode__REQ (mk_box0(16))
#define FCode__RLE_3dBOX0 15
#define FCode__RLE (mk_box0(15))
#define FCode__RLT_3dBOX0 14
#define FCode__RLT (mk_box0(14))
#define FCode__RDIV_3dBOX0 13
#define FCode__RDIV (mk_box0(13))
#define FCode__RMUL_3dBOX0 12
#define FCode__RMUL (mk_box0(12))
#define FCode__RSUB_3dBOX0 11
#define FCode__RSUB (mk_box0(11))
#define FCode__RADD_3dBOX0 10
#define FCode__RADD (mk_box0(10))
#define FCode__IEQ_3dBOX0 9
#define FCode__IEQ (mk_box0(9))
#define FCode__ILE_3dBOX0 8
#define FCode__ILE (mk_box0(8))
#define FCode__ILT_3dBOX0 7
#define FCode__ILT (mk_box0(7))
#define FCode__IOR_3dBOX0 6
#define FCode__IOR (mk_box0(6))
#define FCode__IAND_3dBOX0 5
#define FCode__IAND (mk_box0(5))
#define FCode__IMOD_3dBOX0 4
#define FCode__IMOD (mk_box0(4))
#define FCode__IDIV_3dBOX0 3
#define FCode__IDIV (mk_box0(3))
#define FCode__IMUL_3dBOX0 2
#define FCode__IMUL (mk_box0(2))
#define FCode__ISUB_3dBOX0 1
#define FCode__ISUB (mk_box0(1))
#define FCode__IADD_3dBOX0 0
#define FCode__IADD (mk_box0(0))
#define FCode__RECORD_3dBOX2 0
#define FCode__RECORD(X1,X2) (mk_box2(0,(X1),(X2)))
#define FCode__VAR_3dBOX2 0
#define FCode__VAR(X1,X2) (mk_box2(0,(X1),(X2)))
#define FCode__UNFOLD_3dBOX1 6
#define FCode__UNFOLD(X1) (mk_box1(6,(X1)))
#define FCode__REC_3dBOX1 5
#define FCode__REC(X1) (mk_box1(5,(X1)))
#define FCode__ARR_3dBOX2 4
#define FCode__ARR(X1,X2) (mk_box2(4,(X1),(X2)))
#define FCode__PTR_3dBOX1 3
#define FCode__PTR(X1) (mk_box1(3,(X1)))
#define FCode__REAL_3dBOX0 2
#define FCode__REAL (mk_box0(2))
#define FCode__INT_3dBOX0 1
#define FCode__INT (mk_box0(1))
#define FCode__CHAR_3dBOX0 0
#define FCode__CHAR (mk_box0(0))
