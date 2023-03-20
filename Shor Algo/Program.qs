namespace Shor_Algo {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Oracles;
    open Microsoft.Quantum.Random;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Characterization;


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
    // Phase 1: Compute the period-finding to find 'r'
    // f(x) = a^x mod N

    operation phaseEstimation (randomGenerator: Int, module: Int ) : Int {
        // ! https://learn.microsoft.com/en-us/qsharp/api/qsharp/microsoft.quantum.diagnostics.fact
        Fact(IsCoprimeI(randomGenerator,module),"The guess number is `randomGenerator`, and the mudule is `module`.");

        // Storing the r found. 
        mutable result = 1;

        // Number of bits in the mudule 
        let bits = BitSizeI(module);

        let bitsPrecision = 2 * bits + 1;

        mutable frequencyEstimation = 0;

        set frequencyEstimation = EstimateFrequencyValue (randomGenerator, module,bits);
        
        if  frequencyEstimation != 0 {
            set result = periodFrequency (module, frequencyEstimation, bitsPrecision, result);
        } else {
            Message("Estimated frecuency was 0.");
        }
        return result;
    }

    operation periodFrequency (module : Int, frequencyEstimation : Int, bitsPrecision: Int, currentDivisor: Int) : Int {
        // ! https://learn.microsoft.com/en-us/qsharp/api/qsharp/microsoft.quantum.math.continuedfractionconvergenti
        // Finds the continued fraction convergent closest to fraction with the denominator less or equal to denominatorBound
        let (s, r) = (ContinuedFractionConvergentI(Fraction(frequencyEstimation, 2 ^ bitsPrecision), module))!;
        let (sAbsolute, rAbsolute) = (AbsI(s), AbsI(r));
        //  Computes the greatest common divisor of two integers.
        return(rAbsolute * currentDivisor) / GreatestCommonDivisorI(currentDivisor, rAbsolute);
    } 

    operation EstimateFrequencyValue (randomGenerator : Int, module: Int, bits : Int) : Int {   
        mutable frequencyEstimation = 0;
        // ! https://learn.microsoft.com/fr-fr/qsharp/api/qsharp/microsoft.quantum.characterization.robustphaseestimation?view=qsharp-preview
        let bitsPrecision = 2 * bits + 1;

        // ! https://learn.microsoft.com/en-us/azure/quantum/concepts-advanced-matrices
        use eigenStateRegister = Qubit[bits];
        
        // ! https://learn.microsoft.com/en-us/qsharp/api/qsharp/microsoft.quantum.arithmetic.littleendian
        let eigenStateRegisterLittleEndian = LittleEndian(eigenStateRegister);

        // Applying a bitwise-XOR operation between a classical integer and an integer represented by a register of qubits.
        ApplyXorInPlace(1, eigenStateRegisterLittleEndian);
        let oracle = applyFindingOracle(randomGenerator, module, _, _);

        // * QFT to estimate the frequency
        use a = Qubit();
        for index in bitsPrecision -1..-1..0 {
            within {
                H(a);
            } apply {
                Controlled oracle([a], (1 <<< index, eigenStateRegisterLittleEndian!));
                // Applying a rotation about the |1> state by an angle specified as a dyadic fraction.
                // ! https://learn.microsoft.com/en-us/qsharp/api/qsharp/microsoft.quantum.intrinsic.r1frac
                R1Frac(frequencyEstimation, bitsPrecision - 1 - index, a);
            } if MResetZ(a) == One {
                set frequencyEstimation += 1 <<< (bitsPrecision - 1 - index);
            }
        }
        // Measuring the qubits and ensure they are in the |0⟩ state such that they can be safely released.
        ResetAll(eigenStateRegister);
        return frequencyEstimation;
    }

    operation applyFindingOracle (randomGenerator : Int, module: Int, power : Int, target: Qubit[] ) : Unit is Adj + Ctl{
        Fact(IsCoprimeI(randomGenerator,module),"The guess number is `randomGenerator`, and the mudule is `module`.");

        // ! https://learn.microsoft.com/en-us/qsharp/api/qsharp/microsoft.quantum.arithmetic.multiplybymodularinteger

        // Performing modular multiplication by an integer constant on a qubit register.
        MultiplyByModularInteger(ExpModI(randomGenerator, power, module),module, LittleEndian(target));
    }


    operation shorImplementatonTest (n: Int): (Int, Int) {
        // Trivial case: Even number
        if n % 2 == 0 {
            // Checking if there is a even number.
            Message("Even number.");
            return (n/2, 2);
        }
        
        // Set up the unknown factors and set the default values.
        mutable setUpFactors = false;
        mutable defaultFactors = (1,1); 

        // ! https://learn.microsoft.com/en-us/qsharp/api/qsharp/microsoft.quantum.random.drawrandomint
        repeat {
            let randomGenerator =  DrawRandomInt(2, n - 1); // ? IBM(2, N-1),  MICROSOT(1 < a < N-1)
            // ! https://learn.microsoft.com/es-mx/qsharp/api/qsharp/microsoft.quantum.math.iscoprimei
            if IsCoprimeI (randomGenerator,n) {
                Message($"Guess number: {randomGenerator}");
                let r = phaseEstimation(randomGenerator, n);
                set (setUpFactors,defaultFactors) = possibleFactorsR(n, randomGenerator, r);
            }  else {
                let GCD = GreatestCommonDivisorI(n,randomGenerator);
                Message($"Divisor guessed: {n} GCD: {GCD}.");
                set setUpFactors = true;
                set defaultFactors = (GCD, n/ GCD);
            }
        } until setUpFactors 
        fixup {
        Message("The estimated period did not return a valid factor.");
        }
        return defaultFactors;
    }

    operation possibleFactorsR (module: Int, randomGenerator: Int, r:Int) : (Bool, (Int, Int)) {
        if r % 2 == 0 {
            let halfExponentiation = ExpModI(randomGenerator, r/2, module);
            if halfExponentiation != module - 1 {
                let factor = MaxI (
                    GreatestCommonDivisorI(halfExponentiation - 1, module),
                    GreatestCommonDivisorI(halfExponentiation + 1, module)
                );
                return (true, (factor, module / factor));
            } else {
                return (false, (1,1));
            }
        } else {
        return(false, (1,1));
        } 
    }
}