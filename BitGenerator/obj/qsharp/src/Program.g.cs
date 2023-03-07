//------------------------------------------------------------------------------
// <auto-generated>                                                             
//     This code was generated by a tool.                                       
//     Changes to this file may cause incorrect behavior and will be lost if    
//     the code is regenerated.                                                 
// </auto-generated>                                                            
//------------------------------------------------------------------------------
#pragma warning disable 436
#pragma warning disable 162
#pragma warning disable 1591
using System;
using Microsoft.Quantum.Core;
using Microsoft.Quantum.Intrinsic;
using Microsoft.Quantum.Intrinsic.Interfaces;
using Microsoft.Quantum.Simulation.Core;

[assembly: CallableDeclaration("{\"Kind\":{\"Case\":\"Operation\"},\"QualifiedName\":{\"Namespace\":\"BitGenerator\",\"Name\":\"GenerateSpecificState\"},\"Attributes\":[{\"TypeId\":{\"Case\":\"Value\",\"Fields\":[{\"Namespace\":\"Microsoft.Quantum.Core\",\"Name\":\"EntryPoint\",\"Range\":{\"Case\":\"Value\",\"Fields\":[{\"Item1\":{\"Line\":1,\"Column\":2},\"Item2\":{\"Line\":1,\"Column\":12}}]}}]},\"TypeIdRange\":{\"Case\":\"Value\",\"Fields\":[{\"Item1\":{\"Line\":1,\"Column\":2},\"Item2\":{\"Line\":1,\"Column\":12}}]},\"Argument\":{\"Item1\":{\"Case\":\"UnitValue\"},\"Item2\":[],\"Item3\":{\"Case\":\"UnitType\"},\"Item4\":{\"IsMutable\":false,\"HasLocalQuantumDependency\":false},\"Item5\":{\"Case\":\"Value\",\"Fields\":[{\"Item1\":{\"Line\":1,\"Column\":12},\"Item2\":{\"Line\":1,\"Column\":14}}]}},\"Offset\":{\"Item1\":8,\"Item2\":4},\"Comments\":{\"OpeningComments\":[],\"ClosingComments\":[]}}],\"Modifiers\":{\"Access\":{\"Case\":\"DefaultAccess\"}},\"SourceFile\":\"/home/ximena/Documents/CODING/QUANTUM_LAB_XTR/BitGenerator/Program.qs\",\"Position\":{\"Item1\":9,\"Item2\":4},\"SymbolRange\":{\"Item1\":{\"Line\":1,\"Column\":11},\"Item2\":{\"Line\":1,\"Column\":32}},\"ArgumentTuple\":{\"Case\":\"QsTuple\",\"Fields\":[[{\"Case\":\"QsTupleItem\",\"Fields\":[{\"VariableName\":{\"Case\":\"ValidName\",\"Fields\":[\"alpha\"]},\"Type\":{\"Case\":\"Double\"},\"InferredInformation\":{\"IsMutable\":false,\"HasLocalQuantumDependency\":false},\"Position\":{\"Case\":\"Null\"},\"Range\":{\"Item1\":{\"Line\":1,\"Column\":33},\"Item2\":{\"Line\":1,\"Column\":38}}}]}]]},\"Signature\":{\"TypeParameters\":[],\"ArgumentType\":{\"Case\":\"Double\"},\"ReturnType\":{\"Case\":\"Result\"},\"Information\":{\"Characteristics\":{\"Case\":\"EmptySet\"},\"InferredInformation\":{\"IsSelfAdjoint\":false,\"IsIntrinsic\":false}}},\"Documentation\":[]}")]
[assembly: SpecializationDeclaration("{\"Kind\":{\"Case\":\"QsBody\"},\"TypeArguments\":{\"Case\":\"Null\"},\"Information\":{\"Characteristics\":{\"Case\":\"EmptySet\"},\"InferredInformation\":{\"IsSelfAdjoint\":false,\"IsIntrinsic\":false}},\"Parent\":{\"Namespace\":\"BitGenerator\",\"Name\":\"GenerateSpecificState\"},\"Attributes\":[],\"SourceFile\":\"/home/ximena/Documents/CODING/QUANTUM_LAB_XTR/BitGenerator/Program.qs\",\"Position\":{\"Item1\":9,\"Item2\":4},\"HeaderRange\":{\"Item1\":{\"Line\":1,\"Column\":11},\"Item2\":{\"Line\":1,\"Column\":32}},\"Documentation\":[]}")]
#line hidden
namespace BitGenerator
{
    [SourceLocation("/home/ximena/Documents/CODING/QUANTUM_LAB_XTR/BitGenerator/Program.qs", OperationFunctor.Body, 10, -1)]
    public partial class GenerateSpecificState : Operation<Double, Result>, ICallable
    {
        public GenerateSpecificState(IOperationFactory m) : base(m)
        {
        }

