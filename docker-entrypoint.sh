#!/bin/bash

set -xe

if [ ! -d /UO/ServUO ]; then
    git clone https://github.com/ServUO/ServUO /UO/ServUO
fi
chown -R uo:uo /UO
cd /UO/ServUO
sed -i -- 's/CompilerResults results = provider.CompileAssemblyFromFile( parms, "" );/CompilerResults results = provider.CompileAssemblyFromFile( parms, files );/g' ./Server/ScriptCompiler.cs
echo "CustomPath=/client" >> /UO/ServUO/Config/DataPath.cfg
if [ ! -f /UO/ServUO/Scripts/Misc/AccountPrompt.cs ]; then
    cp /AccountPrompt.cs /UO/ServUO/Scripts/Misc/
fi
rm /AccountPrompt.cs
make clean && make build
exec gosu uo /UO/ServUO/ServUO.sh
