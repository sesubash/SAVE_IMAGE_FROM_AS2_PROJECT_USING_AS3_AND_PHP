SAVE_IMAGE_FROM_AS2_PROJECT_USING_AS3_AND_PHP
=============================================

Save Image in a faster way by creating a container in AS3 and loading AS2 swf inside.

There are lot of AS2 image capture scripts out there but, when we try to capture large images using AS2 then it becomes 
horrible due to huge memory utilization. This is due to pixel by pixel RGB value collection process of AS2 screen capture
method.

When I was into a project development in AS2, I instructed to perform the image saving process much quicker. So I found 
a method to achieve that by creating an Image-saving container in AS3 and loading AS2 swf inside that AS3 Container.

By this way I was successful in creating Images much faster.

This demo loads AS2 file and captures Image in the name passed to it.

Instructions:
=============
In the save.html file I have embedded AS3 swf  using swfobject, passed the AS2 file name, image name to be saved 
and php script path (create.php here).
Find the flash source files inside the folder. You  can change the dimension of the rectangular area to be captured 
according to your project requirement in the file Main.as in the location SaveJpeg/Main.as.
