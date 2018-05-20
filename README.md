Author: Nakis Panagiotis<br />
Email: pnakis@hotmail.com; gst1607@teiath.gr<br />
Date: 2014<br />

LICENSE: This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

INSTALLATION:
1) Copy ortho_fcn folder at your root Matlab installation location. e.g. C:\Programs\MATLAB\ortho_fcn
2) For Matlab versions < 2011b: in the basic menu, File -> Set Path...
   For Matlab versions > 2012a: in the Home panel select "Set Path..."
3) Select "Add Folder..."
4) Select ortho_fcn folder path (see step one) e.g C:\Programs\MATLAB\ortho_fcn
5) Save
6) Close

Data types:
Image (.tif, .jpg, .png, .bmp)<br />
DTM (.txt as TIN {X Y Z} or Grid format)<br />
Intrinsic and exterior orientations as a .txt file (e.g. given in the Data folder)<br />

Usage:
1) Enter "ortho" in the console without quotation marks
2) Load Image (Image -> Load Image)
3) Load Intrinsic parameters (Camera Orientation -> Load Interior Orientation)<br />
3a. If the input image is a scanned image, the 6 affine coefficients must be known, or, the fiducial marker coordinates in order for them to be calculated (these parameters are a part of the Intrinsic .txt, e.g. given in the Data folder)<br />
3b. If the input image is product of a digital camera, the sensor pixel size must be given<br />
4) Load Exterior Orientation parameters (Camera Orientation -> Load Exterior Orientation)
5) Load the DTM .txt file (DTM -> Load DTM)<br />
5a. If the dtm.txt file is in a grid format the top left corner and the step of the grid must be given (Y max, X min, DTM D)<br />
5b. If the dtm.txt file is in a TIN format {X Y Z}, the above are calculated automatically<br />
6) Select Interpolation method (Nearest Neighbor, Bilinear or Bicubic)
7) Enter the desired grounder size
8) Rectify the image pressing the "Orthorectification" button

Intrinsic and Exterior parameters can be also be given manualy from the Manual Input menu

Examples of the above data structures can be found in the Data folder




