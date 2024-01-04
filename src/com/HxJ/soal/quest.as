package com.HxJ.soal {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.HxJ.utils.Transforms;
	import com.HxJ.utils.ArrayShuffle;

	public class quest extends MovieClip {

		private var Q:Object;
		private var mcCtn:MovieClip;
		private var mcMsk:MovieClip;
		private var mcDsk:MovieClip;
		private var mcHdr:MovieClip;
		private var mcHdl:MovieClip;
		private var mcStt:MovieClip;
		private var mcTop:MovieClip;
		private var btStr:MovieClip;
		private var mcNme:MovieClip;
		private var mcHlp:MovieClip;
		private var mcSlc:MovieClip;
		private var isOpen:Boolean;
		private var Trans:Transforms;
		public var isProcess:Boolean;
		public var TX:Object;

		public function quest() {

			mcCtn = content.ctn;
			mcMsk = content.msk;
			mcHdl = handler;
			mcHdr = header;
			mcNme = nama;
			mcDsk = desk;
			mcHlp = help;
			mcSlc = select;
			btStr = bStart;
			isOpen = false;
			isProcess = false;

			Trans = new Transforms( stage );
			Trans.place( this, ( stage.stageWidth + width ), y, true );
			Trans.place( mcCtn, mcCtn.x, -mcCtn.height, true );
			Trans.place( mcHdl, mcHdl.x, 0, true );
			Trans.scale( mcMsk, mcMsk.scaleX, 0 );
			Trans.alpha( mcHdr, 0 );

		}

		public function init( q:Object, stats:MovieClip, topList:MovieClip ): void {

			Q = q;
			mcStt = stats;
			mcTop = topList;
				
			mcDsk.init( Q.TT, Q.QT );

			btStr.addEventListener( MouseEvent.CLICK, function( e:MouseEvent ) {
				
				if ( !!mcNme.text() ) start();

			});
			
		}

		public function toLeft(): void {
			
			Trans.animPlace( this, -width, y, true, 1 );
			Trans.animRotate( mcHdr, -1/8, 1 );
			
		}

		public function toRight(): void {
			
			Trans.animPlace( this, ( stage.stageWidth + width ), y, true, 1 );
			Trans.animRotate( mcHdr, 1/8, 1 );
			
		}

		public function toShow(): void {
			
			Trans.animPlace( this, ( stage.stageWidth / 2 ), y, true, 1 );
			Trans.animRotate( mcHdr, 0, 0, 4 );

		}

		private function open(): void {
			
			if( isOpen ) return;
			else isOpen = true;
			
			Trans.animScale( mcMsk, mcMsk.scaleX, 1, 1, 1 );
			Trans.animPlace( mcCtn, mcCtn.x, 0, true, 1, 1 );
			Trans.animPlace( mcHdl, mcHdl.x, mcCtn.height, true, 1, 1 );
			
			Trans.rotate( mcHdr, -1/8 );
			Trans.animAlpha( mcHdr, 1, 1 );
			Trans.animRotate( mcHdr, 0, 0, 4 );
						
		}

		private function close():void {
			
			if( !isOpen ) return;
			else isOpen = false;

			Trans.animScale( mcMsk, mcMsk.scaleX, 0, 1, 1 );
			Trans.animPlace( mcCtn, mcCtn.x, -mcCtn.height, true, 1, 1 );
			Trans.animPlace( mcHdl, mcHdl.x, 0, true, 1, 1 );
			
		}
		
		private function end():void {
			trace(Q.TN);
		}

		private function start(): void {

			isProcess = true;
			open();
			
			Trans.to({ c:mcNme, a:0, t:.3 });
			Trans.to({ c:mcDsk, a:0, t:.3 });
			Trans.to({ c:btStr, a:0, t:.3 });
			
			/*	SHUFFLE QUEST
			--------------------------------------------*/
			if ( Q.RQ ) ArrayShuffle( Q.O );
			
			/*	INIT HEADER
			--------------------------------------------*/
			mcHdr.init( Q, end, mcSlc, mcHlp );

		}

	}

}

