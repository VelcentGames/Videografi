package com.HxJ.profil {
	
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.MovieClip;
	import flash.desktop.NativeApplication;
	import flash.utils.setTimeout;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import com.HxJ.media.Music;
	import com.HxJ.utils.Transforms;

	public class init {

		private var app:Object;
		private var root:Object;
		private var stage:Object;
		private var music:Music;
		private var Trans:Transforms;
		private var mcBg:MovieClip;
		private var mcTit:MovieClip;
		private var mcProf:MovieClip;
		private var btHome:MovieClip;
		private var btBack:MovieClip;
		private var btNext:MovieClip;
		private var btSet:MovieClip;
		private var p:Number;
		private var x:Number;
		private var y:Number;
		private var w:Number;
		private var h:Number;
		private var sx:Number;
		private var sy:Number;

		public function init( _root:Object ):void {
			
			app = NativeApplication.nativeApplication;
			root = _root;
			stage = root.stage;
			mcTit = root.title;
			mcBg = root.bg;
			mcProf = root.profil;
			btHome = root.bHome;
			btBack = root.bBack;
			btNext = root.bNext;
			btSet = root.btSet;
			x = root.settings.x;
			y = root.settings.y;
			w = root.settings.width;
			h = root.settings.height;
			sx = root.settings.scaleX;
			sy = root.settings.scaleY;
			p = root.settings.pixel;
			
			stage.align = StageAlign.TOP;
			stage.scaleMode = StageScaleMode.SHOW_ALL;

			Trans = new Transforms( stage );
			music = new Music([ 'res/audio/Profil.mp3' ], 'one' );
			root.music = music;
			if ( root.settings.music ) music.play();
			
			resize()
			initEvent();
			
			Trans.to({ c:btHome, sx:0, sy:0, t:0 });
			Trans.to({ c:mcProf, y:h+mcProf.height/2, s:1, t:0 });
			Trans.to({ c:btBack, x:x-btBack.width*p, t:0, s:1 });
			Trans.to({ c:btNext, x:x+w+btNext.width*p, t:0, s:1 });
			
			setTimeout( show, 500 );

		}
		
		function show():void {
									
			setTimeout( mcTit.anim, 100, 'Profil' );
			Trans.to({ c:mcProf, y:.5, t:1, e:1, d:.5 });
			Trans.to({ c:btHome, sx:1, sy:1, t:1, e:1, d:1 });
			Trans.to({ c:btBack, x:1/15, e:1, d:1 });
			Trans.to({ c:btNext, x:14/15, e:1, d:1 });
			mcBg.Show();
			
		}
		
		function hide():void {
			
			Trans.to({ c:mcTit, x:.5, y:-.1, t:1, e:1, d:.1 });
			Trans.to({ c:mcProf, y:h+mcProf.height/2, s:1, t:1, e:1 });
			Trans.to({ c:btHome, sx:0, sy:0, e:1 });
			Trans.to({ c:btBack, x:x-btBack.width*p, e:1, s:1 });
			Trans.to({ c:btNext, x:x+w+btNext.width*p, e:1, s:1 });
			btSet.hide();
			
		}
		
		private function resize( e:Event = null ):void {
						
			Trans.place( mcTit, .5, 0 );
			Trans.place( mcBg, .5, .5 );
			Trans.scale( mcTit, 1.5, 1.5 );
								
		}
		
		private function goto( scene:String ):void {
			
			setTimeout( hide, 100 );
			setTimeout( mcBg.Hide, 500 );
			setTimeout( music.stop, 2000 );
			setTimeout( root.gotoAndStop, 2000, 1, scene );
			
			app.removeEventListener( KeyboardEvent.KEY_DOWN, keyboardEvent );
			
		}
		
		private function keyboardEvent( e:KeyboardEvent ):void {
			
			if ( e.keyCode === Keyboard.BACK ) goto( 'Home' );

		}
		
		private function initEvent():void {
			
			// STAGE EVENTS
			
			stage.addEventListener( Event.RESIZE, resize );
			
			// KEYBOARD EVENTS
			
			app.addEventListener( KeyboardEvent.KEY_DOWN, keyboardEvent );
			
			// BUTTON EVENTS
			
			btHome.addEventListener( MouseEvent.CLICK, function() { goto( 'Home' ) });
			btBack.addEventListener( MouseEvent.CLICK, function() { root.profil.next() });
			btNext.addEventListener( MouseEvent.CLICK, function() { root.profil.back() });
			
		}
	}
}
