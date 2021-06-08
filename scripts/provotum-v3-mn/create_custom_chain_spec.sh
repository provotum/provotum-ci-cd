#!/bin/bash

set -e

cp ../../ansible/roles/provotum-v3-mn-server-inst/files/customSpecDefault.json ../../ansible/roles/provotum-v3-mn-server-inst/files/customSpec.json

echo "Add va keys"

aura=`cat ../../ansible/roles/provotum-v3-mn-server-inst/files/server`

echo "$( jq ".genesis.runtime.palletBalances.balances[.genesis.runtime.palletBalances.balances | length] |= . +  [\"$aura\", 1152921504606846976]" "../../ansible/roles/provotum-v3-mn-server-inst/files/customSpec.json" )" > ../../ansible/roles/provotum-v3-mn-server-inst/files/customSpec.json

echo "$( jq ".genesis.runtime.palletMixnet.votingAuthorities[.genesis.runtime.palletMixnet.votingAuthorities | length] |= . + \"$aura\""  "../../ansible/roles/provotum-v3-mn-server-inst/files/customSpec.json" )" > ../../ansible/roles/provotum-v3-mn-server-inst/files/customSpec.json

echo "Add sealer keys"

for filename in ../../ansible/roles/provotum-v3-mn-server-inst/files/sealer*; do

    aura_sealer=`awk 'FNR == 1' $filename`
    grandpa_sealer=`awk 'FNR == 2' $filename`

    echo "$( jq ".genesis.runtime.palletAura.authorities[.genesis.runtime.palletAura.authorities | length] |= . +  \"$aura_sealer\"" "../../ansible/roles/provotum-v3-mn-server-inst/files/customSpec.json" )" > ../../ansible/roles/provotum-v3-mn-server-inst/files/customSpec.json

    echo "$( jq ".genesis.runtime.palletGrandpa.authorities[.genesis.runtime.palletGrandpa.authorities | length] |= . + [\"$grandpa_sealer\", 1]"  "../../ansible/roles/provotum-v3-mn-server-inst/files/customSpec.json" )" > ../../ansible/roles/provotum-v3-mn-server-inst/files/customSpec.json

    echo "$( jq ".genesis.runtime.palletBalances.balances[.genesis.runtime.palletBalances.balances | length] |= . + [\"$aura_sealer\", 1152921504606846976]"  "../../ansible/roles/provotum-v3-mn-server-inst/files/customSpec.json" )" > ../../ansible/roles/provotum-v3-mn-server-inst/files/customSpec.json

    echo "$( jq ".genesis.runtime.palletMixnet.sealers[.genesis.runtime.palletMixnet.sealers | length] |= . +  \"$aura_sealer\"" "../../ansible/roles/provotum-v3-mn-server-inst/files/customSpec.json" )" > ../../ansible/roles/provotum-v3-mn-server-inst/files/customSpec.json
done

echo "Add sudo key"

sudo_key=`awk 'FNR == 1' ../../ansible/roles/provotum-v3-mn-server-inst/files/sealer0`

echo "$( jq ".genesis.runtime.palletSudo.key=\"$sudo_key\""  "../../ansible/roles/provotum-v3-mn-server-inst/files/customSpec.json" )" > ../../ansible/roles/provotum-v3-mn-server-inst/files/customSpec.json

echo "Successfully created custom chain spec"
