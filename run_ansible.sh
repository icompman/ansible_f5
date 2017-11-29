#!/bin/bash

while test $# -gt 0; do
        case "$1" in
                -h|--help)
                        echo " "
                        echo "options:"
                        echo "-h, --help                show brief help"
                        echo "-a, --all                 run the site playbook"
                        echo "-n, --onboarding          run the onboarding playbook"
                        echo "-o, --operation           run the operation playbook"
                        echo "-t, --teardown            run the teardown playbook"
                        echo "--today                   run the today playbook"
                        exit 0
                        ;;
                -n)
                        shift
                        ansible-playbook playbooks/onboarding.yml --ask-vault-pass -e @password.yml -vvv 
                        shift
                        ;;
                --onboarding*)
                        ansible-playbook playbooks/onboarding.yml --ask-vault-pass -e @password.yml -vvv 
                        shift
                        ;;
                -o)
                        ansible-playbook playbooks/operations.yml --ask-vault-pass -e @password.yml -e state="present" -vvv 
                        python ./post_slack.py "Ansible Automation :: Setting up F5, created nodes, pool and virtual server. You may access the application at http://10.1.10.88"
                        shift
                        ;;
                --operation*)
                        ansible-playbook playbooks/operations.yml --ask-vault-pass -e @password.yml -e state="present" -vvv 
			python ./post_slack.py "Ansible Automation :: Setting up F5, created nodes, pool and virtual server. You may access the application at http://10.1.10.88"
                        shift
                        ;;
                -mon)
                        ansible-playbook playbooks/maintenance.yml --ask-vault-pass -e @password.yml -e state="present" -vvv 
                        python ./post_slack.py "Ansible Automation :: Put up annoucement page. All visitors will see the notification page."
                        shift
                        ;;                        

                -moff)
                        ansible-playbook playbooks/maintenance_off.yml --ask-vault-pass -e @password.yml -e state="present" -vvv 
                        python ./post_slack.py "Ansible Automation :: Removed announcement page!"
                        shift
                        ;;                        
                -t)
                        ansible-playbook playbooks/operations.yml --ask-vault-pass -e @password.yml -e state="absent" -vvv 
			python ./post_slack.py "Ansible Automation :: Tearing down F5 setup, removed nodes, pool and virtual server."
                        shift
                        ;;
                --teardown*)
                        ansible-playbook playbooks/operations.yml --ask-vault-pass -e @password.yml -e state="absent" -vvv 
			python ./post_slack.py "Ansible Automation :: Tearing down F5 setup, removed nodes, pool and virtual server."
                        shift
                        ;;
                --today*)
                        ansible-playbook playbooks/today.yml --ask-vault-pass -e @password.yml -vvv 
                        shift
                        ;;
                -d)
                        ansible-galaxy init roles/$(date +%m%d%Y) && cd roles; ln -sfn $(date +%m%d%Y) today;cd .. 
                        shift
                        ;;
                --date*)
                        ansible-galaxy init roles/$(date +%m%d%Y) && cd roles; ln -sfn $(date +%m%d%Y) today;cd .. 
                        shift
                        ;;
                -a)
                        ansible-playbook playbooks/onboarding.yml --ask-vault-pass -e @password.yml -vvv 
                        ansible-playbook playbooks/operations.yml --ask-vault-pass -e @password.yml -e state="present" -vvv 
                        shift
                        ;;
                --all*)
                        ansible-playbook playbooks/onboarding.yml --ask-vault-pass -e @password.yml -vvv 
                        ansible-playbook playbooks/operations.yml --ask-vault-pass -e @password.yml -e state="present" -vvv 
                        shift
                        ;;
                *)
                        break
                        ;;
        esac
done
