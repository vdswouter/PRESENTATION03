package be.devine.cp3.tasks
{
import flash.display.Bitmap;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.events.Event;
import flash.net.URLRequest;

public class LoaderTask extends Loader
	{
		// Properties
		private var url:String;
		public var loadedImg:Bitmap;
		
		// Constructor
		public function LoaderTask( url:String ) {
			
			this.url = url;
		}
		
		//Methods
		public function start():void {
			
			//trace("[LOADERTASK]: start");
			contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler );
			load( new URLRequest(url) );
		}
		
		private function completeHandler( e:Event ):void {
			
			//trace("[LOADERTASK]: Complete handler");
			var loaderInfo:LoaderInfo = e.currentTarget as LoaderInfo;
			loadedImg = Bitmap(loaderInfo.content);
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}	
}