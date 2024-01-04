package com.HxJ.home {
	
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
		private var stage:Stage;
		private var music:Music;
		private var Trans:Transforms;
		private var mcBg:Object;
		private var mcTit:Object;
		private var btMat:Object;
		private var btSoal:Object;
		private var btProf:Object;
		private var btQuit:Object;

		public function init( _root:Object ):void {
			
			app = NativeApplication.nativeApplication;
			root = _root;
			stage = root.stage;
			mcTit = root.title;
			mcBg = root.bg;
			btMat = root.bMat;
			btSoal = root.bSoal;
			btProf = root.bProf;
			btQuit = root.bQuit;
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			var p:Number = 480 / stage.stageHeight;
			var sx:Number = stage.stageWidth / 720;
			var sy:Number = stage.stageHeight / 480;
			root.settings.pixel = p;
			root.settings.scaleX = sx;
			root.settings.scaleY = sy;
			root.settings.width = Math.ceil( stage.stageWidth * p );
			root.settings.height = Math.ceil( stage.stageHeight * p );
			root.settings.x = ( root.settings.width - 720 ) * -.5;
			root.settings.y = 0;

			Trans = new Transforms( stage );

			music = new Music([ 'res/audio/Home.mp3', 'one' ]);
			root.music = music;
			if ( root.settings.music ) music.play();
			
			root.help = function():void { root.mcHelp.show() }
			initEvent();
			resize()
			
			btMat.y = btSoal.y = btProf.y = btQuit.y = stage.stageHeight + ( btMat.height / 2 );
						
			setTimeout( show, 1 );
			
			//root.adMob.show("ca-app-pub-3940256099942544/6300978111", root.AdParams.SIZE_SMART_BANNER, root.AdParams.HALIGN_CENTER, root.AdParams.VALIGN_TOP); 

		}

		function show():void {
			
			mcBg.Show();
						
			setTimeout( mcTit.anim, 100, 'Teknik Pengambilan Gambar Video' );
			setTimeout( Trans.animPlace, 200, btMat, 1 / 5, 1 / 2 );
			setTimeout( Trans.animPlace, 300, btSoal, 2 / 5, 1 / 2 );
			setTimeout( Trans.animPlace, 400, btProf, 2.5 / 5, 1 / 2 );
			setTimeout( Trans.animPlace, 500, btQuit, 4 / 5, 1 / 2 );
			
		}
		
		function hide():void {
			
			setTimeout( Trans.animPlace, 100, mcTit, 1 / 2, -0.1, false, 1, 1 );
			setTimeout( Trans.animPlace, 200, btMat, 1 / 5, 1.2 );
			setTimeout( Trans.animPlace, 300, btSoal, 2 / 5, 1.2 );
			setTimeout( Trans.animPlace, 400, btProf, 2.5 / 5, 1.2 );
			setTimeout( Trans.animPlace, 500, btQuit, 4 / 5, 1.2 );
			
		}
		
		private function resize( e:Event = null ):void {
			
			var width:Number = stage.stageWidth;
			var height:Number = stage.stageHeight;
			
			var w:Number = width / 720;
			var h:Number = height / 480;
			var sw:Number = w > h ? w : h;
			var sh:Number = w > h ? h : w;
			
			Trans.place( mcTit, .5, 1 / 6 );
			Trans.place( btMat, 1 / 5, .5 );
			Trans.place( btSoal, 2 / 5, .5 );
			Trans.place( btProf, 2.5 / 5, .5 );
			Trans.place( btQuit, 4 / 5, .5 );
			Trans.place( mcBg, .5, .5 );
							
			Trans.scale( mcTit, 1.5 * sh, 1.5 * sh );
			Trans.scale( btMat, .5 * sh, .5 * sh );
			Trans.scale( btSoal, .5 * sh, .5 * sh );
			Trans.scale( btProf, .5 * sh, .5 * sh );
			Trans.scale( btQuit, .5 * sh, .5 * sh );
			Trans.scale( mcBg, sw, sw );
			
			Trans.to({ c:root.btSet, sx:sh, sy:sh, t:0 });
			
		}
		
		private function goto( scene:String ) {
			
			if ( root.mcHelp.isShow ) return root.mcHelp.hide();
			root.btSet.hide();
			setTimeout( hide, 100 );
			setTimeout( mcBg.Hide, 500 );
			setTimeout( music.stop, 2000 );
			setTimeout( root.gotoAndStop, 2000, 1, scene );
			
			app.removeEventListener( KeyboardEvent.KEY_DOWN, keyboardEvent );
			
		}
		
		private function keyboardEvent( e:KeyboardEvent ):void {
			
			if ( e.keyCode === Keyboard.BACK ) goto( 'Quit' );

		}
				
		private function initEvent():void {
			
			// STAGE EVENTS
			
			stage.addEventListener( Event.RESIZE, resize );
			
			// KEYBOARD EVENTS
			
			app.addEventListener( KeyboardEvent.KEY_DOWN, keyboardEvent );
			
			// BUTTON EVENTS
			
			btMat.addEventListener( MouseEvent.CLICK, function ( e:MouseEvent ):void { goto( 'Materi' )});
			btSoal.addEventListener( MouseEvent.CLICK, function ( e:MouseEvent ):void { goto( 'Soal' )});
			btProf.addEventListener( MouseEvent.CLICK, function ( e:MouseEvent ):void { goto( 'Profil' )});
			btQuit.addEventListener( MouseEvent.CLICK, function ( e:MouseEvent ):void { goto( 'Quit' )});
			
		}
	}
}
