@  Importation des,constantes symboliques WIDTH, HEIGHT, BYTES, BYTES_PER_LINE          
#include "image_bits_include.h"                                                                                                                                               
                 .global symetrie_octet                                                 
                 .global permuter_cols                                                  
                 .global symetrie_axe_v                                                 
                 .global permuter_ligne                                                 
                 .global symetrie_axe_h                                                 
                 .global symetrie_axe_h                                                 
                 .global permuter_lignes                                                
                 .global symetrie_axe_v                                                 
                                                                                        
                 .text                                                                                                                                                          
                                                                                        
#ifndef C_SYMETRIE_OCTET                                                                
#ifndef SYMTAB                                                                          
@ r0 : parametre reçu adresse                                                           
@ r1 : variable locale octet                                                            
@  Version avec opérations bit à bit                                                    
symetrie_octet:                                                                         
                                                                                        
#else  // SYMTAB                                                                        
                                                                                        
@ Version tabulée                                                                       
symetrie_octet:  
    
#endif  // SYMTAB                                                                       
#endif  // C_SYMETRIE_OCTET                                                             
                                                                                        
#ifndef C_PERMUTER_COLS                                                                 
@ r0 : parametre tab                                                                    
@ r1 : parametre col                                                                    
permuter_cols:                                                                          

#endif // C_PERMUTER_COLS                                                               
                                                                                        
#ifndef C_SYMETRIE_AXE_V                                                                
@ r0 : paramètre image                                                                  
symetrie_axe_v:                                                                         
                                                                                        
#endif // C_SYMETRIE_AXE_V                                                              
                                                                                        
#ifndef C_PERMUTER_LIGNES                                                               
@ r0 : tab                                                                              
@ r1 : li                                                                               
permuter_lignes:                                                                        
                                                                                        
#endif // C_PERMUTER_LIGNES                                                             
                                                                                                                                                                                
#ifndef  C_SYMETRIE_AXE_H                                                               
@ r0 : paramètre image                                                                  
symetrie_axe_h:                                                                         
                          
          bx  lr   
#endif   // C_SYMETRIE_AXE_H    