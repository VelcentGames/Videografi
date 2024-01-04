package com.HxJ.utils {
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Strong;
	import com.greensock.easing.Linear;
	import com.greensock.OverwriteManager;

	public class Transforms {

		public var Stage:Object;
		public var Clip:Object;

		public function Transforms( stage:Object, clip:Object = null ): void {
			
			Stage = stage;
			Clip = clip;
			
		}
		
		public function place( clip:Object, x:Number, y:Number, stage:Boolean = false ): void {

			if ( !stage ) x *= Stage.stageWidth, y *= Stage.stageHeight;
			if ( clip.x !== x ) clip.x = x;
			if ( clip.y !== y ) clip.y = y;

		}
		
		public function size( clip:Object, w:Number, h:Number ): void {
			
			if ( clip.width !== w ) clip.width = w;
			if ( clip.height !== h ) clip.height = h;
			
		}

		public function scale( clip:Object, x:Number, y:Number ): void {
			
			if ( clip.scaleX !== x ) clip.scaleX = x;
			if ( clip.scaleY !== y ) clip.scaleY = y;
			
		}

		public function rotate( clip:Object, deg:Number ): void {
						
			if ( clip.rotation !== deg * 360 ) clip.rotation = deg * 360;
			
		}
		
		public function alpha( clip:Object, val:Number ): void {
			
			if ( clip.alpha !== val ) clip.alpha = val;
			
		}

		public function animPlace( clip:Object, x:Number, y:Number, stage:Boolean = false, type:Number = 0, dur:Number = 2 ): void {
			
			if ( !stage ) x *= Stage.stageWidth, y *= Stage.stageHeight;
				
			if ( clip.x !== x ) TweenLite.to( clip, dur, { x : x, ease : easeType( type ), useFrames : false, overwrite : OverwriteManager.NONE });
			if ( clip.y !== y ) TweenLite.to( clip, dur, { y : y, ease : easeType( type ), useFrames : false, overwrite : OverwriteManager.NONE });
				
		}
		
		public function animSize( clip:Object, w:Number, h:Number, type:Number = 0, dur:Number = 2 ): void {

			if ( clip.width !== w ) TweenLite.to( clip, dur, { width : w, ease : easeType( type ), useFrames : false, overwrite : OverwriteManager.NONE });
			if ( clip.height !== h ) TweenLite.to( clip, dur, { height : h, ease : easeType( type ), useFrames : false, overwrite : OverwriteManager.NONE });

		}

		public function animScale( clip:Object, x:Number, y:Number, type:Number = 0, dur:Number = 2 ): void {

			if ( clip.scaleX !== x ) TweenLite.to( clip, dur, { scaleX : x, ease : easeType( type ), useFrames : false, overwrite : OverwriteManager.NONE });
			if ( clip.scaleY !== y ) TweenLite.to( clip, dur, { scaleY : y, ease : easeType( type ), useFrames : false, overwrite : OverwriteManager.NONE });

		}

		public function animRotate( clip:Object, deg:Number, type:Number = 0, dur:Number = 2 ): void {


			if ( clip.rotation !== deg * 360 ) TweenLite.to( clip, dur, { rotation : ( deg * 360 ), ease : easeType( type ), useFrames : false, overwrite : OverwriteManager.NONE });

		}

		public function animAlpha( clip:Object, val:Number, dur:Number = 2 ): void {

			if ( clip.alpha !== val ) TweenLite.to( clip, dur, { alpha : val, ease : easeType( 2 ), useFrames : false, overwrite : OverwriteManager.NONE });

		}
		
		public function to( vars:Object ) {
			
			var v:Object = {
				a : vars.a,
				c : vars.c,
				d : vars.d,
				e : vars.e,
				l : vars.l,
				t : vars.t,
				r : vars.r,
				s : vars.s,
				w : vars.w,
				h : vars.h,
				x : vars.x,
				y : vars.y,
				sx : vars.sx,
				sy : vars.sy,
				f : vars.f,
				v : vars.v
			};
			
			v.c = v.c === undefined ? Clip : v.c;
			v.t = v.t === undefined ? 2 : v.t;
			v.d = v.d === undefined ? 0 : v.d;
			if ( v.e === undefined ) v.e = v.a === undefined ? 0 : 2;
			if ( v.s === undefined ) {
				if ( v.x !== undefined ) v.x = v.x * Stage.stageWidth;
				if ( v.y !== undefined ) v.y = v.y * Stage.stageHeight;
			} else {
				if ( v.x !== undefined ) v.x =  v.x;
				if ( v.y !== undefined ) v.y = v.y;
			}
			if ( v.c.visible === false ) if ( v.v === 1 || v.a !== undefined && v.a !== 0 ) v.c.visible = true;
			if ( v.t === 0 && v.c.visible === true ) if ( v.v === 0 || v.a === 0 ) v.c.visible = false;
			if ( v.r !== undefined ) v.r = v.r * 360;
			if ( v.a !== undefined ) TweenLite.to( v.c, v.t, { alpha : v.a, ease : easeType( v.e ), delay : v.d, useFrames : false, onComplete : onComplete, overwrite : OverwriteManager.CONCURRENT });
			if ( v.r !== undefined ) TweenLite.to( v.c, v.t, { rotation : v.r, ease : easeType( v.e ), delay : v.d, useFrames : false, onComplete : onComplete, overwrite : OverwriteManager.CONCURRENT });
			if ( v.x !== undefined ) TweenLite.to( v.c, v.t, { x : v.x, ease : easeType( v.e ), delay : v.d, useFrames : false, onComplete : onComplete, overwrite : OverwriteManager.CONCURRENT });
			if ( v.y !== undefined ) TweenLite.to( v.c, v.t, { y : v.y, ease : easeType( v.e ), delay : v.d, useFrames : false, onComplete : onComplete, overwrite : OverwriteManager.NONE });
			if ( v.w !== undefined ) TweenLite.to( v.c, v.t, { width : v.w, ease : easeType( v.e ), delay : v.d, useFrames : false, onComplete : onComplete, overwrite : OverwriteManager.NONE });
			if ( v.h !== undefined ) TweenLite.to( v.c, v.t, { height : v.h, ease : easeType( v.e ), delay : v.d, useFrames : false, onComplete : onComplete, overwrite : OverwriteManager.NONE });
			if ( v.sx !== undefined ) TweenLite.to( v.c, v.t, { scaleX : v.sx, ease : easeType( v.e ), delay : v.d, useFrames : false, onComplete : onComplete, overwrite : OverwriteManager.NONE });
			if ( v.sy !== undefined ) TweenLite.to( v.c, v.t, { scaleY : v.sy, ease : easeType( v.e ), delay : v.d, useFrames : false, onComplete : onComplete, overwrite : OverwriteManager.NONE });
			
			function onComplete() {
				
				if ( v.l !== undefined ) to( vars );
				if ( v.f !== undefined ) v.f();
				if ( v.t !== 0 && v.c.visible === true ) if ( v.v === 0 || v.a === 0 ) v.c.visible = false;
					
			}
		}
		
		private function easeType( type:Number ): Function { return [ Elastic.easeOut, Strong.easeOut, Linear.easeNone ][ type ] }

	}

}