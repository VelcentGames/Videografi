package com.HxJ.utils {

	import studio.manja.ads.admob.*;

	public class adMob {

		private var admob:AdMob;

		public function adMob( _root:Object ):void {

			_root.adMob = init();
			_root.AdParams = AdParams;
		}

		private function init():AdMob {

			admob = new AdMob();
			
			admob.addEventListener(AdEvent.INIT_OK, onEvent);
			admob.addEventListener(AdEvent.INIT_FAIL, onEvent);
			admob.addEventListener(AdEvent.BANNER_SHOW_OK, onEvent);
			admob.addEventListener(AdEvent.BANNER_SHOW_FAIL, onEvent);
			admob.addEventListener(AdEvent.BANNER_LEFT_APP, onEvent);
			admob.addEventListener(AdEvent.BANNER_OPENED, onEvent);
			admob.addEventListener(AdEvent.BANNER_CLOSED, onEvent);
			admob.addEventListener(AdEvent.INTERSTITIAL_SHOW_OK, onEvent);
			admob.addEventListener(AdEvent.INTERSTITIAL_SHOW_FAIL, onEvent);
			admob.addEventListener(AdEvent.INTERSTITIAL_CACHE_OK, onEvent);
			admob.addEventListener(AdEvent.INTERSTITIAL_CACHE_FAIL, onEvent);
			admob.addEventListener(AdEvent.INTERSTITIAL_LEFT_APP, onEvent);
			admob.addEventListener(AdEvent.INTERSTITIAL_OPENED, onEvent);
			admob.addEventListener(AdEvent.INTERSTITIAL_CLOSED, onEvent);
			admob.addEventListener(AdEvent.REWARDED_CACHE_FAIL, onEvent);
			admob.addEventListener(AdEvent.REWARDED_CACHE_OK, onEvent);
			admob.addEventListener(AdEvent.REWARDED_CLOSED, onEvent);
			admob.addEventListener(AdEvent.REWARDED_COMPLETED, onEvent);
			admob.addEventListener(AdEvent.REWARDED_LEFT_APP, onEvent);
			admob.addEventListener(AdEvent.REWARDED_OPENED, onEvent);
			admob.addEventListener(AdEvent.REWARDED_REWARDED, onEvent);
			admob.addEventListener(AdEvent.REWARDED_STARTED, onEvent);
			admob.init();

			return admob;
			
		}

		private function onEvent( ae:AdEvent ):void {
			
			trace( ae.type+" "+ae._data );
			
		}

	}
}