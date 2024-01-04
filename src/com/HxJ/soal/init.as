package com.HxJ.soal {

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
	import com.HxJ.soal.quest.InitQuest;

	public class init {

		private var app:Object;
		private var root:Object;
		private var stage:Object;
		private var mcQst:Object;
		private var mcStt:Object;
		private var mcTop:Object;
		private var mcTit:Object;
		private var mcTip:Object;
		private var mcPsn:Object;
		private var btHom:Object;
		private var btQst:Object;
		private var btStt:Object;
		private var btTop:Object;
		private var btSet:Object;
		private var btBg:Object;
		private var mcBg:Object;
		private var music:Music;
		private var Trans:Transforms;
		private var isMode:uint;

		public function init( _root:Object ): void {

			app = NativeApplication.nativeApplication;
			root = _root;
			stage = root.stage;
			mcQst = root.quest;
			mcStt = root.stats;
			mcTop = root.topList;
			mcTit = root.title;
			mcTip = root.tooltip;
			mcPsn = root.pesan;
			btHom = root.bHome;
			btQst = root.bQuest;
			btStt = root.bStats;
			btTop = root.bTopList;
			btSet  = root.btSet;
			btBg  = root.bBg;
			mcBg  = root.bg;
			isMode = 0;

			stage.align = StageAlign.TOP;
			stage.scaleMode = StageScaleMode.SHOW_ALL;

			Trans = new Transforms( stage );
			music = new Music([ 'res/audio/Soal.mp3' ], 'one' );
			root.music = music;
			if ( root.settings.music ) music.play();

			initPesan();
			
			initBtn( btHom, 1, 'Home' );
			initBtn( btQst, 2, 'Soal Latihan' );
			initBtn( btStt, 3, 'Statistik' );
			initBtn( btTop, 4, 'Peringkat' );
			
			Trans.scale( btHom, 0, 0);
			Trans.scale( btQst, 0, 0);
			Trans.scale( btStt, 0, 0);
			Trans.scale( btTop, 0, 0);
			Trans.scale( mcTit, 1.5, 1.5 );
			Trans.place( mcTit, .5, .1 );
			Trans.place( mcTip, .5, .5 );
			Trans.place( btHom, .5, .5 );
			Trans.place( btQst, .5, .5 );
			Trans.place( btStt, .5, .5 );
			Trans.place( btTop, .5, .5 );
			Trans.place( btBg, .5, 1.1 );
			
			mcBg.Show();
			
			setTimeout( show, 1000 );

			new InitQuest( 'res/xml/soal.xml', function( Q:Object ) {

				mcQst.init( Q, mcStt, mcTop );

			});
			
			app.addEventListener( KeyboardEvent.KEY_DOWN, keyboardEvent );
			
		}

		private function show(): void {
			
			setTimeout( mcTit.anim, 100, 'Soal' );
			Trans.to({ c:btQst, x:3.3/8, y:3/8, sx:1, sy:1, d:.2 });
			Trans.to({ c:btStt, x:4.7/8, y:3/8, sx:1, sy:1, d:.3 });
			Trans.to({ c:btTop, x:3.3/8, y:5/8, sx:1, sy:1, d:.4 });
			Trans.to({ c:btHom, x:4.7/8, y:5/8, sx:1, sy:1, d:.5 });
			
		} 

		private function hide(): void {
			
			mcBg.Hide();
			root.btSet.hide();
			
			if( isMode === 2 ) mcQst.toRight();
			
			Trans.to({ c:mcTit, x:1/2, y:-0.1, d:.1 });
			Trans.to({ c:btQst, x:7/17, y:1.1, d:.1 });
			Trans.to({ c:btStt, x:8/17, y:1.1, d:.2 });
			Trans.to({ c:btTop, x:9/17, y:1.1, d:.3 });
			Trans.to({ c:btHom, x:10/17, y:1.1, d:.4 });
			Trans.to({ c:btBg, x:.5, y:1.1 });
			
			app.removeEventListener( KeyboardEvent.KEY_DOWN, keyboardEvent );
			
		}

		private function keyboardEvent( e:KeyboardEvent ):void {
			
			if ( e.keyCode === Keyboard.BACK ) {
										
				if ( mcQst.isProcess ) Trans.animPlace( mcPsn, .5, .5 );
				
				else goto( 0, 'Home' );
				
			}
		}
		
		private function goto( go:Number, scene:String = '' ): void {
			
			if ( scene !== '' ) {
							
				hide();

				if ( isMode === 2 ) mcQst.toRight();
				if ( isMode === 3 ) mcStt.toRight();
				if ( isMode === 4 ) mcTop.toRight();

				setTimeout( music.stop, 2000 );
				setTimeout( root.gotoAndStop, 2000, 1, scene );
				
				return;
				
			} else if ( isMode === 0 && go !== 1 ) {
				
				Trans.animPlace( mcTit, .5, 0 );
				Trans.animScale( mcTit, 1, 1 );
				Trans.animPlace( btBg, .5, 1, false, 1 );
				Trans.animScale( mcTip, .7, .7 );
				
				setTimeout( Trans.animPlace, 100, btQst, 7/17, .95 );
				setTimeout( Trans.animPlace, 200, btStt, 8/17, .95 );
				setTimeout( Trans.animPlace, 300, btTop, 9/17, .95 );
				setTimeout( Trans.animPlace, 400, btHom, 10/17, .95 );
				setTimeout( Trans.animScale, 100, btQst, .5, .5 );
				setTimeout( Trans.animScale, 200, btStt, .5, .5 );
				setTimeout( Trans.animScale, 300, btTop, .5, .5 );
				setTimeout( Trans.animScale, 400, btHom, .5, .5 );
				
			}
			
			if( go === isMode ) return;
				
			else if ( go === 1 ) {
							
				if ( mcQst.isProcess ) Trans.animPlace( mcPsn, .5, .5 );
				
				else goto( 0, 'Home' );
				
			} else if ( go === 2 ) {
				
				mcTit.anim( 'Soal Latihan' );
				
				if ( isMode === 3 ) mcStt.toRight();
				if ( isMode === 4 ) mcStt.toRight(), mcTop.toRight();

				mcQst.toShow();

				isMode = go;
				
			} else if ( go === 3 ) {
				
				mcTit.anim( 'Statistik' );
				
				if ( isMode === 0 || isMode === 2 ) mcQst.toLeft();
				if ( isMode === 4 ) mcTop.toRight();
				
				mcStt.toShow();

				isMode = go;
				
			} else if ( go === 4 ) {
				
				mcTit.anim('Peringkat');
				
				if ( isMode === 0 || isMode === 2 ) mcQst.toLeft();
				if ( isMode === 0 || isMode === 2 || isMode === 3 ) mcStt.toLeft();
							
				mcTop.toShow();

				isMode = go;
				
			}
			
		}

		private function initBtn( b:Object, go:Number, tip:String ): void {
			
			var isDown:Boolean = false;
			
			b.addEventListener( MouseEvent.MOUSE_OVER, function( e:MouseEvent ): void {
				
				setTimeout( mcTip.show, 1, tip );

				Trans.animPlace( mcTip, b.x, (b.y - b.height / 2), true, 1, 1 );
				Trans.animRotate( b.ico, 1/36, 0, 1 );
				Trans.animScale( b.bg, 1.1, 1.1, 1, 1 );
				Trans.animScale( btBg, 1.05, 1, 1, 1 );
				
			});
			
			b.addEventListener( MouseEvent.MOUSE_OUT,  function( e:MouseEvent ): void {
				
				mcTip.hide();
				
				Trans.animRotate( b.ico, 0, 0, 1 );
				Trans.animScale( b.bg, 1, 1, 1, 1 );
				Trans.animScale( btBg, 1, 1, 1, 1 );
				
				if( isDown ) isDown = false;
				
			});
			
			b.addEventListener( MouseEvent.MOUSE_DOWN,  function( e:MouseEvent ): void {
				
				Trans.animRotate( b.ico, -1/36, 0, 1 );
				
				isDown = true;
				
			});
			
			b.addEventListener( MouseEvent.MOUSE_UP,  function( e:MouseEvent ): void {
				
				if( isDown ) {
					
					Trans.animRotate( b.ico, 1/36, 0, 1 );			
					
					isDown = false;
					
				}
				
			});
			
			b.addEventListener( MouseEvent.CLICK, function( e:MouseEvent ): void {
				
				goto( go );
				
			});
			
		}

		private function initPesan(): void {
			
			Trans.place( mcPsn, .5, 1.2 );
			
			mcPsn.b1.alpha = mcPsn.b2.alpha = .7;
			
			function over( e:MouseEvent ): void {

				Trans.animAlpha( e.target, 1, .2 );
							
			}
			
			function out( e:MouseEvent ): void {
				
				Trans.animAlpha( e.target, .7, .2 );
				
			}
			
			function click( e:MouseEvent ): void {
				
				Trans.animPlace( mcPsn, .5, 1.2 );
				
			}
			
			function confirm( e:MouseEvent ): void {
				
				goto( 0, 'Home' );
				
			}
			
			mcPsn.b1.addEventListener( MouseEvent.MOUSE_OVER, over );
			mcPsn.b1.addEventListener( MouseEvent.MOUSE_OUT, out );
			mcPsn.b1.addEventListener( MouseEvent.CLICK, click );
			mcPsn.b1.addEventListener( MouseEvent.CLICK, confirm );
			mcPsn.b2.addEventListener( MouseEvent.MOUSE_OVER, over );
			mcPsn.b2.addEventListener( MouseEvent.MOUSE_OUT, out );
			mcPsn.b2.addEventListener( MouseEvent.CLICK, click );
			
		}

	}

}