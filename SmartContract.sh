
# create contract project
mkdir NeoContractDemo
dotnet new library -o=NeoContractDemo
dotnet add ./NeoContractDemo/NeoContractDemo.csproj package Neo.SmartContract.Framework --version 2.5.4
rm ./NeoContractDemo/Class1.cs

# input contract code
echo "
using Neo.SmartContract.Framework;
using Neo.SmartContract.Framework.Services.Neo;

public class NeoContractDemo: SmartContract
{
    public static bool Main()
    {
        return true;
    }
}
" > ./NeoContractDemo/NeoContractDemo.cs

# build contract
cd ./NeoContractDemo
dotnet publish -o ../testlib
cd ..

# compile neo-compiler project
git clone https://github.com/neo-project/neo-compiler.git
cd  ./neo-compiler/neon
dotnet publish -o ../../testlib
cd ../..

# compile neo contract to avm
cd testlib
dotnet ./neon.dll ./NeoContractDemo.dll
cd ..

# copy out result
mkdir output
cp ./testlib/NeoContractDemo.avm ./output/NeoContractDemo.avm

