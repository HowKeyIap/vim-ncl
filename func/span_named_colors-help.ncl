THE_URL:https://www.ncl.ucar.edu/Document/Graphics/Interfaces/span_named_colors.shtml
THE_TITLE:span_named_colors

span_named_colors

   Returns an RGB array that is a span between given list of named colors.

   [new.gif] Available in version 6.0.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

        function span_named_colors (
                colors [*] : string,
                opt    [1] : logical
        )

Arguments

   colors

   A string array of named colors.
   opt

   A scalar logical that can contain an optional list of attributes.

Return value

   A float array of size n x 3 is returned, where n depends on the number of colors input, and the desired number of colors
   between each.

Description

   This function returns an RGB array that spans between the given list of named colors. The colors are span using internal
   calls to rgbhsv.

   By default, a color table with 256 or fewer colors is returned, with an equal number of colors between each set of named
   colors. The background color will be set to white, the foregound color to black.

   If opt is set to True, then you can optionally set the following resources

   BackgroundColor
          Set to a desired named color if you want something other than white.

   ForegroundColor
          Set to a desired named color if you want something other than black.

   NumColorsInTable
          The maximum number of colors to return. The default is 256.

   NumColorsInRange
          Set to an integer array indicating the number of colors you want between each range of named colors. This array
          must be of length n-1, were n is the number of named colors input.

See Also

   draw_color_palette, namedcolor2rgb, gsn_define_colormap, gsn_draw_named_colors

Examples

   Example 1

   Create a color table that spans between five named colors. Use draw_color_palette and gsn_draw_colormap to draw the
   colors using two different methods.

   Note that using gsn_draw_colormap requires that you first set the color to the workstation using gsn_define_colormap.

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

;---Open an X11 window for drawing graphics.
wks = gsn_open_wks("x11","colormap")

;----Five colors
colors = (/"SandyBrown","IndianRed","LightBlue","Purple","Yellow"/)

rgb_array = span_named_colors(colors,False)

;---Draw colors using one method
draw_color_palette(wks,rgb_array,False)

;---Draw colors using a second method
gsn_define_colormap(wks,rgb_array)
gsn_draw_colormap(wks)

   Example 2

   Using the same set of named colors, this time indicate the number of colors you want in each range.

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

begin
;---Open an X11 window for drawing graphics.
  wks = gsn_open_wks("x11","colormap")

;----Five colors
  colors = (/"SandyBrown","IndianRed","LightBlue","Purple","Yellow"/)

  opt = True
  opt@NumColorsInRange = (/5,20,50,20/)

  rgb_array = span_named_colors(colors,opt)

  gsn_define_colormap(wks,rgb_array)
  gsn_draw_colormap(wks)
end

   See also the suite of color and color map examples.


   �2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:24:01 +0800
# vim:set fdm=indent foldlevel=0:
