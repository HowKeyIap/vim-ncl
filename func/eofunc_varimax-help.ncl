THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/eofunc_varimax.shtml
THE_TITLE:eofunc_varimax

eofunc_varimax

   Rotates EOFs using the using Kaiser row normalization and the varimax criterion.

Prototype

        function eofunc_varimax (
                evec    : numeric,
                optEVX  : integer
        )

        return_val [dimsizes(evec)] :  numeric

Arguments

   evec

   A multi-dimensional array containing the EOFs to be rotated.
   optEVX

   An integer which specifies options.
    1. 0 => do nothing; use the normalized eigenvectors directly.
    2. 1 => scale the normalized eigenvectors by the square root of the associated eigenvalue and return normalized
       eigenvectors.
    3. -1 => same as optEVX=1 but returns the scaled rotated eigenvectors.

   The most common options are optEVX=1 and -1.

   For versions through 4.2.0.a034, the optEVX argument had been of type logical. For backward compatibility, NCL will
   continue to accept the logical argument. If used, optEVX=False will default to 0 and optEVX=True will default to 1.

Return value

   An array of the same size and type as evec. In addition, as of version 4.3.0, the percent variance [pcvar_varimax] and
   variance [variance_varimax] are returned as attributes of the return variable. Note: These may not be in descending order
   of percent variance explained.

Description

   Rotates EOFs using the using Kaiser row normalization and the varimax criterion. The results are identical to IMSL's
   "FROTA" routine with the parameters w = 1.0 and eps = 0.0001. Missing values are ignored.

   The Kaiser varimax rotation is a common rotation performed on atmospheric or oceanographic data. The output of
   conventional EOF analysis are spatial patterns (EOFs) and temporal series (eof_ts) that are both orthogonal. The result
   of varimax rotation upon standard EOFs are rotated EOFs that are orthonormal. However, the temporal patterns derived by
   projecting the rotated spatial patterns onto the data will not be orthogonal. This means that the there is some
   correlation between the time series expansion coefficients for each mode.

   The results may be very dependent upon the user specified number of modes used in the rotation. The "best" number of
   modes to use may have to be determined by experiment.

   The order of the returned varimax rotated EOFs is not necessarily in strict descending order as returned by eofunc or
   eofunc_varimax_Wrap. The user should use the eofunc_varimax_reorder procedure to place the returned varimax rotated EOFs
   into strict descending order.

   When to use rotation:
    1. Don't use rotation unless you know what you are doing and why you are doing it!
    2. If the EOF patterns/coefficients are sufficiently separated (see discussion of North's 'rule of thumb' in Storch and
       Zwiers [Statistical Analysis in Climate Research Cambridge Univ. Press. 1998] there may be no need to use rotation if
       the patterns can be interpreted in physical terms.
    3. If none of the patterns/coefficients are distinct then rotation may help reduce the noise and yield results that are
       more interpretable.
    4. If some are distinct and some are not then performing a rotation will mix the results.

   NOTE: If the option is set to zero, the returned [ pcvar_varimax ] will all be equal. References on rotation:



Journal articles:


Orthogonality Properties of Rotated Empirical Modes
Alberto M. Mestas-Nunez
J. Climatol. 20: 1509-1516 (2000)

Rotation of principal components
M. B. Richman
Journal of Climatology 6: 293-335 (1986)

Rotation of principal components: a reply.
M. B. Richman
Journal of Climatology 7: 511-520 (1987)

---------------------------------------

Text Books:

Statistics and Data Analysis in Geology.
John C. Davis
John Wiley and Sons, 3rd Ed, 2002.

Statistical Methods in the Atmospheric Sciences
Daniel S. Wilks
Academic Press, 2nd Ed, 2006.


   Use eofunc_varimax_Wrap if retention of metadata is desired.

See Also

   eofunc_Wrap, eofunc_varimax_Wrap, eofunc_ts, eofunc_varimax_reorder

Examples

   Example 1

   Let x be two-dimensional with dimensions variables (size = nvar) and time:
  neval  = 3                         ; calculate 3 EOFs out of 7
  ev     = eofunc(x,neval)   ; ev(neval,nvar)
  ev_rot = eofunc_varimax(ev, 1)
  ev_ROT = eofunc_varimax(ev,-1)

   Example 2

   Let x be three-dimensional with dimensions of time, lat, lon. Reorder x so that time is the rightmost dimension:
  y!0    = "time"                  ; name dimensions if not already done
  y!1    = "lat"                   ; must be named to reorder
  y!2    = "lon"

  neval  = nvar                                  ; calculate all EOFs
  ev     = eofunc(y(lat|:,lon|:,time|:),neval,False)
  ; ev(neval,nlat,nlon)
  ev_rot = eofunc_varimax(ev,  1)

   Example 3

   Let z be four-dimensional with dimensions lev, lat, lon, and time:
  neval  = 3                       ; calculate 3 EOFs out of klev*nlat*mlon
  ev     = eofunc(z,neval,False)
; ev will be dimensioned neval, level, lat, lon
  ev_rot = eofunc_varimax(ev, 1 )

   Example 4

   Calculate the EOFs at every other lat/lon point. Use of a temporary array is NOT necessary but it avoids having to
   reorder the array twice in this example:
  neval  = 5                          ; calculate 5 EOFs out of nlat*mlon
  zTemp  = z(lat|::2,lon|::2,time|:)  ; reorder and use temporary array
  ev     = eofunc(zTemp,neval,False)   ; ev(neval,nlat/2,mlon/2)
  ev_rot = eofunc_varimax(ev, 1 )

   Example 5

   Let z be four-dimensional with dimensions level, lat, lon, time. Calculate the EOFs at one specified level:
  kl     = 3                               ; specify level
  neval  = 8                               ; calculate 8 EOFs out of nlat*mlon
  ev     = eofunc(z(kl,:,:,:),neval,False)
; ev will be dimensioned neval, lat, lon
  ev_rot = eofunc_varimax(ev,  1 )

   Example 6

   Let z be four-dimensional with dimensions time, lev, lat, lon. Reorder x so that time is the rightmost dimension and
   calculate on one specified level:
  kl     = 3                             ; specify level
  neval  = 8                             ; calculate 8 EOFs out of nlat*mlon
  zTemp  = z(lev|kl,lat|:,lon|:,time|:)
  ev     = eofunc(zTemp,neval,False)
; ev will be dimensioned neval, lat, lon
  ev_rot = eofunc_varimax(ev, 1 )

   Example 7

   Area-weight the data prior to calculation. Let p be four-dimensional with dimensions lat, lon, and time. The array lat
   contains the latitudes.
; calculate the weights using the square root of the cosine of the latitude and
; also convert degrees to radians
  wgt = sqrt(cos(lat*0.01745329))

; reorder data so time is fastest varying
  pt  = p(lat|:,lon|:,time|:)         ; (lat,lon,time)
  ptw = pt                            ; create an array with metadata

; weight each point prior to calculation.
; conform is used to make wgt the same size as pt
  ptw = pt*conform(pt, wgt, 0)

  evec     = eofunc(ptw,neval,80.)
  evec_rot = eofunc_varimax(evec, 1 )


   �2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:03:16 +0800
# vim:set fdm=indent foldlevel=0:
