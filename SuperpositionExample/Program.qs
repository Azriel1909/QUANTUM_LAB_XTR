namespace ExploringSuperposition {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics; // Use DumpMachine
    // It gives the probability amplitude, the probability, and the phase in radians for each basis state.
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;

    @EntryPoint()
    
    operation GenerateRandomBit() : Result {
        use q = Qubit();
        Message("Initialized qubit:");
        DumpMachine();
        Message(" ");
        H(q);
        Message("Qubit after applying H:");
        DumpMachine();
        Message(" ");
        let randomBit = M(q);
        Message("Qubit after the measurement:");
        DumpMachine();
        Message(" ");
        Reset(q); // To the |0> state
        Message("Qubit after resetting:");
        DumpMachine();
        Message(" ");
        return randomBit;
    }
}

// DumpMachine - Useful for simulations