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
            for indexBit in 1..BitSizeI(min) {
                set bits = bits + [ramdomNumberGenerator()];
            }
            set output = ResultArrayAsInt(bits);
        } until (output >= min and output <= max );
        Message($"Random number between {min} and {max} ->  ");
        return output;
    }

    // Phase 1: Compute gcd(a, N) 
    function euclideanAlgoGCD(a: BigInt, N: BigInt) : BigInt {
        Message($"GCD of {a} and {N} ->  ");
        return GreatestCommonDivisorL((a),(N));
    }

    // Phase 1: Compute gcd(a, N) Usig Recursion
    operation euclideanAlgoGCDIm(a: Int, N: Int) : Int {
        if((N) == 0) {
            return a;
        }  Message($"GCD of {a} -> "); 
        return euclideanAlgoGCDIm((N), (a) % (N));
    }

    // Phase 1: Compute gcd(a, N) Usig Original Euclidean Algo
    operation euclideanAlgoGCDImp2(a: Int, N: Int) : Int {
        if((a) == 0) {
            return (N);
        } if ((N) == 0) {
            return (a);
        } if ((a) == (N)) {
            return (a);
        } if ((a) > (N)) {
            Message($"GCD of {a} and {N} -> "); 
            return euclideanAlgoGCDImp2((a)-(N), (N));
        }
        return euclideanAlgoGCDImp2((a), (N)-(a));
    }
    // If gcd(a, N) ≠ 1, then there is a nontrivial factor of N, so we are done.
    // The GCD of a and N is 1
    operation PhaseEstimation(a: Int, p: Int, N: Int) : Int {
        return ExpModI((a),(p),(N));
        
    }
}
