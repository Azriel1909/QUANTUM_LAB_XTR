namespace Shor_Algo {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;

    // Shor's algorithm classical part 
    // Phase 1: Pseudo Random Number Generator
    operation ramdomNumberGenerator() : Result {
        use q1 = Qubit();
        H(q1);
        return M(q1);
    }

    @EntryPoint()
    operation randomNumberRange(min: Int, max: Int) : Int {
        mutable output = 0;
        repeat { // Loop to generate random numbers until it generates one that's equal or less than max or equal or more than min
            mutable bits = [];
            for indexBit in 1..BitSizeI(max) { // Returns the number of bits required
                set bits = bits + [ramdomNumberGenerator()];
            }
            for indexBit in 1..BitSizeI(min){
                set bits = bits + [ramdomNumberGenerator()];
            }
            set output = ResultArrayAsInt(bits);
        } until (output >= min and output <= max );
        return output;
    }
}
