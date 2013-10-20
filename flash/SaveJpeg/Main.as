package SaveJpeg
{
    import asfiles.encoding.*;
    import flash.display.*;
    import flash.events.*;
    import flash.external.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.utils.*;

    public class Main extends MovieClip
    {
        public var flashVar:Object;
        public var myURLLoader:URLLoader;
        public var myRequest:URLRequest;
        public var l:Loader;
        public var lInfo:Object;
        public var fVars:String;

        public function Main()
        {			
            lInfo = this.root.loaderInfo.parameters;
            fVars = "?whee=nada";
            for (flashVar in lInfo)
            {
                
                fVars = fVars + ("&" + flashVar + "=" + strReplace(lInfo[flashVar], "&", "$"));
            }
            myRequest = new URLRequest(String(lInfo["AS2MovieName"] + fVars));
            myURLLoader = new URLLoader();
            myURLLoader.addEventListener(Event.COMPLETE, onImageSent);
            l = new Loader();
            l.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
            l.load(myRequest);
            ExternalInterface.addCallback("saveJpeg", saveJpeg);			
            return;
        }// end function

        public function onComplete(event:Event)
        {
            addChild(l.content);
            l.width = stage.width;
            l.height = stage.height;
			saveJpeg();
            return;
        }// end function

        public function strReplace(param1:String, param2:String, param3:String) : String
        {
            return param1.split(param2).join(param3);
        }// end function

        public function onImageSent(event:Event) : void
        {
            //ExternalInterface.call("console.log", "sent");
            return;
        }// end function

        public function saveJpeg() : void
        {
            var _rect:Rectangle = null;
            var _matrix:Matrix = null;
            var _bmp:BitmapData = null;
            var _jpgEncoder:JPEGEncoder = null;
            var _byteArr:ByteArray = null;
            var _urlReqHead:URLRequestHeader = null;
            var _urlRequest:URLRequest = null;
            _rect = new Rectangle(0, 0, 598, 427);
            _matrix = new Matrix();
            _matrix.translate(-_rect.x, -_rect.y);
            _bmp = new BitmapData(_rect.width, _rect.height, false, 0xffffff);
            _bmp.draw(l.content, _matrix);
            _jpgEncoder = new JPEGEncoder(100);
            _byteArr = _jpgEncoder.encode(_bmp);
            _urlReqHead = new URLRequestHeader("Content-type", "application/octet-stream");
             //ExternalInterface.call("console.log", lInfo["saveImageScript"] + "?name=" + lInfo["imageName"]);
            _urlRequest = new URLRequest(lInfo["saveImageScript"] + "?name=" + lInfo["imageName"]);
            _urlRequest.requestHeaders.push(_urlReqHead);
            _urlRequest.method = URLRequestMethod.POST;
            _urlRequest.data = _byteArr;
            myURLLoader.load(_urlRequest);
            //ExternalInterface.call("console.log", "sending..");
            return;
        }// end function

    }
}