        String ICallable.Name => "GenerateSpecificState";
        String ICallable.FullName => "BitGenerator.GenerateSpecificState";
        public static EntryPointInfo<Double, Result> Info => new EntryPointInfo<Double, Result>(typeof(GenerateSpecificState));
        protected Allocate Allocate__
        {
            get;
            set;
        }

        protected Release Release__
        {
            get;
            set;
        }

        protected IUnitary<(Double,Qubit)> Microsoft__Quantum__Intrinsic__Ry
        {
            get;
            set;
        }

        protected ICallable<Double, Double> Microsoft__Quantum__Math__ArcCos
        {
            get;
            set;
        }

        protected ICallable<Double, Double> Microsoft__Quantum__Math__Sqrt
        {
            get;
            set;
        }

        protected ICallable<String, QVoid> Message__
        {
            get;
            set;
        }

        protected ICallable Microsoft__Quantum__Diagnostics__DumpMachine
        {
            get;
            set;
        }

        protected ICallable<Qubit, Result> Microsoft__Quantum__Intrinsic__M
        {
            get;
            set;
        }

        public override Func<Double, Result> __Body__ => (__in__) =>
        {
            var alpha = __in__;
#line hidden
            {
#line 11 "/home/ximena/Documents/CODING/QUANTUM_LAB_XTR/BitGenerator/Program.qs"
                var q = Allocate__.Apply();
#line hidden
                bool __arg1__ = true;
                try
                {
#line 12 "/home/ximena/Documents/CODING/QUANTUM_LAB_XTR/BitGenerator/Program.qs"
                    Microsoft__Quantum__Intrinsic__Ry.Apply(((2D * Microsoft__Quantum__Math__ArcCos.Apply(Microsoft__Quantum__Math__Sqrt.Apply(alpha))), q));
#line 13 "/home/ximena/Documents/CODING/QUANTUM_LAB_XTR/BitGenerator/Program.qs"
                    Message__.Apply("The qubit is in the desired state.");
#line 14 "/home/ximena/Documents/CODING/QUANTUM_LAB_XTR/BitGenerator/Program.qs"
                    Message__.Apply("");
#line 15 "/home/ximena/Documents/CODING/QUANTUM_LAB_XTR/BitGenerator/Program.qs"
                    Microsoft__Quantum__Diagnostics__DumpMachine.Apply(QVoid.Instance);
#line 16 "/home/ximena/Documents/CODING/QUANTUM_LAB_XTR/BitGenerator/Program.qs"
                    Message__.Apply("");
#line 17 "/home/ximena/Documents/CODING/QUANTUM_LAB_XTR/BitGenerator/Program.qs"
                    Message__.Apply("Your skewed random bit is:");
#line 18 "/home/ximena/Documents/CODING/QUANTUM_LAB_XTR/BitGenerator/Program.qs"
                    return Microsoft__Quantum__Intrinsic__M.Apply(q);
                }
#line hidden
                catch
                {
                    __arg1__ = false;
                    throw;
                }
#line hidden
                finally
                {
                    if (__arg1__)
                    {
#line hidden
                        Release__.Apply(q);
                    }
                }
            }
        }

        ;
        public override void __Init__()
        {
            this.Allocate__ = this.__Factory__.Get<Allocate>(typeof(global::Microsoft.Quantum.Intrinsic.Allocate));
            this.Release__ = this.__Factory__.Get<Release>(typeof(global::Microsoft.Quantum.Intrinsic.Release));
            this.Microsoft__Quantum__Intrinsic__Ry = this.__Factory__.Get<IUnitary<(Double,Qubit)>>(typeof(global::Microsoft.Quantum.Intrinsic.Ry));
            this.Microsoft__Quantum__Math__ArcCos = this.__Factory__.Get<ICallable<Double, Double>>(typeof(global::Microsoft.Quantum.Math.ArcCos));
            this.Microsoft__Quantum__Math__Sqrt = this.__Factory__.Get<ICallable<Double, Double>>(typeof(global::Microsoft.Quantum.Math.Sqrt));
            this.Message__ = this.__Factory__.Get<ICallable<String, QVoid>>(typeof(global::Microsoft.Quantum.Intrinsic.Message));
            this.Microsoft__Quantum__Diagnostics__DumpMachine = this.__Factory__.Get<ICallable>(typeof(global::Microsoft.Quantum.Diagnostics.DumpMachine<>));
            this.Microsoft__Quantum__Intrinsic__M = this.__Factory__.Get<ICallable<Qubit, Result>>(typeof(global::Microsoft.Quantum.Intrinsic.M));
        }

        public override IApplyData __DataIn__(Double data) => new QTuple<Double>(data);
        public override IApplyData __DataOut__(Result data) => new QTuple<Result>(data);
        public static System.Threading.Tasks.Task<Result> Run(IOperationFactory __m__, Double alpha)
        {
            return __m__.Run<GenerateSpecificState, Double, Result>(alpha);
        }
    }
}