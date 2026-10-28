// Auteur : Philippe WAILLE   UGA

#include "commun.h"
#include "image_bits_include.h"



#ifdef C_NEG_OCTET
unsigned char neg_octet(unsigned char c) {
   return ~c;
}
#endif // C_NEG_OCTET

#ifdef C_NEG_IMAGE
void neg_image (unsigned char *address) {
  unsigned char *adr;

  for (adr=address;adr <address+BYTES;adr++) {
     *adr = neg_octet(*adr);
  }
}
#endif // C_NEG_IMAGE
