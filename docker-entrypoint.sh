#!/bin/bash

set -xe

cd /UO/ServUO

if [ ! -d /UO/ServUO ]; then
    git clone https://github.com/ServUO/ServUO /UO/ServUO
    cp /AccountPrompt.cs /UO/ServUO/Scripts/Misc/
else
    git pull -f
fi

chown -R uo:uo /UO

sed -i -- 's/CompilerResults results = provider.CompileAssemblyFromFile( parms, "" );/CompilerResults results = provider.CompileAssemblyFromFile( parms, files );/g' ./Server/ScriptCompiler.cs
sed -i -- 's,#CustomPath.*,CustomPath=/client,g' ./Config/DataPath.cfg

make clean && make build
exec gosu uo /UO/ServUO/ServUO.sh
