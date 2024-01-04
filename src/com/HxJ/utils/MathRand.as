package com.HxJ.utils {

	public function MathRand( start:int, end:int ): int {

		return Math.floor( Math.random() * ( end - start + 1 ) ) + start;
		
	}

}