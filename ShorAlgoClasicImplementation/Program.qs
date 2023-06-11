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
    operation RNG() : Result { // * Random Number Generator
        use q1 = Qubit();
        H(q1);
        let measuredQubit = M(q1);
        return measuredQubit;
    }

    
    operation RNM (min: Int, max: Int) : Int { // Random Number Machine
        mutable output = 0;
        repeat {
            mutable bits = [];
            for indexBit in 1..BitSizeI(max) {
                set bits = bits + [RNG()];
            }
            for indexBit in 1..BitSizeI(min) {
                set bits = bits + [RNG()];
            }
            set output = ResultArrayAsInt(bits);
        } until (output >= min and output <= max );
        Message($"Número aleatorio entre {min} y {max}: ");
        return output;
    }

    // Phase 1: Compute gcd(a, N) Usig Original Euclidean Algorithm
    operation GCD_M3(a: Int, N: Int) : Int { 
    // * The Euclidean Algorithm: GCD Method 3
        if((a) == 0) { 
            return (N);
        } if ((N) == 0) {
            return (a);
        } if ((a) == (N)) {
            return (a);
        } if ((a) > (N)) {
            Message($"GCD de {a} y {N}:");
            return GCD_M3((a)-(N), (N));
        } 
        return GCD_M3((a), (N)-(a));
    }

    // If gcd(a, N) ≠ 1, then there is a nontrivial factor of N, so we are done.
    // The GCD of a and N is 1
    // Phase 1: Compute the period-finding to find 'r'
    // f(x) = a^x mod N

    // Phase 2: Compute The Finding Possible Factors Algorithm
    operation FPF (module: Int, randomGenerator: Int, r:Int) : (Bool, (Int, Int)) { // Finding Possible Factors Algorithm
        if r % 2 == 0 { // r = period
            let halfExponentiation = ExpModI(randomGenerator, r/2, module);
            if halfExponentiation != module - 1 {
                let factor = MaxI (
                    GCD_M3(halfExponentiation - 1, module),
                    GCD_M3(halfExponentiation + 1, module)
                );
                return (true, (factor, module / factor));
            } else {
                return (false, (1,1));
            }
        } else {
        return(false, (1,1));
        } 
    }

    // Phase 3: Finding The Oracle Algorithm
    operation FTO (randomGenerator : Int, module: Int, power : Int, target: Qubit[] ) : Unit is Adj + Ctl {
        // Finding The Oracle Algorithm
        Fact(IsCoprimeI(randomGenerator,module),"El número aleatorio es `randomGenerator`, y el modulo es `module`.");
        MultiplyByModularInteger(ExpModI(randomGenerator, power, module),module, LittleEndian(target));
    }

    operation periodFrequency (module : Int, frequencyEstimation : Int, bitsPrecision: Int, currentDivisor: Int) : Int {
        let (s, r) = (ContinuedFractionConvergentI(Fraction(frequencyEstimation, 2 ^ bitsPrecision), module))!;
        let (sAbsolute, rAbsolute) = (AbsI(s), AbsI(r));
        return (rAbsolute * currentDivisor) / GCD_M3(currentDivisor, rAbsolute);
    } 

    // Phase 4: Compute The Estimate Frequency Value Algorithm
    operation EFV (randomGenerator : Int, module: Int, bits : Int) : Int {
    // Estimate Frequency Value Algorithm

    mutable frequencyEstimation = 0;
        
    let bitsPrecision = 2 * bits + 1;

    use eigenStateRegister = Qubit[bits];
        
    let eigenStateRegisterLittleEndian = LittleEndian(eigenStateRegister);

    ApplyXorInPlace(1, eigenStateRegisterLittleEndian);
    
    let oracle = FTO(randomGenerator, module, _, _);

        use a = Qubit();
        for index in bitsPrecision -1..-1..0 {
            within {
                H(a);
            } apply {
                Controlled oracle([a], (1 <<< index, eigenStateRegisterLittleEndian!));
                R1Frac(frequencyEstimation, bitsPrecision - 1 - index, a);
            } if MResetZ(a) == One {
                set frequencyEstimation += 1 <<< (bitsPrecision - 1 - index);
            }
        }
        ResetAll(eigenStateRegister);
        return frequencyEstimation;
    }

    // Phase 5: Compute Quantum Phase Estimation Algorithm
    operation QPE (randomGenerator: Int, module: Int ) : Int {
    // Quantum Phase Estimation Algorithm
        
    Fact(IsCoprimeI(randomGenerator,module),"El numero aleatorio es `randomGenerator` y el modulo es `module`.");

    mutable result = 1;

    let bits = BitSizeI(module);

    let bitsPrecision = 2 * bits + 1;

    mutable frequencyEstimation = 0;

    set frequencyEstimation = EFV(randomGenerator, module,bits);
        
        if  frequencyEstimation != 0 {
            set result = periodFrequency (module, frequencyEstimation, bitsPrecision, result);
        } else {
            Message("La frecuencia estimada tiene el valor 0.");
        }
        return result;
    }

    // Phase 6: Algorithms Integration
    @EntryPoint()
    operation ShorAlgorithm (n: Int): (Int, Int) {

        if n % 2 == 0 {
            Message("Caso trivial: El número es par.");
            return (n/2, 2);
        }
        
        mutable setUpFactors = false;
        mutable defaultFactors = (1,1); 
    
        repeat {
            let randomGenerator = RNM(2, n - 1);

            if IsCoprimeI (randomGenerator,n) {
                Message($"Número aleatorio: {randomGenerator}");
                let r = QPE(randomGenerator, n);
                set (setUpFactors,defaultFactors) = FPF(n, randomGenerator, r);
            }  else {
                let GCD = GCD_M3(n,randomGenerator);
                Message($"Divisor obtenido: {n}, GCD: {GCD}.");
                set setUpFactors = true;
                set defaultFactors = (GCD, n/ GCD);
            }
        } until setUpFactors 
        fixup {
        Message("La estimación del periodo no retorna un factor valido.");
        }
        return defaultFactors;
    }
    
}