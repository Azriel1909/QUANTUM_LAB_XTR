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

[assembly: CallableDeclaration("{\"Kind\":{\"Case\":\"Operation\"},\"QualifiedName\":{\"Namespace\":\"Shor_Algo\",\"Name\":\"testRandoNumber\"},\"Attributes\":[{\"TypeId\":{\"Case\":\"Value\",\"Fields\":[{\"Namespace\":\"Microsoft.Quantum.Core\",\"Name\":\"EntryPoint\",\"Range\":{\"Case\":\"Value\",\"Fields\":[{\"Item1\":{\"Line\":1,\"Column\":2},\"Item2\":{\"Line\":1,\"Column\":12}}]}}]},\"TypeIdRange\":{\"Case\":\"Value\",\"Fields\":[{\"Item1\":{\"Line\":1,\"Column\":2},\"Item2\":{\"Line\":1,\"Column\":12}}]},\"Argument\":{\"Item1\":{\"Case\":\"UnitValue\"},\"Item2\":[],\"Item3\":{\"Case\":\"UnitType\"},\"Item4\":{\"IsMutable\":false,\"HasLocalQuantumDependency\":false},\"Item5\":{\"Case\":\"Value\",\"Fields\":[{\"Item1\":{\"Line\":1,\"Column\":12},\"Item2\":{\"Line\":1,\"Column\":14}}]}},\"Offset\":{\"Item1\":30,\"Item2\":4},\"Comments\":{\"OpeningComments\":[\" Q# compiler\"],\"ClosingComments\":[]}}],\"Modifiers\":{\"Access\":{\"Case\":\"DefaultAccess\"}},\"SourceFile\":\"/home/ximena/Documents/CODING/QUANTUM_LAB_XTR/Shor Algo/Program.qs\",\"Position\":{\"Item1\":31,\"Item2\":4},\"SymbolRange\":{\"Item1\":{\"Line\":1,\"Column\":11},\"Item2\":{\"Line\":1,\"Column\":26}},\"ArgumentTuple\":{\"Case\":\"QsTuple\",\"Fields\":[[{\"Case\":\"QsTupleItem\",\"Fields\":[{\"VariableName\":{\"Case\":\"ValidName\",\"Fields\":[\"min\"]},\"Type\":{\"Case\":\"Int\"},\"InferredInformation\":{\"IsMutable\":false,\"HasLocalQuantumDependency\":false},\"Position\":{\"Case\":\"Null\"},\"Range\":{\"Item1\":{\"Line\":1,\"Column\":27},\"Item2\":{\"Line\":1,\"Column\":30}}}]},{\"Case\":\"QsTupleItem\",\"Fields\":[{\"VariableName\":{\"Case\":\"ValidName\",\"Fields\":[\"max\"]},\"Type\":{\"Case\":\"Int\"},\"InferredInformation\":{\"IsMutable\":false,\"HasLocalQuantumDependency\":false},\"Position\":{\"Case\":\"Null\"},\"Range\":{\"Item1\":{\"Line\":1,\"Column\":36},\"Item2\":{\"Line\":1,\"Column\":39}}}]}]]},\"Signature\":{\"TypeParameters\":[],\"ArgumentType\":{\"Case\":\"TupleType\",\"Fields\":[[{\"Case\":\"Int\"},{\"Case\":\"Int\"}]]},\"ReturnType\":{\"Case\":\"Int\"},\"Information\":{\"Characteristics\":{\"Case\":\"EmptySet\"},\"InferredInformation\":{\"IsSelfAdjoint\":false,\"IsIntrinsic\":false}}},\"Documentation\":[]}")]
[assembly: SpecializationDeclaration("{\"Kind\":{\"Case\":\"QsBody\"},\"TypeArguments\":{\"Case\":\"Null\"},\"Information\":{\"Characteristics\":{\"Case\":\"EmptySet\"},\"InferredInformation\":{\"IsSelfAdjoint\":false,\"IsIntrinsic\":false}},\"Parent\":{\"Namespace\":\"Shor_Algo\",\"Name\":\"testRandoNumber\"},\"Attributes\":[],\"SourceFile\":\"/home/ximena/Documents/CODING/QUANTUM_LAB_XTR/Shor Algo/Program.qs\",\"Position\":{\"Item1\":31,\"Item2\":4},\"HeaderRange\":{\"Item1\":{\"Line\":1,\"Column\":11},\"Item2\":{\"Line\":1,\"Column\":26}},\"Documentation\":[]}")]
#line hidden
namespace Shor_Algo
{
    [SourceLocation("/home/ximena/Documents/CODING/QUANTUM_LAB_XTR/Shor Algo/Program.qs", OperationFunctor.Body, 32, -1)]
    public partial class testRandoNumber : Operation<(Int64,Int64), Int64>, ICallable
    {
        public testRandoNumber(IOperationFactory m) : base(m)
        {
        }

        public class In : QTuple<(Int64,Int64)>, IApplyData
        {
            public In((Int64,Int64) data) : base(data)
            {
            }

            System.Collections.Generic.IEnumerable<Qubit> IApplyData.Qubits => null;
        }

        String ICallable.Name => "testRandoNumber";
        String ICallable.FullName => "Shor_Algo.testRandoNumber";
        public static EntryPointInfo<(Int64,Int64), Int64> Info => new EntryPointInfo<(Int64,Int64), Int64>(typeof(testRandoNumber));
        protected ICallable<String, QVoid> Message__
        {
            get;
            set;
        }

        protected ICallable<(Int64,Int64), Int64> self
        {
            get;
            set;
        }

        public override Func<(Int64,Int64), Int64> __Body__ => (__in__) =>
        {
            var (min,max) = __in__;
#line 33 "/home/ximena/Documents/CODING/QUANTUM_LAB_XTR/Shor Algo/Program.qs"
            Message__.Apply(String.Format("Random number between {0} and {1} ->  ", min, max));
#line 34 "/home/ximena/Documents/CODING/QUANTUM_LAB_XTR/Shor Algo/Program.qs"
            return self.Apply<Int64>((max, min));
        }

        ;
        public override void __Init__()
        {
            this.Message__ = this.__Factory__.Get<ICallable<String, QVoid>>(typeof(global::Microsoft.Quantum.Intrinsic.Message));
            this.self = this;
        }

        public override IApplyData __DataIn__((Int64,Int64) data) => new In(data);
        public override IApplyData __DataOut__(Int64 data) => new QTuple<Int64>(data);
        public static System.Threading.Tasks.Task<Int64> Run(IOperationFactory __m__, Int64 min, Int64 max)
        {
            return __m__.Run<testRandoNumber, (Int64,Int64), Int64>((min, max));
        }
    }
}