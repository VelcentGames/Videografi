package com.HxJ.materi {
	
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
		private var mode:Number;
		private var mcBg:Object;
		private var mcTit:Object;
		private var mcHelp:Object;
		private var btKD:Object;
		private var btSet:Object;
		private var btMod:Object;
		private var btMat_1:Object;
		private var btMat_2:Object;
		private var btMat_3:Object;
		private var btMat_4:Object;
		
		public function init( _root:Object ):void {
			
			app = NativeApplication.nativeApplication;
			root = _root;
			stage = root.stage;
			mcBg = root.bg;
			mcTit = root.title;
			mcHelp = root.mcHelp;
			btKD = root.btKD;
			btSet = root.btSet;
			btMod = root.bMode;
			btMat_1 = root.bMat_1;
			btMat_2 = root.bMat_2;
			btMat_3 = root.bMat_3;
			btMat_4 = root.bMat_4;
			mode = 0;
			
			stage.align = StageAlign.TOP;
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			
			Trans = new Transforms( stage );
			music = new Music([ 'res/audio/Materi.mp3' ], 'one' );
			root.music = music;
			if ( root.settings.music ) music.play();
			
			root.help = function():void {
				
				Trans.to({ c:mcHelp.mat_0, v: mode === 0 ? 1 : 0, t:0 });
				Trans.to({ c:mcHelp.mat_1, v: mode === 1 ? 1 : 0, t:0 });
				Trans.to({ c:mcHelp.mat_2, v: mode === 2 ? 1 : 0, t:0 });
				Trans.to({ c:mcHelp.mat_3, v: mode === 3 ? 1 : 0, t:0 });
				Trans.to({ c:mcHelp.mat_4, v: mode === 4 ? 1 : 0, t:0 });
				
				if ( mode === 2 ) {
					Trans.to({ c:mcHelp.mat_2._0, v: root.mat_2.mode === 0 ? 1 : 0, t:0 });
					Trans.to({ c:mcHelp.mat_2._1, v: root.mat_2.mode !== 0 ? 1 : 0, t:0 });
				} else if ( mode === 3 ) {
					Trans.to({ c:mcHelp.mat_3._0, v: root.mat_3.mode === 0 ? 1 : 0, t:0 });
					Trans.to({ c:mcHelp.mat_3._1, v: root.mat_3.mode !== 0 ? 1 : 0, t:0 });
				} else if ( mode === 4 ) {
					Trans.to({ c:mcHelp.mat_4._0, v: root.mat_4.mode === 0 ? 1 : 0, t:0 });
					Trans.to({ c:mcHelp.mat_4._1, v: root.mat_4.mode !== 0 ? 1 : 0, t:0 });
				}
				
				mcHelp.show();
				
			}
			
			root.stop();
			
			Trans.scale( btMod, 0, 0 );
			Trans.scale( btMat_1, 0, 0 );
			Trans.scale( btMat_2, 0, 0 );
			Trans.scale( btMat_3, 0, 0 );
			Trans.scale( btMat_4, 0, 0 );
			Trans.rotate( btMat_2, 1 / 4 );
			Trans.rotate( btMat_3, 2 / 4 );
			Trans.rotate( btMat_4, 3 / 4 );
			Trans.rotate( btMat_3._1, .5 );
			Trans.rotate( btMat_4._1, .5 );
			
			setTimeout( resize, 100 );
			setTimeout( menu_0, 1000 );
			
			mcBg.show();
			initEvent();
			
		}
		
		private function resize( e:Event = null ):void {
			
			var width:Number = stage.stageWidth;
			var height:Number = stage.stageHeight;
			
			var w:Number = width / 720;
			var h:Number = height / 480;
			var sw:Number = w > h ? w : h;
			
			Trans.scale( mcBg, sw, sw );
			Trans.place( mcBg, .5, .5 );
			
			if ( mode > 0 ) {
				
				Trans.place( mcTit, .5, 0 );
				Trans.place( btMod, width / 2, height - 13, true );
				Trans.place( btMat_1, width / 2, height - 13, true );
				Trans.place( btMat_2, width / 2, height - 13, true );
				Trans.place( btMat_3, width / 2, height - 13, true );
				Trans.place( btMat_4, width / 2, height - 13, true );
				
			} else {
				
				Trans.place( mcTit, .5, .1 );
				Trans.place( btMod, .5, 4 / 7 );
				Trans.place( btMat_1, .5, 4 / 7 );
				Trans.place( btMat_2, .5, 4 / 7 );
				Trans.place( btMat_3, .5, 4 / 7 );
				Trans.place( btMat_4, .5, 4 / 7 );
				
			}
		}
		
		private function goto( frame = 1, scene:String = null ):void {
			
			if ( scene ) {
				
				mcBg.hide();
				btKD.hide();
				btSet.hide()
				setTimeout( music.stop, 1000 );
				setTimeout( Trans.animPlace, 100, mcTit, stage.stageWidth / 2, -mcTit.height, true, 1 );
				setTimeout( Trans.animScale, 100, btMod, 0, 0, 1, 1 );
				setTimeout( Trans.animScale, 100, btMat_1, 0, 0, 1, 1 );
				setTimeout( Trans.animScale, 200, btMat_2, 0, 0, 1, 1 );
				setTimeout( Trans.animScale, 300, btMat_3, 0, 0, 1, 1 );
				setTimeout( Trans.animScale, 400, btMat_4, 0, 0, 1, 1 );
				
			}
				
			setTimeout( root.gotoAndStop, 1000, frame, scene );
		}
		
		private function menuMat():void {
			
			var width:Number = stage.stageWidth;
			var height:Number = stage.stageHeight;
			
			Trans.animPlace( mcTit, .5, 0 );
			Trans.animScale( mcTit, 1, 1 );
			Trans.animScale( btMod, .4, .4 );
			Trans.animPlace( btMod, width / 2, height - 13, true, 1 );
			Trans.animPlace( btMat_1, width / 2, height - 13, true, 1 );
			Trans.animPlace( btMat_2, width / 2, height - 13, true, 1 );
			Trans.animPlace( btMat_3, width / 2, height - 13, true, 1 );
			Trans.animPlace( btMat_4, width / 2, height - 13, true, 1 );
			
		}
		
		private function menu_0():void {
			
			mcTit.anim( 'Materi' );
			Trans.animScale( mcTit, 1.5, 1.5 );
			Trans.animPlace( mcTit, .5, .1 );
			Trans.animScale( btMod, 1, 1 );
			Trans.animPlace( btMod, .5, 4 / 7 );
			Trans.animPlace( btMat_1, .5, 4 / 7 );
			Trans.animPlace( btMat_2, .5, 4 / 7 );
			Trans.animPlace( btMat_3, .5, 4 / 7 );
			Trans.animPlace( btMat_4, .5, 4 / 7 );
			setTimeout( Trans.animScale, 100, btMat_1, 1, 1 );
			setTimeout( Trans.animScale, 200, btMat_2, 1, 1 );
			setTimeout( Trans.animScale, 300, btMat_3, 1, 1 );
			setTimeout( Trans.animScale, 400, btMat_4, 1, 1 );
			
		}
		
		private function menu_1():void {
			
			Trans.animRotate( btMat_1, 0 );
			Trans.animScale( btMat_1, .4, .4 );
			Trans.animScale( btMat_2, 0, 0 );
			Trans.animScale( btMat_3, 0, 0 );
			Trans.animScale( btMat_4, 0, 0 );
			
		}
		
		private function menu_2():void {
			
			Trans.animRotate( btMat_2, 0 );
			Trans.animScale( btMat_1, 0, 0 );
			Trans.animScale( btMat_2, .4, .4 );
			Trans.animScale( btMat_3, 0, 0 );
			Trans.animScale( btMat_4, 0, 0 );
			
		}
		
		private function menu_3():void {
			
			Trans.rotate( btMat_3._1, 0 );
			Trans.animRotate( btMat_3, 0 );
			Trans.animScale( btMat_1, 0, 0 );
			Trans.animScale( btMat_2, 0, 0 );
			Trans.animScale( btMat_3, .4, .4 );
			Trans.animScale( btMat_4, 0, 0 );
			
		}
		
		private function menu_4():void {
			
			Trans.rotate( btMat_4._1, 0 );
			Trans.animRotate( btMat_4, 0 );
			Trans.animScale( btMat_1, 0, 0 );
			Trans.animScale( btMat_2, 0, 0 );
			Trans.animScale( btMat_3, 0, 0 );
			Trans.animScale( btMat_4, .4, .4 );
			
		}
		
		private function backEvent( e:MouseEvent = null ) {
			
			if ( btKD.isOpen) return btKD.close();
			if ( mcHelp.isShow ) return mcHelp.hide();
			
			if ( mode === 0 ) {
				
				goto( 1, 'Home' );
				
				app.removeEventListener( KeyboardEvent.KEY_DOWN, keyboardEvent );
				
			} else {
				
				if ( mode === 1 ) {
					
					Trans.animPlace( root.mat_1, stage.stageWidth + root.mat_1.width, root.mat_1.y, true, 1 );
					Trans.animRotate( btMat_1, 0 );
					
				} else if ( mode === 2 ) {
					
					Trans.animPlace( root.mat_2, root.mat_2.x, root.mat_2.height * 1.5, true, 1 );
					Trans.animRotate( btMat_2, 1 / 4 );
					
				} else if ( mode === 3 ) {
					
					Trans.animPlace( root.mat_3, root.mat_3.x, root.mat_3.height * 1.5, true, 1 );
					Trans.animRotate( btMat_3, 2 / 4 );
					Trans.rotate( btMat_3._1, 1 / 2 );
					
				} else if ( mode === 4 ) {
					
					Trans.animPlace( root.mat_4, root.mat_4.x, root.mat_4.height * 1.5, true, 1 );
					Trans.animRotate( btMat_4, 3 / 4 );
					Trans.rotate( btMat_4._1, 1 / 2 );
					
				}
				
				menu_0();
				btMod.mode( mode = 0 );
				goto( 2 );
				
			}
		}
		
		private function keyboardEvent( e:KeyboardEvent ):void {
			
			if ( e.keyCode === Keyboard.BACK ) backEvent();
			
		}

		private function initEvent():void {
			
			// STAGE EVENTS
			
			stage.addEventListener( Event.RESIZE, resize );
			
			// KEYBOARD EVENTS
			
			app.addEventListener( KeyboardEvent.KEY_DOWN, keyboardEvent );
			
			// MATERI 1 EVENTS
			
			btMat_1.addEventListener( MouseEvent.MOUSE_OVER, function( e:MouseEvent ):void {
				
				if ( mode === 0 ) mcTit.anim( 'Jenis Kamera Video' );
				
			});
			
			btMat_1.addEventListener( MouseEvent.MOUSE_OUT, function( e:MouseEvent ):void {
				
				if ( mode === 0 ) mcTit.anim( 'Materi' );
				
			});
			
			btMat_1.addEventListener( MouseEvent.CLICK, function( e:MouseEvent ):void {
				
				if ( mode === 1 ) {
					
					root.gotoAndStop(2);
					root.gotoAndStop( 'Materi 1' );
				
				} else {
					
					menuMat();
					menu_1();
					btMod.mode( mode = 1 );
					goto( 'Materi 1' );
					
				}
			});
			
			// MATERI 2 EVENTS
			
			btMat_2.addEventListener( MouseEvent.MOUSE_OVER, function( e:MouseEvent ):void {
				
				if ( mode === 0 ) mcTit.anim( 'Pergerakan Kamera' );
				
			});
			
			btMat_2.addEventListener( MouseEvent.MOUSE_OUT, function( e:MouseEvent ):void {
				
				if ( mode === 0 ) mcTit.anim( 'Materi' );
				
			});
			
			btMat_2.addEventListener( MouseEvent.CLICK, function( e:MouseEvent ):void {
				
				if ( mode === 2 ) {
					
					root.gotoAndStop( 2 );
					root.gotoAndStop( 'Materi 2' );
					
				} else {
					
					menuMat();
					menu_2();
					btMod.mode( mode = 2 );
					goto( 'Materi 2' );
					
				}
			});
			
			// MATERI 3 EVENTS
			
			btMat_3.addEventListener( MouseEvent.MOUSE_OVER, function( e:MouseEvent ):void {
				
				if ( mode === 0 ) mcTit.anim( 'Bidang Pandang' );
				
			});
			
			btMat_3.addEventListener( MouseEvent.MOUSE_OUT, function( e:MouseEvent ):void {
				
				if ( mode === 0 ) mcTit.anim( 'Materi' );
				
			});
			
			btMat_3.addEventListener( MouseEvent.CLICK, function( e:MouseEvent ):void {
				
				if ( mode === 3 ) {
					
					root.gotoAndStop( 2 );
					root.gotoAndStop( 'Materi 3' );
					
				} else {
					
					menuMat();
					menu_3();
					btMod.mode( mode = 3 );
					goto( 'Materi 3' );
					
				}
			});
			
			// MATERI 4 EVENTS
			
			btMat_4.addEventListener( MouseEvent.MOUSE_OVER, function( e:MouseEvent ):void {
				
				if ( mode === 0 ) mcTit.anim( 'Sudut Pengambilan Gambar' );
				
			});
			
			btMat_4.addEventListener( MouseEvent.MOUSE_OUT, function( e:MouseEvent ):void {
				
				if ( mode === 0 ) mcTit.anim( 'Materi' );
				
			});
			
			btMat_4.addEventListener( MouseEvent.CLICK, function( e:MouseEvent ):void {
				
				if ( mode === 4 ) {
					
					root.gotoAndStop( 2 );
					root.gotoAndStop( 'Materi 4' );
					
				} else {
					
					menuMat();
					menu_4();
					btMod.mode( mode = 4 );
					goto( 'Materi 4' );
					
				}
			});
			
			// MODE EVENTS
			
			btMod.addEventListener( MouseEvent.MOUSE_OVER, function( e:MouseEvent ):void {
				
				if ( mode !== 0 ) mcTit.anim( 'Materi' );
				if ( mode === 0 ) mcTit.anim( 'Home' );
				
			});
			
			btMod.addEventListener( MouseEvent.MOUSE_OUT, function( e:MouseEvent ):void {
				
				if ( mode == 0 ) mcTit.anim( 'Materi' );
				if ( mode == 1 ) mcTit.anim( 'Jenis Kamera Video' );
				if ( mode == 2 ) mcTit.anim( 'Pergerakan Kamera' );
				if ( mode == 3 ) mcTit.anim( 'Bidang Pandang' );
				if ( mode == 4 ) mcTit.anim( 'Sudut Pengambilan Gambar' );
				
			});
			
			btMod.addEventListener( MouseEvent.CLICK, backEvent );
			
		}
	}
}
