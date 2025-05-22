#ifndef _OPERATIONS_IMAGE_H_
#define _OPERATIONS_IMAGE_H_

#include "type_image.h"

/* Calcule l'image "inverse" (négative) de l'image im1, et place le
   résultat dans l'image im2 */

void inverse_video(Image *im1, Image *im2);

#endif
