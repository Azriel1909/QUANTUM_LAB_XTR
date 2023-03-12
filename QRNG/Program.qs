namespace QuantumRNG {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    // News Libraries
    open Microsoft.Quantum.Math; // Use BitSizeI
    open Microsoft.Quantum.Convert; // Use ResultArrayAsInt

    
    operation GenerateRandomBit() : Result {
        // Allocate a qubit.
        use q = Qubit();
        // Put the qubit to superposition.
        H(q);
        // It now has a 50% chance of being measured 0 or 1.
        // Measure the qubit value.
        return M(q);
    }

    operation SampleRandomNumberInRange(max : Int) : Int {
        mutable output = 0; 
        repeat {
            mutable bits = []; 
            for idxBit in 1..BitSizeI(max) { 
                set bits += [GenerateRandomBit()]; 
            }
            set output = ResultArrayAsInt(bits);
        } until (output <= max);
        return output;
    }


    @EntryPoint() // Q# compiler
    operation SampleRandomNumber() : Int {
        let max = 1000;
        Message($"Sampling a random number between 0 and {max}: ");
        return SampleRandomNumberInRange(max);
    }
}

// max - max num = 12
// nBits
// String nBits
