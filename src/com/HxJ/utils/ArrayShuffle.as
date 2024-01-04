package com.HxJ.utils {

	import com.HxJ.utils.MathRand;

	public function ArrayShuffle( arr:Array ): void {

		arr.forEach( function( val:*, i:uint, arr:Array ) {

			var r:int = MathRand( 0, i );
			
			arr[ i ] = arr[ r ];
			
			arr[ r ] = val;

		});
		
	}

}