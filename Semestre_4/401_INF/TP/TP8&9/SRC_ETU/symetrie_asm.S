                                                                                        
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
                                                                                        
@ r0 : parametre reçu adresse                                                           
@ r1 : variable locale octet                                                            
                                                                                        
#ifndef C_SYMETRIE_OCTET                                                                
#ifndef SYMTAB                                                                          
                                                                                        
@  Version avec opérations bit à bit                                                    
                                                                                        
symetrie_octet:                                                                         
                                                                                        
#else  // SYMTAB                                                                        
                                                                                        
@ Version tabulée                                                                       
symetrie_octet:                                                                         
#endif  // SYMTAB                                                                       
#endif  // C_SYMETRIE_OCTET                                                             
@ r0 : parametre tab                                                                    
@ r1 : parametre col                                                                    
                                                                                        
#ifndef C_PERMUTER_COLS                                                                 
                                                                                        
permuter_cols:                                                                          
#endif // C_PERMUTER_COLS                                                               
                                                                                        
@ r0 : paramètre image                                                                  
                                                                                        
#ifndef C_SYMETRIE_AXE_V                                                                
symetrie_axe_v:                                                                         
                                                                                        
#endif // C_SYMETRIE_AXE_V                                                              
@ r0 : tab                                                                              
@ r1 : li                                                                               
                                                                                        
#ifndef C_PERMUTER_LIGNES                                                               
permuter_lignes:                                                                        
                                                                                        
#endif // C_PERMUTER_LIGNES                                                             
                                                                                        
@ r0 : paramètre image                                                                  
                                                                                        
#ifndef  C_SYMETRIE_AXE_H                                                               
symetrie_axe_h:                                                                         
                                                                                        
#endif   // C_SYMETRIE_AXE_H                                                            
