package com.HxJ.intro {
	
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.display.StageDisplayState;
	import flash.desktop.NativeApplication;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.utils.setTimeout;
	import com.HxJ.media.Music;
	import com.HxJ.utils.Transforms;
	import com.HxJ.utils.adMob;

	public class init {
		
		private var app:Object;
		private var root:Object;
		private var stage:Object;
		private var music:Music;
		private var Trans:Transforms;
		private var mcSpl_1:Object;
		private var testList:Vector.<int>;

		public function init( _root:Object ): void {

			app = NativeApplication.nativeApplication;
			root = _root;
			stage = root.stage;
			mcSpl_1 = root.splash_1;
			
			stage.align = StageAlign.TOP;
			stage.quality = StageQuality.MEDIUM;
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			
			Trans = new Transforms( stage );
			root.settings = { music:false, help:false };
			root.music = music = new Music([ 'res/audio/Intro.mp3', 'off' ]);
			if ( root.settings.music ) music.play();
			
			new adMob( root );
			root.stop();
			initEvent();

			Trans.alpha( mcSpl_1, 0 );
			Trans.place( mcSpl_1, .5, .5 );
			Trans.scale( mcSpl_1, 1, 1 );
			Trans.animScale( mcSpl_1, .9, .9, 3, 3 );
			Trans.animAlpha( mcSpl_1, 1, .5 );
			setTimeout( Trans.animAlpha, 1000, mcSpl_1, 0, 1 );
			setTimeout( root.gotoAndStop, 3000, 1, "Home" );
			
		}
		private function initEvent():void {
			
			// KEYBOARD EVENTS
			
			app.addEventListener( Event.EXITING, function( e:Event ) { e.preventDefault() });
			
			app.addEventListener( KeyboardEvent.KEY_DOWN, function( e:KeyboardEvent ) {
				
				if ( e.keyCode === Keyboard.BACK ) e.preventDefault();
				
			});
		}
	}
}
