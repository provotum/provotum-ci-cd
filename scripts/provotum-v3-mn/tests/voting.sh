#!/bin/bash

while getopts v:q:n: flag
do
    case "${flag}" in
        v) vote=${OPTARG};;
        q) question=${OPTARG};;
        n) number_of_votes=${OPTARG};;
    esac
done
echo "Vote: $vote";
echo "Question: $question";
echo "Number of votes: $number_of_votes";

ansible-playbook -u root -i ../../../ansible/provotum-v3-mn-server-inventory --private-key ../../../../.ssh/id_rsa ../../../ansible/provotum-v3-mn-create-vote.yml --extra-vars "vote=${vote} question=${question}";

ansible-playbook -u root -i ../../../ansible/provotum-v3-mn-sealer-inventory --private-key ../../../../.ssh/id_rsa ../../../ansible/provotum-v3-mn-sealer-keygen.yml --extra-vars "vote=${vote}";

ansible-playbook -u root -i ../../../ansible/provotum-v3-mn-server-inventory --private-key ../../../../.ssh/id_rsa ../../../ansible/provotum-v3-mn-combine-pk-shares.yml --extra-vars "vote=${vote}";

ansible-playbook -u root -i ../../../ansible/provotum-v3-mn-server-inventory --private-key ../../../../.ssh/id_rsa ../../../ansible/provotum-v3-mn-vote.yml --extra-vars "vote=${vote} question=${question} votes=1 nrVotes=${number_of_votes}";

ansible-playbook -u root -i ../../../ansible/provotum-v3-mn-server-inventory --private-key ../../../../.ssh/id_rsa ../../../ansible/provotum-v3-mn-set-phase.yml --extra-vars "vote=${vote} phase=Tallying";

while [ "$(ansible-playbook -u root -i ../../../ansible/provotum-v3-mn-sealer-inventory --private-key ../../../../.ssh/id_rsa ../../../ansible/provotum-v3-mn-sealer-decrypt.yml --extra-vars "vote=${vote} question=${question}" 2>&1 | grep -q 'failed to fetch cipher' ; echo $?)" = 0 ]; do
  echo 'waiting for mixing...'
  sleep 0.1
done

sleep 20

ansible-playbook -u root -i ../../../ansible/provotum-v3-mn-sealer-inventory --private-key ../../../../.ssh/id_rsa ../../../ansible/provotum-v3-mn-sealer-decrypt.yml --extra-vars "vote=${vote} question=${question}"

ansible-playbook -u root -i ../../../ansible/provotum-v3-mn-server-inventory --private-key ../../../../.ssh/id_rsa ../../../ansible/provotum-v3-mn-tally.yml --extra-vars "vote=${vote} question=${question}";

ansible-playbook -u root -i ../../../ansible/provotum-v3-mn-server-inventory --private-key ../../../../.ssh/id_rsa ../../../ansible/provotum-v3-mn-result.yml --extra-vars "question=${question}";
