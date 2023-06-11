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

## What's Azure Quantum?

Azure Quantum is a Microsoft Azure cloud service for running quantum computing programs and solving optimization problems. Azure Quantum provides the best development environment to create quantum algorithms for multiple platforms at once while preserving flexibility to tune the same algorithms for specific systems. 

[See more](https://learn.microsoft.com/en-us/azure/quantum/overview-azure-quantum)

## Requirements
1. Sign in to the [Azure Portal](https://portal.azure.com/)
2. Azure Subscription
3. Azure Storage Account
  
## How to run the code in Azure Quantum?
1. Download the ```QuantumSuperpositionTest.ipynb``` in the ```Notebooks``` folder
2. Go to Azure Portal 
3. Select your Azure Quantum Workspace
4. Go to ```operations``` and select ```Notebooks``` 
5. Upload the ```QuantumSuperpositionTest.ipynb``` file
6. Execute all cells

```
ctrl + Enter
```
## Commands
1. ```%simulate``` Runs a operation on the QuantumSimulator target machine.
2. ```%azure.target``` Specifying the execution target for Q# job submission in an Azure Quantum workspace.
3. ```%azure.execute``` Submits a job to an Azure Quantum workspace.
4. ```%azure.jobs``` Displays a list of jobs in the current Azure Quantum workspace.

By Ximena Toledo


 