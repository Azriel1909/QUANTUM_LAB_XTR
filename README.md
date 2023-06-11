# Shor Algorithm: Azure Quantum Implementation

## What's the Quantum Development Kit (QDK)?

The Quantum Development Kit (QDK) is the SDK required to interface with the Azure Quantum service. It is built-in to the Azure Quantum portal, where you can develop programs using the free hosted Jupyter Notebooks. You can also install the QDK locally on your computer to use your own local development environment and work both online and offline with the Azure Quantum service. 

The QDK includes the quantum programming language Q#, a high-level, open-source programming language that allows you to focus your work at the algorithm and application level to create quantum programs.

[See more](https://learn.microsoft.com/en-us/azure/quantum/overview-what-is-qsharp-and-qdk)

## Requirements
1. [.NET SDK 6.0](https://dotnet.microsoft.com/en-us/download)
2. [Visual Studio Code](https://code.visualstudio.com/)
3. [Microsoft Quantum Development Kit](https://marketplace.visualstudio.com/items?itemName=quantum.quantum-devkit-vscode)

For linux users
1. Please make sure that the ```libgomp``` library is installed on your system

```bash
sudo apt install libgomp1
```

## How to run the code in the QDK?

1. Go to ```ShorAlgoClasicImplementation``` Folder

```
cd ShorAlgoClasicImplementation/
```
2. Run the following command in your shell

```
dotnet run -n#
```
n refers to a number, example:

```
dotnet run -n15
```
By Ximena Toledo


 