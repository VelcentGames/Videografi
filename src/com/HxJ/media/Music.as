package com.HxJ.media {
	
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import com.HxJ.utils.ArrayShuffle;

	public class Music {

		private var soundChannel:SoundChannel = new SoundChannel();
		private var soundTransform:SoundTransform = new SoundTransform();
		private var currentSound:uint = 0;
		private var soundList:Array = new Array();
		private var soundOrder:Array = new Array();
		private var soundPosition:Number = 0;
		private var isShuffle:Boolean = false;
		private var isRepeat:String = 'off';
		private var isPlay:Boolean = false;

		public function Music( list:Array, repeat:String = 'off', shuffle:Boolean = false ): void {

			soundList = list;
			isRepeat = repeat;
			isShuffle = shuffle;

			for ( var i = 0, len = soundList.length; i < len; i++ ) {

				soundOrder[ i ] = i;

			}

			if ( isShuffle ) ArrayShuffle( soundOrder );

			i = null;

		}

		private function soundLoader( url:String ): Sound {

			return new Sound( new URLRequest( url ) );

		}
			
		private function soundComplete( e:Event ) {

			soundPosition = 0;

			if ( isRepeat === 'one' ) play();

			else if ( isRepeat === 'all' ) next();

			else if ( isRepeat === 'off' ) {

				if ( currentSound === soundOrder.length - 1 ) isPlay = false;

				next();

			} else isPlay = false;

		}

		public function play( num:int = -1 ): void {

			//if ( isPlay && num === -1 ) return;

			if ( num > -1 && num < soundOrder.length ) {

				if ( isPlay ) stop();

				currentSound = soundOrder.indexOf( num );

			} 

			soundChannel = soundLoader( soundList[ soundOrder[ currentSound ] ] ).play( soundPosition, 0, soundTransform );
			
			soundChannel.addEventListener( Event.SOUND_COMPLETE, soundComplete );

			isPlay = true;

		}

		public function pause(): void {

			soundPosition = soundChannel.position;

			soundChannel.stop();

			soundChannel.removeEventListener( Event.SOUND_COMPLETE, soundComplete );

			isPlay = false;

		}

		public function stop(): void {

			soundPosition = 0;

			soundChannel.stop();

			soundChannel.removeEventListener( Event.SOUND_COMPLETE, soundComplete );

			isPlay = false;

		}

		public function next(): void {

			soundPosition = 0;

			soundChannel.stop();

			if ( currentSound === soundOrder.length - 1 ) {

				currentSound = 0;

				if ( isShuffle ) ArrayShuffle( soundOrder );

			} else currentSound++;

			if ( isPlay ) play();

		}

		public function prev(): void {

			soundPosition = 0;

			soundChannel.stop();

			if ( currentSound === 0 ) {

				currentSound = soundOrder.length - 1;

				if ( isShuffle ) ArrayShuffle( soundOrder );

			} else currentSound--;

			if ( isPlay ) play();

		}

		public function get shuffle(): Boolean {

			return isShuffle;

		}

		public function set shuffle( bool:Boolean ): void {

			if ( isShuffle === bool ) return;

			isShuffle = bool;

			var current = soundOrder[ currentSound ];

			if ( isShuffle ) ArrayShuffle( soundOrder );

			else soundOrder.sort( Array.NUMERIC );

			currentSound = soundOrder.indexOf( current );

			current = null;

		}

		public function get repeat(): String {

			return isRepeat;

		}

		public function set repeat( str:String ): void {

			if ( str === 'off' || str === 'all' || str === 'one' ) isRepeat = str;

			str = null;

		}

		public function get now(): uint {

			return soundOrder[ currentSound ];

		}

		public function get isPlaying(): Boolean {

			return isPlay;

		}

		public function get list(): Array {

			return soundList;

		}

	}

}