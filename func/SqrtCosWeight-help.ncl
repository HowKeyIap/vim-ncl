THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/SqrtCosWeight.shtml
THE_TITLE:SqrtCosWeight

SqrtCosWeight

   Performs square-root of the cosine of the latitude weighting on the given array.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function SqrtCosWeight (
                y  : numeric
        )

        return_val [dimsizes(y)] :  typeof(y)

Arguments

   y

   An array of any numeric type that has at least two dimensions. The name of the latitude dimension is assumed to be "lat".
   The rightmost dimension is assumed to be longitude. Acceptable dimension orders are
   (lat,lon),(time,lat,lon),(time,?,lat,lon), (time,?,?,lat,lon).

Return value

   The results are returned in an array the same size and dimensionality as y.

Description

   This function performs square-root of the cosine of the latitude weighting on the given array. You can use it to
   overwrite the original array:
   x = SqrtCosWeight(x)

   At each latitude, this function calculates the square-root of the cosine of the latitude, and multiplies that result
   times the input data array at that particular latitude. A snippet from the coding:

   pi = 4.*atan(1.0)
   rad = (pi/180.)
   coslat = cos(x&lat*rad)    ; input array = x
   sqrtcos = sqrt(coslat)

   dims = dimsizes(x)
   numdims =dimsizes(dims)
   nlat = dims(numdims-2)

   if (numdims.eq.3) then
      do b = 0,nlat-1
         x(:,b,:) = x(:,b,:)*sqrtcos(b)
      end do
   end if

See Also

   NewCosWeight


   �2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:20:08 +0800
# vim:set fdm=indent foldlevel=0:
