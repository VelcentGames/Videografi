package com.HxJ.quit {
	
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
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
		private var mcBg:Object;
		private var mcTit:Object;
		private var btBack:Object;
		private var btQuit:Object;

		public function init( _root:Object ):void {
			
			app = NativeApplication.nativeApplication;
			root = _root;
			stage = root.stage;
			mcTit = root.title;
			btBack = root.bBack;
			btQuit = root.bQuit;
			mcBg = root.bg;
			
			stage.align = StageAlign.TOP;
			stage.scaleMode = StageScaleMode.SHOW_ALL;

			Trans = new Transforms( stage );
			music = new Music([ 'res/audio/Quit.mp3' ], 'one' );
			root.music = music;
			if ( root.settings.music ) music.play();
			
			initEvent();
			
			Trans.scale( btBack, 0, 0 );
			Trans.scale( btQuit, 0, 0 );
			Trans.place( mcTit, .5 , 1 / 6 );
			Trans.place( btBack, 1 / 3, 3 / 6 );
			Trans.place( btQuit, 2 / 3, 3 / 6 );
			
			Trans.to({ c:mcBg, sx:root.settings.scaleY, sy:root.settings.scaleY, t:0 });
			setTimeout( show, 100 );
			
		}

		function show():void {
		
			mcBg.Show();
			setTimeout( mcTit.anim, 100, 'Keluarkan aplikasi ?' );
			btBack.text.text = 'Tidak';
			btQuit.text.text = 'Ya';
			setTimeout( Trans.animScale, 200, btBack, 1, 1 );
			setTimeout( Trans.animScale, 300, btQuit, 1, 1 );
			
		}

		function hide():void {
			
			root.btSet.hide();
			setTimeout( Trans.animPlace, 100, mcTit, 1 / 2, -0.1, false, 1, 1 );
			setTimeout( Trans.animPlace, 200, btBack, 1 / 3, 1.2 );
			setTimeout( Trans.animPlace, 300, btQuit, 2 / 3, 1.2 );
			
		}

		private function keyboardEvent( e:KeyboardEvent ):void {
			
			if ( e.keyCode === Keyboard.BACK ) goto( 'Home' );

		}
		
		private function goto( scene:String ):void {
			
			mcBg.Hide();
			setTimeout( hide, 100 );
			setTimeout( music.stop, 2000 );
			setTimeout( root.gotoAndStop, 2000, 1, scene );
			
			app.removeEventListener( KeyboardEvent.KEY_DOWN, keyboardEvent );
			
		}

		private function initEvent():void {
						
			// KEYBOARD EVENTS
			
			app.addEventListener( KeyboardEvent.KEY_DOWN, keyboardEvent );
			
			// BUTTON EVENTS
			
			btBack.addEventListener( MouseEvent.CLICK, function ( e:MouseEvent ):void { goto( 'Home' )});
			btQuit.addEventListener( MouseEvent.CLICK, function ( e:MouseEvent ):void {
				
				goto( null );
				setTimeout( app.exit, 1000 );
			
			});
			
		}
	}
	
}
