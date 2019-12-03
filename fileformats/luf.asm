;========================================
;  Magic (LUF)                         3B
;----------------------------------------
;  Flags:                              1B
;
;    0-2 = *Tamanho dos campos (x2)    3b
;    3-6 = Reservado (0)               4b
;    7   = Little Endian               1b
;----------------------------------------
;  **Tipo de hash                      1B
;
;    0-3 = Cabeçalho                   4b
;    4-7 = Arquivo                     4b
;----------------------------------------
;  ***Tamanho do identificador         1B
;----------------------------------------
;  Tamanho do header*                  xB
;----------------------------------------
;  Tamanho do arquivo*                 xB
;----------------------------------------
;  Hash header**                       xB
;----------------------------------------
;  Hash arquivo**                      xB
;----------------------------------------
;  Identificador***                    xB
;========================================


struc LUFStuct
  .Sign       resb  3
  .Flags      resb  1
  .Hashs      resb  1
  .ID_Size    resb  1
endstruc
